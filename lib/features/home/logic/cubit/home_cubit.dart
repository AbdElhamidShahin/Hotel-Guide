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
      // ✅ Fix: use type-safe parallel fetch instead of unsafe `as` casts
      // from untyped Future.wait results, which silently fail at runtime.
      final citiesFuture = repository.getAllCities();
      final hotelsFuture = repository.getAllHotels();

      final cities = await citiesFuture;
      final hotels = await hotelsFuture;

      emit(HomeLoaded(cities: cities, hotels: hotels));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
