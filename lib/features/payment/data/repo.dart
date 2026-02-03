import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/model/booking.dart';

class BookingRepository {
  final SupabaseClient _client;
  BookingRepository(this._client);

  Future<void> confirmBooking(BookingModel booking) async {
    try {
      ///بنبعت طلب حجز للسيرفر يحدد الغرفه والسعر واسم والبدأ والنهايه
      await _client.rpc(
        'process_wallet_booking',
        params: {
          'p_room_id': booking.roomId,
          'p_total_price': booking.totalPrice,
          'p_start_date': booking.startDate.toIso8601String(),
          'p_end_date': booking.endDate.toIso8601String(),
          'p_hotel_name': booking.hotelName,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
