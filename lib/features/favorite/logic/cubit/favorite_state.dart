import '../../../../core/network/hotel_model.dart';
import '../../../../core/network/model/hotel.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteUpdated extends FavoriteState {
  final List<HotelModel> favorites;

  FavoriteUpdated(this.favorites);
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}