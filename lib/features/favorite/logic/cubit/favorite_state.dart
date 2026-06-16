import '../../../../core/network/model/hotel_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteUpdated extends FavoriteState {
  final List<HotelModel> favorites;
  FavoriteUpdated(this.favorites);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is FavoriteUpdated &&
              favorites.length == other.favorites.length &&
              !favorites.any((h) => !other.favorites.any((o) => o.id == h.id)));

  @override
  int get hashCode => favorites.map((h) => h.id).toList().toString().hashCode;
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}