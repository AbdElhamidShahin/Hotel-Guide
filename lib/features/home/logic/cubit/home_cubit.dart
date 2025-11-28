// cities_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/core/network/city_model.dart';
import 'package:hotel_guide/features/home/data/repo/home_repo.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_state.dart';

import '../../../../core/network/hotel_model.dart';

class CitiesCubit extends Cubit<CityState> {
  final HomeRepository repository;
  List<CityModel>? _cachedCities;

  CitiesCubit(this.repository) : super(CityInitial());

  Future<void> fetchCities() async {
    if (_cachedCities != null) {
      emit(CitiesLoaded(_cachedCities!));
      return;
    }

    emit(CitiesLoading());
    try {
      final cities = await repository.getCities();
      _cachedCities = cities;
      emit(CitiesLoaded(cities));
    } catch (e) {
      emit(CitiesError("حدث خطأ في تحميل المدن"));
    }
  }
}
class HotelsCubit extends Cubit<HotelState> {
  final HomeRepository repository;
  Map<int, List<HotelModel>> _cachedHotelsByCity = {};

  HotelsCubit(this.repository) : super(HotelInitial());

  Future<void> fetchHotelsByCity(int cityId) async {
    if (_cachedHotelsByCity.containsKey(cityId)) {
      emit(HotelsLoaded(_cachedHotelsByCity[cityId]!));
      return;
    }

    emit(HotelsLoading());
    try {
      final hotels = await repository.getHotelsByCity(cityId);
      _cachedHotelsByCity[cityId] = hotels;
      emit(HotelsLoaded(hotels));
    } catch (e) {
      emit(HotelsError("حدث خطأ في تحميل الفنادق"));
    }
  }
}