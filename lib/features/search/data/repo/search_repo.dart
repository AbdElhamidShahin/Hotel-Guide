import '../../../../core/network/model/hotel_model.dart';
import '../../logic/model.dart';

abstract class SearchRepo {
  Future<List<HotelModel>> fetchHotels({String? queryText, FilterOptions? filter});
  Future<List<String>> fetchAllCities();
  Future<List<String>> fetchAllViews();
}