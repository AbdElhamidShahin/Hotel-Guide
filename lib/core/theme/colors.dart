import 'package:flutter/material.dart';

class AppColors {
  // ── تحكم في الـ mode من هنا ──────────────────────
  static bool isDark = false;

  // ── Brand (ثابتة مش بتتغير) ──────────────────────
  static const Color primary       = Color(0xFF2D2B3E);
  static const Color secondary     = Color(0xFFFFBD59);
  static const Color accent        = Color(0xFF6547D0);
  static const Color textWhite     = Color(0xFFFFFFFF);
  static const Color nightfall     = Color(0xFF1A1C1E);
  static const Color ShadowPurple  = Color(0xFF575472);
  static const Color PurplePrimary = Color(0xFF3E3C53);
  static const Color AccentsPurple = Color(0xFF958FFF);
  static const Color Purple        = Color(0xFF8A38F5);
  static const Color primaryDark   = Color(0xFF2D2D3F);
  static const Color orangeGold    = Color(0xFFFFBD54);
  static const Color warningColor  = Color(0xFFC8C8F4);
  static const Color success       = Color(0xFF26CC73);
  static const Color error         = Color(0xFFFF3838);
  static const Color warning       = Color(0xFFFFC15F);
  static const Color info          = Color(0xFFCFDBEC);
  static const Color dangerRed     = Color(0xFFE57373);
  static const Color LightRed      = Color(0xFFFF7D86);
  static const Color softGray      = Color(0xFFD9DDDF);
  static const Color Grayscale     = Color(0xFF66707A);
  static const Color colorText     = Color(0xFF51526C);
  static const Color textGrey      = Color(0xFF6B6B80);
  static final  Color SlateBlueLight = Color(0xFF999AAD).withOpacity(0.3);

  // ── Dynamic (بتتغير مع الـ Dark Mode) ────────────
  static Color get textPrimary =>
      isDark ? const Color(0xFFF1F1F1) : const Color(0xFF101010);

  static Color get textSecondary =>
      isDark ? const Color(0xFFCCCCCC) : const Color(0xFF343434);

  static Color get textMuted =>
      isDark ? const Color(0xFF9E9E9E) : const Color(0xFF6C7278);

  static Color get textDisabled =>
      isDark ? const Color(0xFF616161) : const Color(0xFF939393);

  static Color get pureBlack =>
      isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

  static Color get background =>
      isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F7);

  static Color get scaffoldBackground =>
      isDark ? const Color(0xFF171725) : const Color(0xFFF9F9F9);

  static Color get surfaceVariant =>
      isDark ? const Color(0xFF2A2A3D) : const Color(0xFFEFF0F6);

  static Color get border =>
      isDark ? const Color(0xFF2E2E3E) : const Color(0xFFE9E9E9);

  static Color get divider =>
      isDark ? const Color(0xFF3A3A4A) : const Color(0xFFD9D9D9);

  static Color get card =>
      isDark ? const Color(0xFF1E1E2C) : const Color(0xFFFFFFFF);

  static Color get hintTextGrey =>
      isDark ? const Color(0xFF555565) : const Color(0xFFD9D9D9);

  static Color get textTitle =>
      isDark ? const Color(0xFFF1F1F1) : const Color(0xFF222222);

  static Color get darkBackground =>
      isDark ? const Color(0xFF0D0D1A) : const Color(0xFF171725);
}