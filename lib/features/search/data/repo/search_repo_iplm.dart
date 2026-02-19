import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/network/model/hotel_model.dart';
import '../../../../core/network/failure/supabase_failure.dart';
import '../../logic/model.dart';
import 'search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<List<HotelModel>> fetchHotels({
    String? queryText,
    FilterOptions? filter,
  }) async {
    try {
      var selectQuery = '*, cities!inner(name)';

      var query = _client.from('hotels').select(selectQuery);

      if (queryText != null && queryText.isNotEmpty) {
        query = query.ilike('name', '%$queryText%');
      }

      if (filter != null) {
        query = query
            .gte('price_starts_from', filter.priceRange.start)
            .lte('price_starts_from', filter.priceRange.end);

        if (filter.city != null && filter.city != "الكل") {
          query = query.filter('cities.name', 'eq', filter.city!);
        }

        if (filter.view != null) {
          query = query.contains('views', '{${filter.view!}}');
        }
        if (filter.rating != null) {
          query = query.gte('rating', filter.rating!);
        }
      }

      final response = await query.order('price_starts_from', ascending: true);
      print("Raw Response: $response");
      if ((response as List).isEmpty)
        print("Warning: Database returned empty list!");
      return (response as List)
          .map((hotel) => HotelModel.fromJson(hotel))
          .toList();
    } catch (e) {
      throw SupabaseFailure.fromSupabaseError(e);
    }
  }

  @override
  Future<List<String>> fetchAllCities() async {
    final response = await _client.from('cities').select('name');
    return (response as List).map((e) => e['name'] as String).toList();
  }

  @override
  Future<List<String>> fetchAllViews() async {
    final response = await _client.from('hotels').select('views');
    Set<String> uniqueViews = {};
    for (var item in (response as List)) {
      List<dynamic> viewsList = item['views'] ?? [];
      for (var v in viewsList) uniqueViews.add(v.toString());
    }
    return uniqueViews.toList();
  }
}
