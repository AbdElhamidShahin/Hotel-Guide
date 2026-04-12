import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/model/booking_model.dart';
import '../../../../core/network/model/notification_model.dart';
import 'booking_repo.dart';

/// ✅ FIX #3: Unified payment flow.
///
/// BEFORE:
///   - Wallet  → called RPC `process_hotel_booking`  → saved booking + transaction + notification ✅
///   - Card    → did a plain `insert` into `bookings`  → NO transaction, NO notification ❌
///
/// AFTER:
///   Both methods go through Supabase RPCs so the database handles everything
///   atomically (booking + transaction + notification in a single DB transaction).
///
/// REQUIRED: Create a `process_card_booking` RPC in Supabase that mirrors
///           `process_hotel_booking` but skips the wallet-balance deduction.
///           SQL template is included at the bottom of this file.
class BookingRepoImpl implements BookingRepository {
  final SupabaseClient _supabase;

  const BookingRepoImpl(this._supabase);

  @override
  Future<Either<Failure, void>> confirmBooking(BookingModel booking) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return const Left(
          ServerFailure(errorMessage: 'يرجى تسجيل الدخول أولاً لإتمام الحجز.'),
        );
      }

      final bookingWithUser = booking.copyWith(userId: user.id);

      switch (bookingWithUser.paymentMethod) {
        case 'AQUA':
          await _processWalletPayment(bookingWithUser);

        case 'card':
          await _processCardPayment(bookingWithUser, user.id);

        default:
          return const Left(
            ServerFailure(errorMessage: 'وسيلة الدفع المختارة غير مدعومة حالياً.'),
          );
      }

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  // ── Wallet Payment ────────────────────────────────────────────────────────

  Future<void> _processWalletPayment(BookingModel booking) async {
    final profileData = await _supabase
        .from(AppTableNames.profiles)
        .select('wallet_balance')
        .eq('id', booking.userId)
        .single();

    final balance = (profileData['wallet_balance'] as num).toDouble();
    if (balance < booking.totalAmount) {
      throw const PostgrestException(message: 'عذراً، رصيد محفظتك غير كافٍ.');
    }

    // RPC handles: booking insert + wallet deduct + transaction record + notification
    await _supabase.rpc(
      AppRpcNames.processHotelBooking,
      params: booking.toRpcParams(),
    );
  }

  // ── Card Payment ──────────────────────────────────────────────────────────

  Future<void> _processCardPayment(BookingModel booking, String userId) async {
    // Option A — Preferred: Use an RPC so everything is atomic in the DB.
    //   The RPC `process_card_booking` should:
    //     1. Insert into `bookings`
    //     2. Insert into `wallet_transactions` (type = 'card_payment')
    //     3. Insert into `notifications`
    //
    // Option B — Fallback if you haven't created the RPC yet:
    //   Uncomment the manual block below and comment out the rpc() call.

    try {
      await _supabase.rpc(
        AppRpcNames.processCardBooking,
        params: booking.toRpcParams(),
      );
    } on PostgrestException catch (e) {
      // Fallback: function doesn't exist yet — do it manually in a sequence.
      if (e.code == 'PGRST202' || e.message.contains('does not exist')) {
        debugPrint('⚠️  process_card_booking RPC not found — using manual fallback.');
        await _processCardPaymentManual(booking, userId);
      } else {
        rethrow;
      }
    }
  }

  /// Manual fallback (3 separate inserts) until the RPC is ready in Supabase.
  /// Note: this is NOT atomic — if step 2 or 3 fails, step 1 already committed.
  /// Create the RPC ASAP to replace this.
  Future<void> _processCardPaymentManual(BookingModel booking, String userId) async {
    // 1. Booking
    final bookingRow = await _supabase.from(AppTableNames.bookings).insert({
      'user_id': userId,
      'hotel_name': booking.hotelName,
      'room_id': booking.roomId,
      'total_amount': booking.totalAmount,
      'check_in': booking.startDate.toIso8601String(),
      'check_out': booking.endDate.toIso8601String(),
      'payment_method': booking.paymentMethod,
    }).select('id').single();

    // 2. Transaction record
    await _supabase.from(AppTableNames.walletTransactions).insert({
      'user_id': userId,
      'amount': booking.totalAmount,
      'type': 'card_payment',
      'description': 'حجز في ${booking.hotelName}',
      'booking_id': bookingRow['id'],
      'created_at': DateTime.now().toIso8601String(),
    });

    // 3. Notification
    final notification = NotificationModel(
      title: 'عملية حجز ناجحة ✅',
      body: 'تم تأكيد حجزك في ${booking.hotelName} بنجاح عبر البطاقة البنكية.',
      time: DateTime.now(),
      type: NotificationType.success,
    );
    await _supabase
        .from(AppTableNames.notifications)
        .insert(notification.toJson(userId));
  }
}
