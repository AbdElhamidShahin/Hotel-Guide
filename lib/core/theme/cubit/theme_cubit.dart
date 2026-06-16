import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

/// Single source of truth for the app's [ThemeMode].
///
/// Persists the user's choice to [SharedPreferences] under [_key].
/// On first launch the system default is used.
///
/// Usage:
///   // Toggle from any widget:
///   context.read<ThemeCubit>().toggleTheme();
///
///   // Read current mode reactively:
///   context.watch<ThemeCubit>().state.isDark
class ThemeCubit extends Cubit<ThemeState> {
  static const String _key = 'app_theme_mode';

  ThemeCubit(ThemeMode initialMode) : super(ThemeState(initialMode));

  // ── Factory ───────────────────────────────────────────────────────────────

  /// Loads the saved [ThemeMode] from SharedPreferences.
  /// Call this once before [runApp] and pass the result to the constructor.
  static Future<ThemeMode> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    return switch (saved) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  // ── Public API ────────────────────────────────────────────────────────────

  /// Toggles between [ThemeMode.light] and [ThemeMode.dark].
  /// [ThemeMode.system] is treated as light for toggle purposes.
  Future<void> toggleTheme() async {
    final next = state.isDark ? ThemeMode.light : ThemeMode.dark;
    await _persist(next);
    emit(ThemeState(next));
  }

  /// Explicitly set a [ThemeMode].
  Future<void> setTheme(ThemeMode mode) async {
    await _persist(mode);
    emit(ThemeState(mode));
  }

  // ── Private ───────────────────────────────────────────────────────────────

  Future<void> _persist(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _modeToString(mode));
  }

  String _modeToString(ThemeMode mode) => switch (mode) {
    ThemeMode.dark => 'dark',
    ThemeMode.light => 'light',
    _ => 'system',
  };
}
