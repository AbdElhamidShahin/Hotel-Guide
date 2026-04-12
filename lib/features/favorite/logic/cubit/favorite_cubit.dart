import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/model/hotel_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  static const _prefsKey = 'favorites';

  FavoriteCubit() : super(FavoriteInitial()) {
    loadFavorites();
  }

  List<HotelModel> _favorites = [];

  /// Synchronous check — safe to call inside BlocBuilder
  bool isFavorite(HotelModel hotel) =>
      _favorites.any((h) => h.id == hotel.id);

  // ── Toggle ────────────────────────────────────────────────────────────────

  Future<void> toggleFavorite(HotelModel hotel) async {
    if (isClosed) return;

    if (isFavorite(hotel)) {
      _favorites = _favorites.where((h) => h.id != hotel.id).toList();
    } else {
      _favorites = [..._favorites, hotel];
    }

    // Emit IMMEDIATELY — UI rebuilds before the async persist completes
    emit(FavoriteUpdated(List.unmodifiable(_favorites)));

    // Persist in background — errors are swallowed so UI stays consistent
    _persist().catchError((_) {});
  }

  // ── Load ──────────────────────────────────────────────────────────────────

  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList(_prefsKey) ?? [];
      _favorites = raw
          .map((s) => HotelModel.fromJson(jsonDecode(s) as Map<String, dynamic>))
          .toList();
      if (!isClosed) emit(FavoriteUpdated(List.unmodifiable(_favorites)));
    } catch (_) {
      _favorites = [];
      if (!isClosed) emit(FavoriteUpdated(const []));
    }
  }

  // ── Private ───────────────────────────────────────────────────────────────

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _prefsKey,
      _favorites.map((h) => jsonEncode(h.toJson())).toList(),
    );
  }
}