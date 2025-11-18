// features/search/data/repo/home_repo_imp.dart
import 'package:hotel_guide/core/network/city_model.dart';
import 'package:hotel_guide/features/search/data/repo/search_repo.dart';
import '../../../../core/network/supabase_failure.dart';
import '../../../../core/network/supabase_service.dart';

class SearchRepoIplm implements SearchRepo {
  final SupabaseService service;
  SearchRepoIplm(this.service);

  @override
  Future<List<CityModel>> fetchCitiesWithHotels() async {
    try {
      final data = await service.getCitiesWithHotels();
      if (data == null) return [];
      return (data as List)
          .map((e) => CityModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (error) {
      throw SupabaseFailure.fromGenericError(error);
    }
  }
}
