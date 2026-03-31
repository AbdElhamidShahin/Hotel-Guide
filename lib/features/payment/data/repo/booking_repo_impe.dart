import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/model/booking_model.dart';
import 'booking_repo.dart';

class BookingRepoImpl implements BookingRepository {
  final SupabaseClient _supabase;

  const BookingRepoImpl(this._supabase);

  @override
  Future<Either<Failure, void>> confirmBooking(BookingModel booking) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return const Left(
          ServerFailure(errorMessage: 'المستخدم غير مسجل الدخول.'),
        );
      }

      final bookingWithUser = booking.copyWith(userId: user.id);

      if (bookingWithUser.paymentMethod == 'AQUA') {
        // ✅ المحفظة: استخدم RPC (بتخصم الرصيد وتسجل الحجز)
        await _supabase.rpc(
          'process_hotel_booking',
          params: bookingWithUser.toRpcParams(),
        );
      } else {
        if (bookingWithUser.paymentMethod == 'card') {
          // ✅ الكارت: Insert مباشر بدون خصم رصيد
          await _supabase.from('bookings').insert({
            'user_id': bookingWithUser.userId,
            'hotel_name': bookingWithUser.hotelName,
            'room_id': bookingWithUser.roomId,
            'total_amount': bookingWithUser.totalAmount,
            'check_in': bookingWithUser.startDate.toIso8601String(),
            'check_out': bookingWithUser.endDate.toIso8601String(),
            'payment_method': bookingWithUser.paymentMethod,
          });
        }
      }

      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
