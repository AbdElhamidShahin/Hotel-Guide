import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        return const Left(AuthFailure('يرجى تسجيل الدخول أولا'));
      }

      var profileRaw = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (profileRaw == null) {
        debugPrint('⚠️ Profile missing for $userId — auto-creating');
        final user = _supabase.auth.currentUser!;
        profileRaw = await _supabase
            .from('profiles')
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
        // ✅ Fix: بدل ما نجيب wallet_transactions بس،
        // بنعمل join مع bookings عبر booking_id
        // عشان نجيب hotel_name و check_in و check_out و room_id
        _supabase
            .from('wallet_transactions')
            .select('''
              *,
              bookings!booking_id (
                hotel_name,
                check_in,
                check_out,
                room_id,
                status
              )
            ''')
            .eq('user_id', userId)
            .eq('type', 'payment')
            .order('created_at', ascending: false),

        _supabase
            .from('wallet_transactions')
            .select()
            .eq('user_id', userId)
            .inFilter('type', ['top_up', 'recharge'])
            .order('created_at', ascending: false),
      ]);

      // ✅ Fix: بعد الجلب، نـ flatten الـ bookings join
      // عشان الـ UI يقدر يوصل لـ hotel_name و check_in و check_out مباشرة
      final rawPayments = List<Map<String, dynamic>>.from(results[0] as List);
      final flatPayments = rawPayments.map((txn) {
        final booking = txn['bookings'] as Map<String, dynamic>?;
        return {
          ...txn,
          // لو الـ booking مش null، نكتب قيمه فوق قيم الـ transaction
          'hotel_name': booking?['hotel_name'] ?? txn['hotel_name'] ?? '—',
          'check_in': booking?['check_in'] ?? txn['booking_date'] ?? '',
          'check_out': booking?['check_out'] ?? '',
          'room_id': booking?['room_id'] ?? '',
          // الحالة من bookings أدق من wallet_transactions
          'booking_status': booking?['status'] ?? txn['status'] ?? '',
        };
      }).toList();

      return Right(
        WalletDataBundle(
          profile: UserProfileModel.fromMap(profileRaw),
          payments: flatPayments,
          topUps: List<Map<String, dynamic>>.from(results[1] as List),
        ),
      );
    } on PostgrestException catch (e) {
      debugPrint('❌ getWalletDetails: ${e.message}');
      return Left(SupabaseFailure.fromSupabaseError(e));
    } catch (e) {
      debugPrint('❌ getWalletDetails: $e');
      return Left(SupabaseFailure.fromGenericError(e));
    }
  }

  // ── Top-Up ─────────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, void>> topUpBalance(double amount) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        return const Left(AuthFailure('يرجى تسجيل الدخول أولاً'));
      }

      bool rpcFailed = false;
      try {
        await _supabase.rpc(
          'top_up_wallet',
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
      return Left(SupabaseFailure.fromSupabaseError(e));
    } catch (e) {
      return Left(SupabaseFailure.fromGenericError(e));
    }
  }

  Future<void> _manualTopUp(String userId, double amount) async {
    final data = await _supabase
        .from('profiles')
        .select('wallet_balance')
        .eq('id', userId)
        .single();
    final current = (data['wallet_balance'] as num).toDouble();

    final updated = await _supabase
        .from('profiles')
        .update({'wallet_balance': current + amount})
        .eq('id', userId)
        .select('wallet_balance');

    if (updated == null || (updated as List).isEmpty) {
      throw Exception('فشل تحديث الرصيد — تحقق من RLS على جدول profiles');
    }
    debugPrint('✅ Balance: $current → ${current + amount}');

    await _supabase.from('wallet_transactions').insert({
      'user_id': userId,
      'amount': amount,
      'type': 'top_up',
      'status': 'completed',
      'description': 'شحن رصيد عبر البطاقة البنكية',
    });

    await _supabase
        .from('notifications')
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

  @override
  Stream<void> watchWalletChanges(String userId) {
    return _supabase
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .map((_) => null);
  }
}
