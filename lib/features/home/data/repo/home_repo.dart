import '../../../../core/network/city_model.dart';
import '../../../../core/network/hotel_model.dart';
import '../../../../core/network/model/city.dart';
import '../../../../core/network/model/hotel.dart';

abstract class HomeRepository {
  Future<List<CityModel>> getAllCities();
  Future<List<HotelModel>> getAllHotels();
}
