import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getCitiesWithHotels() async {
    try {
      final response = await client.from('cities').select('''id, name, image_url,hotels(id, name, rating, price, imageUrl, imageUrlAll, iswifi, breakfast, location, locationUrl, description, city_id)''');

      print("Supabase Cities with Hotels Response: $response");
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Error in getCitiesWithHotels: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getCities() async {
    try {
      final response = await client.from('cities').select('*');
      print("Supabase Cities Response: $response");
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Error in getCities: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getHotelsByCity(int cityId) async {
    try {
      final response = await client
          .from('hotel')
          .select('*')
          .eq('city_id', cityId);

      print("Supabase Hotels by City Response: $response");
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Error in getHotelsByCity: $e");
      rethrow;
    }
  }
}
