import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getCitiesWithHotels() async {
    try {
      final response = await client
          .from('citiy')
          .select('*, hotel(*)');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Supabase Error: $e");
      rethrow;
    }
  }
}