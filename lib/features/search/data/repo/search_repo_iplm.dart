import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/network/SupabaseService.dart';
import '../../../../core/network/model/hotel.dart';
import '../../../../core/network/supabase_failure.dart';
import 'search_repo.dart';

class SearchRepoIplm implements SearchRepo {
  final SupabaseService service;
  final SupabaseClient client = Supabase.instance.client;

  SearchRepoIplm(this.service);

  @override
  Future<List<HotelModel>> fetchHotels() async {
    try {
      final response = await client.from('hotels').select('*');

      final hotels = response
          .map((hotelData) => HotelModel.fromJson(hotelData))
          .toList();

      return hotels;
    } catch (e) {
      throw SupabaseFailure.fromSupabaseError(e);
    }
  }
}
