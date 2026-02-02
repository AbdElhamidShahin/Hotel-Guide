import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/model/booking.dart';

class BookingRepository {
  final SupabaseClient _client;
  BookingRepository(this._client);

  Future<void> confirmBooking(BookingModel booking) async {
    print("📡 [Repo] Calling RPC 'process_wallet_booking'...");

    try {
      await _client.rpc('process_wallet_booking', params: {
        'p_room_id': booking.roomId,
        'p_total_price': booking.totalPrice,
        'p_start_date': booking.startDate.toIso8601String(),
        'p_end_date': booking.endDate.toIso8601String(),
        'p_hotel_name': booking.hotelName,
      });
      print("✅ [Repo] RPC Success: Booking and Payment completed.");
    } catch (e) {
      print("❌ [Repo] RPC Error: ${e.toString()}");
      rethrow; // بنرميه عشان الكيوبيت يمسكه
    }
  }
}