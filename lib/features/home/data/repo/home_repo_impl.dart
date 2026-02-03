import '../../../../core/network/SupabaseService.dart';
import '../../../../core/network/model/city.dart';
import '../../../../core/network/model/hotel.dart';
import '../../../../core/network/supabase_failure.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepository {
  final SupabaseService _service;

  HomeRepoImpl(this._service);
  @override
  Future<List<HotelModel>> getAllHotels() async {
    try {
      final data = await _service.fetchHotels();
      return data.map((json) => HotelModel.fromJson(json)).toList();
    } catch (error) {
      throw SupabaseFailure.fromGenericError(error);
    }
  }

  @override
  Future<List<CityModel>> getAllCities() async {
    try {
      final data = await _service.fetchCities();
      return data.map((json) => CityModel.fromJson(json)).toList();
    } catch (error) {
      throw SupabaseFailure.fromGenericError(error);
    }
  }
}
