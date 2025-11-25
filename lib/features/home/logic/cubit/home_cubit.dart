import 'package:flutter_bloc/flutter_bloc.dart';
// لازم تعمل امبورت لملف الـ Failure بتاعك
import 'package:hotel_guide/core/network/supabase_failure.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_state.dart';
import '../../../../core/network/hotel_model.dart';
import '../../data/repo/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(CitiesInitial());
  Map<int, List<HotelModel>> _cachedHotelsByCity = {}; // cache

  Future<void> fetchCitiesWithHotels(int cityId ) async {
    if (_cachedHotelsByCity.containsKey(cityId)) {
    emit(HotelsLoaded(_cachedHotelsByCity[cityId]!));
    return;
  }
    emit(CitiesLoading());
    try {
      final cities = await repository.getCitiesWithHotels();
      emit(CitiesLoaded(cities));
    } catch (e) {
      // --- ده التعديل الصحيح ---
      if (e is SupabaseFailure) {
        emit(CitiesError(e.errorMessage)); // ابعت رسالة الخطأ الفعلية
      } else {
        emit(CitiesError("خطأ غير متوقع: ${e.toString()}"));
      }
      // --- نهاية التعديل ---
    }
  }
  Future<void> fetchHotelsByCity(int cityId) async {
    emit(CitiesLoading());
    try {
      final hotels = await repository.getHotelsByCity(cityId);
      _cachedHotelsByCity[cityId] = hotels;

      for (var hotel in hotels) {
        print("Hotel Details: Name=${hotel.name}, Rating=${hotel.rating}");
      }

      emit(HotelsLoaded(hotels));
    } catch (e) {
      if (e is SupabaseFailure) {
        emit(CitiesError(e.errorMessage));
      } else {
        emit(CitiesError("خطأ غير متوقع: ${e.toString()}"));
      }
    }


  }
}