import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../core/network/model/hotel_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial()) {
    loadFavorites();
  }

  List<HotelModel> _favorites = [];
  List<HotelModel> get favorites => _favorites;

  bool isFavorite(HotelModel hotel) {
    return _favorites.any((item) => item.id == hotel.id);
  }

  Future<void> toggleFavorite(HotelModel hotel) async {
    try {
      if (isClosed) return;

      final bool exists = isFavorite(hotel);
      final List<HotelModel> updatedFavorites = List.from(_favorites);

      if (exists) {
        updatedFavorites.removeWhere((item) => item.id == hotel.id);
      } else {
        updatedFavorites.add(hotel);
      }

      _favorites = updatedFavorites;

      final prefs = await SharedPreferences.getInstance();
      final List<String> favoriteList =
      _favorites.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList('favorites', favoriteList);

      if (!isClosed) {
        emit(FavoriteUpdated(List.from(_favorites)));
      }

    } catch (error) {
      if (!isClosed) {
        emit(FavoriteError('Failed to toggle favorite'));
      }
    }
  }


  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getStringList('favorites');

      if (data != null) {
        _favorites = data
            .map((e) => HotelModel.fromJson(jsonDecode(e)))
            .toList();
        emit(FavoriteUpdated(List.from(_favorites)));
      } else {
        emit(FavoriteUpdated([]));
      }
    } catch (e) {
      emit(FavoriteError('Failed to load favorites'));
    }
  }
}