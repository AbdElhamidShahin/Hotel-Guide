

import '../../../../core/network/supabase_failure.dart';
import '../../../../core/network/city_model.dart';
import '../../../../core/network/hotel_model.dart';
import '../../../../core/network/supabase_service.dart';
import 'home_repo.dart';
// في ملف home_repo_impl.dart

class HomeRepoImpl implements HomeRepository {
  final SupabaseService service;

  HomeRepoImpl(this.service);

  @override
  Future<List<HotelModel>> getHotelsByCity(int cityId) async {
    try {
      final data = await service.getHotelsByCity(cityId);
      return data.map((e) => HotelModel.fromJson(e)).toList();
    } catch (error) {
      // ⚠️ المشكلة: إذا لم يكن الخطأ PostgrestException (أي كان SocketException)، لن يتم معالجته هنا
      // ❌ الحل: استخدم fromGenericError
      throw SupabaseFailure.fromGenericError(error);
    }
  }

  // نفّذ نفس التعديل على getCitiesWithHotels()
  @override
  Future<List<CityModel>> getCitiesWithHotels() async {
    try {
      final data = await service.getCitiesWithHotels();
      return data.map((e) => CityModel.fromJson(e)).toList();
    } catch (error) {
      throw SupabaseFailure.fromGenericError(error);
    }
  }
}