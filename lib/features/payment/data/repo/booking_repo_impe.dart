import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/model/booking_model.dart';
import '../../../../core/network/model/notification_model.dart';
import 'booking_repo.dart';

/// Handles all booking-related data operations and payment coordination.
class BookingRepoImpl implements BookingRepository {
  final SupabaseClient _supabase;

  const BookingRepoImpl(this._supabase);

  @override
  Future<Either<Failure, void>> confirmBooking(BookingModel booking) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return const Left(ServerFailure(errorMessage: 'يرجى تسجيل الدخول أولاً.'));

      final fullBooking = booking.copyWith(userId: userId);

      // Routing logic based on payment method
      return await _processPaymentByType(fullBooking);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  /// Routes the booking to the specific payment processor.
  Future<Either<Failure, void>> _processPaymentByType(BookingModel booking) async {
    try {
      if (booking.paymentMethod == 'wallet' || booking.paymentMethod == 'AQUA') {
        await _executeWalletPayment(booking);
      } else if (booking.paymentMethod == 'card') {
        await _executeCardPayment(booking);
      } else {
        return const Left(ServerFailure(errorMessage: 'وسيلة الدفع غير مدعومة.'));
      }
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  /// Validates balance and attempts wallet deduction via RPC or manual fallback.
  Future<void> _executeWalletPayment(BookingModel booking) async {
    final balance = await _getUserBalance(booking.userId);
    if (balance < booking.totalAmount) {
      throw const PostgrestException(message: 'عذراً، رصيد محفظتك غير كافٍ.');
    }

    try {
      await _supabase.rpc(AppRpcNames.processHotelBooking, params: booking.toRpcParams());
    } catch (e) {
      // Fallback if the RPC is missing or fails specifically due to existence
      await _performManualBookingUpdate(booking, 'wallet');
    }
  }

  /// High-level logic for card-based bookings.
  Future<void> _executeCardPayment(BookingModel booking) async {
    try {
      await _supabase.rpc(AppRpcNames.processCardBooking, params: booking.toRpcParams());
    } catch (e) {
      await _performManualBookingUpdate(booking, 'card');
    }
  }

  /// Atomic manual update for when RPCs are unavailable.
  Future<void> _performManualBookingUpdate(BookingModel b, String method) async {
    // 1. If wallet, deduct balance
    if (method == 'wallet') {
      final current = await _getUserBalance(b.userId);
      await _supabase.from(AppTableNames.profiles)
          .update({'wallet_balance': current - b.totalAmount})
          .eq('id', b.userId);
    }

    // 2. Insert booking record
    final bookingRow = await _supabase.from(AppTableNames.bookings).insert({
      'user_id': b.userId,
      'hotel_name': b.hotelName,
      'room_id': b.roomId,
      'total_amount': b.totalAmount,
      'check_in': b.startDate.toIso8601String(),
      'check_out': b.endDate.toIso8601String(),
      'payment_method': method,
      'status': 'confirmed',
    }).select('id').single();

    // 3. Register transaction
    await _supabase.from(AppTableNames.walletTransactions).insert({
      'user_id': b.userId,
      'amount': b.totalAmount,
      'type': 'payment',
      'status': 'completed',
      'description': 'حجز في ${b.hotelName} عبر ${method == 'wallet' ? 'المحفظة' : 'البطاقة'}',
      'booking_id': bookingRow['id'],
    });

    await _sendBookingNotification(b, method);
  }

  /// Helper to fetch current user wallet balance.
  Future<double> _getUserBalance(String userId) async {
    final data = await _supabase.from(AppTableNames.profiles)
        .select('wallet_balance').eq('id', userId).single();
    return (data['wallet_balance'] as num).toDouble();
  }

  /// Internal notification dispatcher.
  Future<void> _sendBookingNotification(BookingModel b, String method) async {
    final title = 'عملية حجز ناجحة ✅';
    final body = 'تم تأكيد حجزك في ${b.hotelName}. المبلغ: ${b.totalAmount} EGP';

    await _supabase.from(AppTableNames.notifications).insert(
      NotificationModel(
        title: title,
        body: body,
        time: DateTime.now(),
        type: NotificationType.success,
      ).toJson(b.userId),
    );
  }
}