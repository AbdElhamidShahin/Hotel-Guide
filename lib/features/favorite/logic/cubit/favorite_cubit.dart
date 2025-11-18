import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/favorite/logic/cubit/favorite_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
    try {
      if (isClosed) return; // منع emit إذا كان Cubit مغلق

      final bool exists = isFavorite(hotel);
      final List<HotelModel> updatedFavorites = List.from(_favorites);

      if (exists) {
        updatedFavorites.removeWhere((item) => item.id == hotel.id);
      } else {
        updatedFavorites.add(hotel);
      }

      _favorites = updatedFavorites;

      if (!isClosed) {
        emit(FavoriteUpdated(_favorites.toList()));
      }

      // حفظ في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final List<String> favoriteList =
      _favorites.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList('favorites', favoriteList);

    } catch (error) {
      if (!isClosed) {
        emit(FavoriteError('Failed to toggle favorite'));
      }
    }
  }

  Future<void> _loadFavorites() async {
    try {
      if (!isClosed) {
        emit(FavoriteLoading());
      }

      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getStringList('favorites');

      if (data != null) {
        _favorites = data
            .map((e) => HotelModel.fromJson(jsonDecode(e)))
            .toList();
        if (!isClosed) {
          emit(FavoriteUpdated(_favorites.toList()));
        }
      } else {
        if (!isClosed) {
          emit(FavoriteUpdated([]));
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(FavoriteError('Failed to load favorites'));
      }
    }
  }

  // إضافة دالة للتأكد من عدم إغلاق الـ Cubit
  @override
  Future<void> close() {
    // تنظيف أي موارد إذا لزم الأمر
    return super.close();
  }
}