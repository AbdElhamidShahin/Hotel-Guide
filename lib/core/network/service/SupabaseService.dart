import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_constants.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchHotels() async {
    try {
      return await _client.from("hotels").select('*, cities(name)');
    } catch (e) {
      print("Supabase Error: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchCities() async {
    try {
      return await _client.from(AppTableNames.cities).select('*');
    } catch (e) {
      print("Supabase Error: $e");
      rethrow;
    }
  }

  Future<void> createBooking(Map<String, dynamic> bookingData) async {
    try {
      await _client.from(AppTableNames.bookings).insert(bookingData);
    } catch (e) {
      print("Supabase Error: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchRooms(String hotelId) async {
    try {
      final response = await _client
          .from(AppTableNames.rooms)
          .select()
          .eq('hotel_id', hotelId);

      return response as List<Map<String, dynamic>>;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> feathData() async {
    try {
      return await _client.from(AppTableNames.hotels).select("*");
    } catch (e) {
      print("Supabase Error $e");
      rethrow;
    }
  }
}
