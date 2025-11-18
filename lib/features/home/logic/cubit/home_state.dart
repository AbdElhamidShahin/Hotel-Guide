import '../../../../core/network/city_model.dart';
import '../../../../core/network/hotel_model.dart';


abstract class HomeState {}

class CitiesInitial extends HomeState {}

class CitiesLoading extends HomeState {}

class CitiesLoaded extends HomeState {
  final List<CityModel> cities;
  CitiesLoaded(this.cities);
}

class HotelsLoaded extends HomeState {
  final List<HotelModel> hotels;
  HotelsLoaded(this.hotels);
}

class CitiesError extends HomeState {
  final String message;
  CitiesError(this.message);
}
