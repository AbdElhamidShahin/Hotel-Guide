import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/model/booking.dart';

class BookingRepository {
  final SupabaseClient _supabase;
  BookingRepository(this._supabase);

  Future<void> confirmBooking(BookingModel booking) async {
    try {
      await _supabase.rpc(
        'process_hotel_booking',
        params: booking.toRpcParams(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
