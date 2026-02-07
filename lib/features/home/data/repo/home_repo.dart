
import '../../../../core/network/model/city_model.dart';
import '../../../../core/network/model/hotel_model.dart';

abstract class HomeRepository {
  Future<List<CityModel>> getAllCities();
  Future<List<HotelModel>> getAllHotels();
}
