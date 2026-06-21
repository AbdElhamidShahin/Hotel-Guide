import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/model/booking_model.dart';
import '../../../../core/network/model/notification_model.dart';
import '../../../../core/network/model/profile_model.dart';
import 'booking_repo.dart';

/// رسالة موحّدة تُستخدم عند نقص رصيد المحفظة، تُطابق بدقة في الـ UI لعرض
/// رسالة "رصيد غير كافٍ" المخصّصة بدل رسالة الخطأ العامة.
const String insufficientBalanceMessage = 'عذراً، لا يوجد رصيد كافٍ في المحفظة.';

class BookingRepoImpl implements BookingRepository {
  final SupabaseClient _supabase;
  const BookingRepoImpl(this._supabase);

  // ── getUserProfile ──────────────────────────────────────────────────────────
  // ✅ Fix #1: جلب الـ profile انتقل من الـ UI (BookingDetailsPage) إلى هنا.
  // الـ UI مكانهاش تعرف حاجة عن Supabase أصلاً.

  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        return const Left(AuthFailure('يرجى تسجيل الدخول أولاً.'));
      }
      final data = await _supabase
          .from(AppTableNames.profiles)
          .select()
          .eq('id', userId)
          .single();
      return Right(UserProfileModel.fromMap(data));
    } on PostgrestException catch (e) {
      debugPrint('❌ getUserProfile: ${e.message}');
      return Left(SupabaseFailure.fromSupabaseError(e));
    } catch (e) {
      debugPrint('❌ getUserProfile: $e');
      return Left(SupabaseFailure.fromGenericError(e));
    }
  }

  // ── confirmBooking ──────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, void>> confirmBooking(BookingModel booking) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        return const Left(AuthFailure('يرجى تسجيل الدخول أولاً.'));
      }

      final full = booking.copyWith(userId: userId);

      if (full.paymentMethod == 'wallet' || full.paymentMethod == 'AQUA') {
        await _walletPayment(full);
      } else if (full.paymentMethod == 'card') {
        await _cardPayment(full);
      } else {
        return const Left(PaymentFailure('وسيلة الدفع غير مدعومة.'));
      }

      return const Right(null);
    } on PostgrestException catch (e) {
      debugPrint('❌ confirmBooking: ${e.message}');
      // ✅ Fix #4: نحافظ على رسالة الخطأ الحقيقية (e.message) بدل ما نستبدلها
      // برسالة عامة، عشان حالة "رصيد غير كافٍ" تتعرف صح في الـ UI.
      await _notifyBookingFailed(booking, e.message);
      return Left(SupabaseFailure.fromSupabaseError(e));
    } catch (e) {
      debugPrint('❌ confirmBooking: $e');
      final failure = SupabaseFailure.fromGenericError(e);
      await _notifyBookingFailed(booking, failure.message);
      return Left(failure);
    }
  }

  // ── Wallet ─────────────────────────────────────────────────────────────────

  Future<void> _walletPayment(BookingModel b) async {
    final balance = await _getBalance(b.userId);
    if (balance < b.totalAmount) {
      throw PostgrestException(message: insufficientBalanceMessage);
    }

    bool rpcFailed = false;
    try {
      await _supabase.rpc(
        AppRpcNames.processHotelBooking,
        params: b.toRpcParams(),
      );
      debugPrint('✅ wallet booking via RPC');
      return;
    } on PostgrestException catch (e) {
      rpcFailed = true;
      debugPrint('⚠️ RPC unavailable (${e.message}) → manual wallet');
    }

    if (rpcFailed) await _manualBooking(b, 'wallet');
  }

  // ── Card ───────────────────────────────────────────────────────────────────

  Future<void> _cardPayment(BookingModel b) async {
    bool rpcFailed = false;
    try {
      await _supabase.rpc(
        AppRpcNames.processCardBooking,
        params: b.toRpcParams(),
      );
      debugPrint('✅ card booking via RPC');
      return;
    } on PostgrestException catch (e) {
      rpcFailed = true;
      debugPrint('⚠️ RPC unavailable (${e.message}) → manual card');
    }

    if (rpcFailed) await _manualBooking(b, 'card');
  }

  // ── Manual Fallback ────────────────────────────────────────────────────────

  Future<void> _manualBooking(BookingModel b, String method) async {
    if (method == 'wallet') {
      final current = await _getBalance(b.userId);
      if (current < b.totalAmount) {
        throw PostgrestException(message: insufficientBalanceMessage);
      }
      final updated = await _supabase
          .from(AppTableNames.profiles)
          .update({'wallet_balance': current - b.totalAmount})
          .eq('id', b.userId)
          .select('wallet_balance');

      if (updated == null || (updated as List).isEmpty) {
        throw Exception('فشل خصم الرصيد — تحقق من RLS على جدول profiles');
      }
    }

    final row = await _supabase
        .from(AppTableNames.bookings)
        .insert({
          'user_id': b.userId,
          'hotel_name': b.hotelName,
          'room_name': b.roomName,
          'room_id': b.roomId,
          'total_amount': b.totalAmount,
          'check_in': b.startDate.toIso8601String(),
          'check_out': b.endDate.toIso8601String(),
          'payment_method': method,
          'status': 'confirmed',
        })
        .select('id')
        .single();
    debugPrint('✅ Booking inserted: ${row['id']}');

    // ✅ Fix #2: نخزن اسم الفندق واسم الغرفة كـ columns صريحة في
    // wallet_transactions بدل ما يكونوا مدفونين جوه نص description بس.
    // ده اللي كان يخلي شاشة المحفظة ما تقدر تعرض اسم الفندق/الغرفة.
    await _supabase.from(AppTableNames.walletTransactions).insert({
      'user_id': b.userId,
      'amount': method == 'wallet' ? -b.totalAmount : b.totalAmount,
      'type': 'payment',
      'status': 'completed',
      'hotel_name': b.hotelName,
      'room_name': b.roomName,
      'description':
          'حجز في ${b.hotelName} عبر ${method == 'wallet' ? 'المحفظة' : 'البطاقة'}',
      'booking_id': row['id'],
    });

    await _insertNotification(
      userId: b.userId,
      title: 'تم الحجز بنجاح ✅',
      body:
          'تم تأكيد حجزك في ${b.hotelName}.\n'
          'المبلغ: ${b.totalAmount.toStringAsFixed(0)} EGP'
          ' عبر ${method == 'wallet' ? 'المحفظة' : 'البطاقة البنكية'}',
      type: NotificationType.success,
    );
    debugPrint('✅ Manual $method booking complete');
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  Future<double> _getBalance(String userId) async {
    final d = await _supabase
        .from(AppTableNames.profiles)
        .select('wallet_balance')
        .eq('id', userId)
        .single();
    return (d['wallet_balance'] as num).toDouble();
  }

  // ✅ Fix #4: لما الحجز يفشل لأي سبب، نسجل إشعار فشل عشان يظهر في
  // قائمة الإشعارات بدل ما يضيع الخطأ في الـ snackbar فقط.
  Future<void> _notifyBookingFailed(BookingModel b, String reason) async {
    try {
      final userId = b.userId.isNotEmpty
          ? b.userId
          : _supabase.auth.currentUser?.id;
      if (userId == null || userId.isEmpty) return;

      final isBalanceError =
          reason.contains('رصيد') || reason.toLowerCase().contains('balance');

      await _insertNotification(
        userId: userId,
        title: 'فشل الحجز ❌',
        body: isBalanceError
            ? insufficientBalanceMessage
            : 'تعذّر تأكيد حجزك في ${b.hotelName}.\n$reason',
        type: NotificationType.failure,
      );
    } catch (e) {
      debugPrint('⚠️ _notifyBookingFailed: $e');
    }
  }

  Future<void> _insertNotification({
    required String userId,
    required String title,
    required String body,
    required NotificationType type,
  }) async {
    await _supabase
        .from(AppTableNames.notifications)
        .insert(
          NotificationModel(
            title: title,
            body: body,
            time: DateTime.now(),
            type: type,
          ).toJson(userId),
        );
  }
}
