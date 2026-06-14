part of 'theme_cubit.dart';

class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);

  bool get isDark => themeMode == ThemeMode.dark;
}
