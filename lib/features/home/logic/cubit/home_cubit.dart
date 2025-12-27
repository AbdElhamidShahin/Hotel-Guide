import 'package:flutter_bloc/flutter_bloc.dart';
// لازم تعمل امبورت لملف الـ Failure بتاعك
import 'package:hotel_guide/core/network/supabase_failure.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_state.dart';
import '../../../../core/network/city_model.dart';
import '../../../../core/network/hotel_model.dart';
import '../../data/repo/home_repo.dart';


class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  List<CityModel> allCities = [];

  HomeCubit(this.repository) : super(CitiesInitial());

  Future<void> fetchInitialData() async {
    emit(HomeLoading());
    try {
      allCities = await repository.getCitiesWithHotels();

      if (allCities.isNotEmpty) {
        emit(HomeLoaded(
          cities: allCities,
          selectedHotels: allCities[0].hotels,
          selectedCityId: allCities[0].id,
        ));
      } else {
        emit(HomeError("لا توجد بيانات"));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }


  void updateSelectedCity(int cityId) {
    if (allCities.isEmpty) return;

    try {
      final selectedCity = allCities.firstWhere((c) => c.id == cityId);
      emit(HomeLoaded(
        cities: allCities,
        selectedHotels: selectedCity.hotels,
        selectedCityId: cityId,
      ));
    } catch (e) {
      print("City not found: $cityId");
    }
  }
}