import '../../../../core/network/model/hotel_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<HotelModel> hotels;
  final List<String> cities;
  final List<String> views;

  SearchSuccess({required this.hotels, required this.cities, required this.views});
}
class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);
}
