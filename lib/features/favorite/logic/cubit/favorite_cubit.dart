import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/favorite/logic/cubit/favorite_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/hotel_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial()) {
    _loadFavorites();
  }

  List<HotelModel> _favorites = [];

  List<HotelModel> get favorites => _favorites;

  bool isFavorite(HotelModel hotel) {
    return _favorites.any((item) => item.id == hotel.id);
  }

  Future<void> toggleFavorite(HotelModel hotel) async {
    final bool exists = isFavorite(hotel);

    if (exists) {
      _favorites.removeWhere((item) => item.id == hotel.id);
    } else {
      _favorites.add(hotel);
    }

    emit(FavoriteUpdated(_favorites.toList()));

    // حفظ في SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteList =
    _favorites.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('favorites', favoriteList);
  }

  Future<void> _loadFavorites() async {
    try {
      emit(FavoriteLoading());
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getStringList('favorites');

      if (data != null) {
        _favorites = data
            .map((e) => HotelModel.fromJson(jsonDecode(e)))
            .toList();
        emit(FavoriteUpdated(_favorites.toList()));
      } else {
        emit(FavoriteUpdated([]));
      }
    } catch (e) {
      emit(FavoriteError('Failed to load favorites'));
    }
  }
}