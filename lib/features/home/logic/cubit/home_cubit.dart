import 'package:flutter_bloc/flutter_bloc.dart';
// لازم تعمل امبورت لملف الـ Failure بتاعك
import 'package:hotel_guide/core/network/supabase_failure.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_state.dart';
import '../../data/repo/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(CitiesInitial());

  Future<void> fetchCitiesWithHotels() async {
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
// في ملف home_cubit.dart
// ... في HomeCubit.dart
  Future<void> fetchHotelsByCity(int cityId) async {
    emit(CitiesLoading());
    try {
      print("Attempting to fetch hotels for cityId: $cityId"); // 1. Attempt
      final hotels = await repository.getHotelsByCity(cityId);

      print("Hotels fetched: ${hotels.length}"); // 2. Result Count

      // 3. Details
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