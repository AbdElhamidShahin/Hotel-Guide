import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/network/model/notification_model.dart';
import '../../../core/network/model/profile_model.dart';
import 'wallet_repo.dart';

class WalletRepositoryImpl implements WalletRepository {
  final SupabaseClient _supabase;
  const WalletRepositoryImpl(this._supabase);

  // ── Fetch all wallet data in parallel ─────────────────────────────────────

  @override
  Future<Either<Failure, WalletDataBundle>> getWalletDetails() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        return const Left(ServerFailure(errorMessage: 'يرجى تسجيل الدخول أولاً'));
      }

      // Use maybeSingle() — never crashes with PGRST116 when RLS blocks the row
      final profileRaw = await _supabase
          .from(AppTableNames.profiles)
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (profileRaw == null) {
        return const Left(ServerFailure(
          errorMessage:
          'تعذّر تحميل بيانات المحفظة.\n'
              'تأكد من إعداد سياسات RLS على جدول profiles في Supabase.',
        ));
      }

      // Fetch payments and top-ups in parallel for performance
      final results = await Future.wait([
        _supabase
            .from(AppTableNames.walletTransactions)
            .select()
            .eq('user_id', userId)
            .eq('type', 'payment')
            .order('created_at', ascending: false),
        _supabase
            .from(AppTableNames.walletTransactions)
            .select()
            .eq('user_id', userId)
            .inFilter('type', ['top_up', 'recharge'])
            .order('created_at', ascending: false),
      ]);

      return Right(WalletDataBundle(
        profile: UserProfileModel.fromMap(profileRaw),
        payments: List<Map<String, dynamic>>.from(results[0] as List),
        topUps: List<Map<String, dynamic>>.from(results[1] as List),
      ));
    } on PostgrestException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  // ── Top-Up ────────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, void>> topUpBalance(double amount) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        return const Left(ServerFailure(errorMessage: 'يرجى تسجيل الدخول أولاً'));
      }

      // Try RPC first (atomic: balance + transaction + notification in one DB tx)
      try {
        await _supabase.rpc(
          AppRpcNames.topUpWallet,
          params: {'p_user_id': userId, 'p_amount': amount},
        );
      } on PostgrestException catch (e) {
        // RPC doesn't exist yet → fall back to manual steps
        if (e.code == 'PGRST202' || e.message.contains('does not exist')) {
          await _manualTopUp(userId, amount);
        } else {
          rethrow;
        }
      }

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _manualTopUp(String userId, double amount) async {
    // 1. Read current balance
    final data = await _supabase
        .from(AppTableNames.profiles)
        .select('wallet_balance')
        .eq('id', userId)
        .single();
    final current = (data['wallet_balance'] as num).toDouble();

    // 2. Update balance
    await _supabase
        .from(AppTableNames.profiles)
        .update({'wallet_balance': current + amount})
        .eq('id', userId);

    // 3. Transaction record — type = 'top_up'
    await _supabase.from(AppTableNames.walletTransactions).insert({
      'user_id': userId,
      'amount': amount,
      'type': 'top_up',
      'transaction_type': 'top_up',
      'status': 'completed',
      'description': 'شحن رصيد عبر البطاقة البنكية',
      'created_at': DateTime.now().toIso8601String(),
    });

    // 4. Notification
    await _supabase.from(AppTableNames.notifications).insert(
      NotificationModel(
        title: 'تم شحن الرصيد ✅',
        body: 'تمت إضافة ${amount.toStringAsFixed(2)} EGP إلى محفظتك بنجاح.',
        time: DateTime.now(),
        type: NotificationType.success,
      ).toJson(userId),
    );
  }
}