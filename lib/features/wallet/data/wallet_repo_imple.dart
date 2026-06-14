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

      var profileRaw = await _supabase
          .from(AppTableNames.profiles)
          .select()
          .eq('id', userId)
          .maybeSingle();

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
    final data = await _supabase
        .from(AppTableNames.profiles)
        .select('wallet_balance')
        .eq('id', userId)
        .single();
    final current = (data['wallet_balance'] as num).toDouble();

    final updated = await _supabase
        .from(AppTableNames.profiles)
        .update({'wallet_balance': current + amount})
        .eq('id', userId)
        .select('wallet_balance');

    if (updated == null || (updated as List).isEmpty) {
      throw Exception('فشل تحديث الرصيد — تحقق من RLS على جدول profiles');
    }
    debugPrint('✅ Balance: $current → ${current + amount}');

    await _supabase.from(AppTableNames.walletTransactions).insert({
      'user_id': userId,
      'amount': amount,
      'type': 'top_up',
      'description': 'شحن رصيد عبر البطاقة البنكية',
    });

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

  // ── Realtime Stream ─────────────────────────────────────────────────────────

  // ✅ Fix: stream moved inside the class — was accidentally appended outside
  // the closing brace, causing "missing implementation" and "_supabase undefined" errors.
  @override
  Stream<void> watchWalletChanges(String userId) {
    return _supabase
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .map((_) => null);
  }
}
