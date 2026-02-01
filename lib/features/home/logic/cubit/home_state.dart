import '../../../../core/network/model/city.dart';
import '../../../../core/network/model/hotel.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CityModel> cities;
  final List<HotelModel> hotels;

  HomeLoaded({required this.cities, required this.hotels});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
