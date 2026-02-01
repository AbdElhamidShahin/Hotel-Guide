import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchHotels() async {
    try {
      return await _client.from('hotels').select('*, cities(name)');
    } catch (e) {
      print("Supabase Error: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchCities() async {
    try {
      return await _client.from('cities').select('*');
    } catch (e) {
      print("Supabase Error: $e");
      rethrow;
    }
  }

  Future<void> createBooking(Map<String, dynamic> bookingData) async {
    try {
      await _client.from('bookings').insert(bookingData);
    } catch (e) {
      print("Supabase Error: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchRooms(String hotelId) async {
    try {
      print("📡 [Supabase]: جاري الاتصال بجدول rooms للفندق: $hotelId");

      final response = await _client
          .from('rooms')
          .select()
          .eq('hotel_id', hotelId);

      print("📥 [Supabase Raw Response]: $response"); // لو طبع [] يبقى الـ ID ملوش داتا هناك
      return response as List<Map<String, dynamic>>;
    } catch (e) {
      print("⚠️ [Supabase Error]: $e");
      throw e;
    }
  }
}
