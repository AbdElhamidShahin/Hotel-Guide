import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_state.dart';
import '../../../../core/network/model/city_model.dart';
import '../../data/repo/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  List<CityModel> allCities = [];

  HomeCubit(this.repository) : super(HomeInitial());
  Future<void> getHotelsAndCities() async {
    emit(HomeLoading());
    try {
      final cities = await repository.getAllCities();

      final hotels = await repository.getAllHotels();

      emit(HomeLoaded(cities: cities, hotels: hotels));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
