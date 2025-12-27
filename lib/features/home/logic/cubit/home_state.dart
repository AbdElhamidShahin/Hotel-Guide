// home_state.dart
import '../../../../core/network/city_model.dart';
import '../../../../core/network/hotel_model.dart';

abstract class HomeState {}

class CitiesInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeError extends HomeState { final String message; HomeError(this.message); }

class HomeLoaded extends HomeState {
  final List<CityModel> cities;
  final List<HotelModel> selectedHotels;
  final int selectedCityId; // عشان نعرف أنهي مدينة متلونة في الـ UI

  HomeLoaded({
    required this.cities,
    required this.selectedHotels,
    required this.selectedCityId
  });
}