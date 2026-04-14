import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_state.dart';
import '../../../../core/network/model/city_model.dart';
import '../../../../core/network/model/hotel_model.dart';
import '../../data/repo/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(HomeInitial());
  Future<void> getHotelsAndCities() async {
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        repository.getAllCities(),
        repository.getAllHotels(),
      ]);
      final cities = results[0] as List<CityModel>;
      final hotels = results[1] as List<HotelModel>;
      emit(HomeLoaded(cities: cities, hotels: hotels));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
