import '../../../../core/network/hotel_model.dart';
import '../../../../core/network/model/hotel.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<HotelModel> hotels;

  SearchSuccess(this.hotels);
}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);
}
