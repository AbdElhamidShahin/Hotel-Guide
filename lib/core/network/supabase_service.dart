import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> getCitiesWithHotels() async {
    final response = await client
        .from('cities')
        .select('id, name, image_url, hotels(id, name, rating, price, imageUrl, imageUrlAll, iswifi, breakfast, location, locationUrl, description, city_id)').timeout(const Duration(seconds: 20));
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getHotelsByCity(int cityId) async {
    final response = await client
        .from('hotel')
        .select('*')
        .eq('city_id', cityId);
    return List<Map<String, dynamic>>.from(response);
  }
}
