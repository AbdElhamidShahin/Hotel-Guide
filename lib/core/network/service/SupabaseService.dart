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
    // ✅ نجيب اسم الفندق مع الغرفة في نفس الكويري (join) عشان نقدر نعرض
    // اسم الفندق صح في تفاصيل الحجز والمحفظة، بدل ما يفضل null دايمًا.
    final response = await _client
        .from(AppTableNames.rooms)
        .select('*, hotels(name)')
        .eq('hotel_id', hotelId);

    return List<Map<String, dynamic>>.from(response);
  }
}
