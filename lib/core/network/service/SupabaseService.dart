import 'package:supabase_flutter/supabase_flutter.dart';
import '../../constants/api_constants.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchHotels() async {
    return await _client.from(AppTableNames.hotels).select('*, cities(name)');
  }

  Future<List<Map<String, dynamic>>> fetchCities() async {
    return await _client.from(AppTableNames.cities).select('*');
  }

  Future<void> createBooking(Map<String, dynamic> bookingData) async {
    await _client.from(AppTableNames.bookings).insert(bookingData);
  }

  Future<List<Map<String, dynamic>>> fetchRooms(String hotelId) async {
    final response = await _client
        .from(AppTableNames.rooms)
        .select()
        .eq('hotel_id', hotelId);

    return List<Map<String, dynamic>>.from(response);
  }
}
