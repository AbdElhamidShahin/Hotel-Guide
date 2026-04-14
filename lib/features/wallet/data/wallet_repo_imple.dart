import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/error/failure.dart';
import '../../../core/network/model/notification_model.dart';
import '../../../core/network/model/profile_model.dart';
import 'wallet_repo.dart';

class WalletRepositoryImpl implements WalletRepository {
  final SupabaseClient _supabase;
  const WalletRepositoryImpl(this._supabase);

  // ── Fetch ──────────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, WalletDataBundle>> getWalletDetails() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        return Left(ErrorHandler.handle('يرجى تسجيل الدخول أولا'));
      }

      // ✅ maybeSingle — never throws PGRST116
      var profileRaw = await _supabase
          .from(AppTableNames.profiles)
          .select()
          .eq('id', userId)
          .maybeSingle();

      // ✅ Auto-create profile for Google OAuth users (skipped signUp flow)
      if (profileRaw == null) {
        debugPrint('⚠️ Profile missing for $userId — auto-creating');
        final user = _supabase.auth.currentUser!;
        profileRaw = await _supabase
            .from(AppTableNames.profiles)
            .upsert({
              'id': userId,
              'full_name':
                  user.userMetadata?['full_name'] ??
                  user.userMetadata?['name'] ??
                  'مستخدم جديد',
              'email': user.email ?? '',
              'wallet_balance': 0.0,
            })
            .select()
            .single();
        debugPrint('✅ Profile auto-created');
      }

      // ✅ Fetch payment & top-up in parallel
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

      return Right(
        WalletDataBundle(
          profile: UserProfileModel.fromMap(profileRaw),
          payments: List<Map<String, dynamic>>.from(results[0] as List),
          topUps: List<Map<String, dynamic>>.from(results[1] as List),
        ),
      );
    } on PostgrestException catch (e) {
      debugPrint('❌ getWalletDetails: ${e.message}');
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      debugPrint('❌ getWalletDetails: $e');
      return Left(ErrorHandler.handle(e));
    }
  }

  // ── Top-Up ─────────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, void>> topUpBalance(double amount) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        return Left(ErrorHandler.handle('يرجى تسجيل الدخول أولاً'));
      }

      // Try RPC; fallback on ANY RPC failure
      bool rpcFailed = false;
      try {
        await _supabase.rpc(
          AppRpcNames.topUpWallet,
          params: {'p_user_id': userId, 'p_amount': amount},
        );
        debugPrint('✅ topUp via RPC');
      } on PostgrestException catch (e) {
        rpcFailed = true;
        debugPrint('⚠️ RPC failed (${e.message}) → manual fallback');
      }

      if (rpcFailed) await _manualTopUp(userId, amount);
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<void> _manualTopUp(String userId, double amount) async {
    // 1. Read balance
    final data = await _supabase
        .from(AppTableNames.profiles)
        .select('wallet_balance')
        .eq('id', userId)
        .single();
    final current = (data['wallet_balance'] as num).toDouble();

    // 2. Update — .select() detects silent RLS block
    final updated = await _supabase
        .from(AppTableNames.profiles)
        .update({'wallet_balance': current + amount})
        .eq('id', userId)
        .select('wallet_balance');

    if (updated == null || (updated as List).isEmpty) {
      throw Exception('فشل تحديث الرصيد — تحقق من RLS على جدول profiles');
    }
    debugPrint('✅ Balance: $current → ${current + amount}');

    // 3. Transaction — 'type' ONLY (no duplicate 'transaction_type')
    await _supabase.from(AppTableNames.walletTransactions).insert({
      'user_id': userId,
      'amount': amount,
      'type': 'top_up',
      'description': 'شحن رصيد عبر البطاقة البنكية',
    });

    // 4. Notification
    await _supabase
        .from(AppTableNames.notifications)
        .insert(
          NotificationModel(
            title: 'تم شحن الرصيد ✅',
            body: 'تمت إضافة ${amount.toStringAsFixed(0)} EGP إلى محفظتك.',
            time: DateTime.now(),
            type: NotificationType.success,
          ).toJson(userId),
        );
    debugPrint('✅ Manual topUp complete');
  }
}
