import '../../../../core/network/city_model.dart';

abstract class SearchRepo {
  Future<List<CityModel>> fetchCitiesWithHotels();
}