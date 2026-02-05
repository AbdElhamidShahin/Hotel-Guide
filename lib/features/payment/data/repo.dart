import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/model/booking.dart';

class BookingRepository {
  final SupabaseClient _supabase;
  BookingRepository(this._supabase);

  Future<void> confirmBooking(BookingModel booking) async {
    try {
      await _supabase.rpc(
        'process_hotel_booking',
        params: {
          'p_user_id': booking.userId,
          'p_hotel_name': booking.hotelName,
          'p_room_id': booking.roomId,
          'p_total_amount': booking.totalPrice,
          'p_check_in': booking.startDate.toIso8601String(),
          'p_check_out': booking.endDate.toIso8601String(),
          'p_payment_method': booking.paymentMethod,
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
