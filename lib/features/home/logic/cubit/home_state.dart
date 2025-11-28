import '../../../../core/network/city_model.dart';
import '../../../../core/network/hotel_model.dart';


abstract class CityState {}

class CityInitial extends CityState {}

class CitiesLoading extends CityState {}

class CitiesLoaded extends CityState {
  final List<CityModel> cities;
  CitiesLoaded(this.cities);
}
class CitiesError extends CityState {
  final String message;
  CitiesError(this.message);
}


abstract class HotelState {}
class HotelInitial extends HotelState {}

class HotelsLoading extends HotelState {}


class HotelsError extends HotelState {
  final String message;
  HotelsError(this.message);
}
class HotelsLoaded extends HotelState {
  final List<HotelModel> hotels;
  HotelsLoaded(this.hotels);
}


