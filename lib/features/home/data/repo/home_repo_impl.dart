import '../../../../core/network/supabase_failure.dart';
import '../../../../core/network/city_model.dart';
import '../../../../core/network/hotel_model.dart';
import '../../../../core/network/supabase_service.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepository {
  final SupabaseService service;

  HomeRepoImpl(this.service);

  @override
  Future<List<HotelModel>> getHotelsByCity(int cityId) async {
    try {
      final data = await service.getHotelsByCity(cityId);
      print("Hotels by City Data: $data");
      return data.map((e) => HotelModel.fromJson(e)).toList();
    } catch (error) {
      print("Error in getHotelsByCity: $error");
      throw SupabaseFailure.fromGenericError(error);
    }
  }

  @override // أضف هذه annotation
  Future<List<CityModel>> getCitiesWithHotels() async {
    try {
      final data = await service.getCitiesWithHotels();
      print("Cities with Hotels Raw Data: $data");
      return data.map((e) => CityModel.fromJson(e)).toList();
    } catch (error) {
      print("Error in getCitiesWithHotels: $error");
      throw SupabaseFailure.fromGenericError(error);
    }
  }

  @override
  Future<List<CityModel>> getCities() async {
    try {
      final data = await service.getCities();
      print("Cities Raw Data: $data");
      return data.map((e) => CityModel.fromJson(e)).toList();
    } catch (error) {
      print("Error in getCities: $error");
      throw SupabaseFailure.fromGenericError(error);
    }
  }
}