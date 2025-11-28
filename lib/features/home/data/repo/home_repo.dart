import '../../../../core/network/city_model.dart';
import '../../../../core/network/hotel_model.dart';

abstract class HomeRepository {
  Future<List<CityModel>> getCitiesWithHotels();
  Future<List<CityModel>> getCities();
  Future<List<HotelModel>> getHotelsByCity(int cityId);
}
