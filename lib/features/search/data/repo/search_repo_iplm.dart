import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/network/model/hotel_model.dart';
import '../../../../core/error/failure.dart';
import '../../logic/model.dart';
import 'search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  // ✅ Fix: injected via constructor instead of self-instantiating
  // from global Supabase.instance (which caused init-order crashes).
  final SupabaseClient _client;

  SearchRepoImpl(this._client);

  @override
  Future<List<HotelModel>> fetchHotels({
    String? queryText,
    FilterOptions? filter,
  }) async {
    try {
      const selectQuery = '*, cities!inner(name)';
      var query = _client.from('hotels').select(selectQuery);

      if (queryText != null && queryText.isNotEmpty) {
        query = query.ilike('name', '%$queryText%');
      }

      if (filter != null) {
        query = query
            .gte('price_starts_from', filter.priceRange.start)
            .lte('price_starts_from', filter.priceRange.end);

        if (filter.city != null && filter.city != 'الكل') {
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
    // ✅ Fix: query only the views column, not all hotel rows
    final response = await _client.from('hotels').select('views');
    final Set<String> uniqueViews = {};
    for (final item in (response as List)) {
      final List<dynamic> viewsList = (item['views'] as List?) ?? [];
      for (final v in viewsList) {
        uniqueViews.add(v.toString());
      }
    }
    return uniqueViews.toList();
  }
}
