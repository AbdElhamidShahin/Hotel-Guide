import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

/// All theme configuration lives here.
///
/// Usage in MaterialApp:
///   theme:      AppThemeData.light,
///   darkTheme:  AppThemeData.dark,
///   themeMode:  ThemeMode.light / ThemeMode.dark,
///
/// Widgets read colors via:
///   Theme.of(context).colorScheme.surface
///   Theme.of(context).colorScheme.onSurface
///   etc.
///
/// No file outside this one needs to know about light vs dark color values.
/// All dark-mode values here are kept in sync with AppColors dynamic getters.

abstract class AppThemeData {
  AppThemeData._();

  // ══════════════════════════════════════════════════════════════════════════
  // LIGHT THEME
  // ══════════════════════════════════════════════════════════════════════════
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Cairo',

    colorScheme: const ColorScheme.light(
      primary:                  AppColors.primary,
      onPrimary:                Color(0xFFFFFFFF),
      secondary:                AppColors.secondary,
      onSecondary:              AppColors.primary,
      error:                    AppColors.error,
      onError:                  Color(0xFFFFFFFF),

      // ── Surfaces ──────────────────────────────────────────────────
      // Matches AppColors light dynamic getters exactly.
      surface:                  Color(0xFFFFFFFF),    // AppColors.card light
      onSurface:                Color(0xFF101010),    // AppColors.textPrimary light
      surfaceContainerHighest:  Color(0xFFEFF0F6),   // AppColors.surfaceVariant light
      onSurfaceVariant:         Color(0xFF343434),   // AppColors.textSecondary light

      outline:                  Color(0xFFE9E9E9),   // AppColors.border light
      outlineVariant:           Color(0xFFD9D9D9),   // AppColors.divider light

      // surfaceTint repurposed as textMuted slot (avoids ThemeExtension).
      surfaceTint:              Color(0xFF6C7278),   // AppColors.textMuted light
    ),

    scaffoldBackgroundColor:    const Color(0xFFF9F9F9), // AppColors.scaffoldBackground light

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF9F9F9),
      foregroundColor: Color(0xFF101010),
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness:      Brightness.light,
        statusBarIconBrightness:  Brightness.dark,
        statusBarColor:           Colors.transparent,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:      Color(0xFFFFFFFF),
      selectedItemColor:    AppColors.primary,
      unselectedItemColor:  AppColors.ShadowPurple,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    cardTheme: CardThemeData(
      color:       const Color(0xFFFFFFFF),
      elevation:   2,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor:  Color(0xFFFFFFFF),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    dialogTheme: const DialogThemeData(
      backgroundColor:  Color(0xFFFFFFFF),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled:    true,
      fillColor: const Color(0xFFFFFFFF),
      hintStyle: const TextStyle(
        color:      Color(0xFFD9D9D9), // AppColors.hintTextGrey light
        fontFamily: 'Cairo',
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE9E9E9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color:     Color(0xFFD9D9D9), // AppColors.divider light
      thickness: 0.5,
      space:     1,
    ),

    iconTheme: const IconThemeData(color: AppColors.ShadowPurple),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primary),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(47)),
      ),
    ),

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.primary,
      contentTextStyle: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'Cairo'),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : const Color(0xFFD9D9D9)),
      trackColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected)
          ? AppColors.primary.withOpacity(0.3)
          : const Color(0xFFE9E9E9)),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFEFF0F6),
      selectedColor:   AppColors.primary,
      labelStyle:      const TextStyle(fontFamily: 'Cairo'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    textTheme: const TextTheme(
      displayLarge:   TextStyle(fontFamily: 'Cairo', fontSize: 36, fontWeight: FontWeight.w700, color: Color(0xFF101010)),
      displayMedium:  TextStyle(fontFamily: 'Cairo', fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFF101010)),
      headlineLarge:  TextStyle(fontFamily: 'Cairo', fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF101010)),
      headlineMedium: TextStyle(fontFamily: 'Cairo', fontSize: 25, fontWeight: FontWeight.w400, color: Color(0xFF101010)),
      headlineSmall:  TextStyle(fontFamily: 'Cairo', fontSize: 23, fontWeight: FontWeight.w600, color: Color(0xFF101010)),
      titleLarge:     TextStyle(fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF101010)),
      titleMedium:    TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF101010)),
      titleSmall:     TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF343434)),
      bodyLarge:      TextStyle(fontFamily: 'Cairo', fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xFF343434)),
      bodyMedium:     TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF6C7278)),
      bodySmall:      TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6C7278)),
      labelLarge:     TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF939393)),
      labelMedium:    TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF101010)),
      labelSmall:     TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF939393)),
    ),
  );

  // ══════════════════════════════════════════════════════════════════════════
  // DARK THEME
  // All values are taken directly from AppColors dynamic getters so that
  // the ThemeData palette and the AppColors palette are always in sync.
  //
  //  AppColors.scaffoldBackground dark  →  0xFF13131F   (deep navy black)
  //  AppColors.card dark                →  0xFF1C1C28   (warm dark card)
  //  AppColors.surfaceVariant dark      →  0xFF26263A   (field / chip bg)
  //  AppColors.border dark              →  0xFF35354A   (outline)
  //  AppColors.divider dark             →  0xFF404058   (divider)
  //  AppColors.textPrimary dark         →  0xFFEAEAF0   (warm white)
  //  AppColors.textSecondary dark       →  0xFFD4D4E8   (readable secondary)
  //  AppColors.textMuted dark           →  0xFFA0A0B8   (muted)
  //  AppColors.hintTextGrey dark        →  0xFF707088   (hint)
  // ══════════════════════════════════════════════════════════════════════════
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Cairo',

    colorScheme: const ColorScheme.dark(
      primary:                  AppColors.primary,
      onPrimary:                Color(0xFFFFFFFF),
      secondary:                AppColors.secondary,
      onSecondary:              AppColors.primary,
      error:                    AppColors.error,
      onError:                  Color(0xFFFFFFFF),

      // ── Surfaces — synced with AppColors dark getters ──────────────
      surface:                  Color(0xFF1C1C28),   // AppColors.card dark
      onSurface:                Color(0xFFEAEAF0),   // AppColors.textPrimary dark  ← was 0xFFF1F1F1
      surfaceContainerHighest:  Color(0xFF26263A),   // AppColors.surfaceVariant dark  ← was 0xFF2A2A3D
      onSurfaceVariant:         Color(0xFFD4D4E8),   // AppColors.textSecondary dark  ← was 0xFFCCCCCC

      outline:                  Color(0xFF35354A),   // AppColors.border dark  ← was 0xFF2E2E3E
      outlineVariant:           Color(0xFF404058),   // AppColors.divider dark  ← was 0xFF3A3A4A

      surfaceTint:              Color(0xFFA0A0B8),   // AppColors.textMuted dark  ← was 0xFF9E9E9E
    ),

    // AppColors.scaffoldBackground dark  ← was 0xFF171725
    scaffoldBackgroundColor: const Color(0xFF13131F),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF13131F),  // same as scaffold
      foregroundColor: Color(0xFFEAEAF0),  // AppColors.textPrimary dark
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness:      Brightness.dark,
        statusBarIconBrightness:  Brightness.light,
        statusBarColor:           Colors.transparent,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:      Color(0xFF1C1C28),   // AppColors.card dark
      selectedItemColor:    AppColors.secondary,
      unselectedItemColor:  Color(0xFFA0A0B8),   // AppColors.textMuted dark
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    cardTheme: CardThemeData(
      color:       const Color(0xFF1C1C28),  // AppColors.card dark
      elevation:   0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF35354A)), // AppColors.border dark
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor:  Color(0xFF1C1C28),  // AppColors.card dark
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    dialogTheme: const DialogThemeData(
      backgroundColor:  Color(0xFF1C1C28),  // AppColors.card dark
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled:    true,
      fillColor: const Color(0xFF26263A), // AppColors.surfaceVariant dark
      hintStyle: const TextStyle(
        color:      Color(0xFF707088),    // AppColors.hintTextGrey dark
        fontFamily: 'Cairo',
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF35354A)), // AppColors.border dark
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.secondary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color:     Color(0xFF404058), // AppColors.divider dark
      thickness: 0.5,
      space:     1,
    ),

    iconTheme: const IconThemeData(
      color: Color(0xFFD4D4E8), // AppColors.textSecondary dark — clearer icons
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.secondary),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.secondary,
        side: const BorderSide(color: AppColors.secondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(47)),
      ),
    ),

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF26263A), // AppColors.surfaceVariant dark
      contentTextStyle: TextStyle(
        color:      Color(0xFFEAEAF0), // AppColors.textPrimary dark
        fontFamily: 'Cairo',
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected)
          ? AppColors.secondary
          : const Color(0xFF707088)), // AppColors.hintTextGrey dark
      trackColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected)
          ? AppColors.secondary.withOpacity(0.3)
          : const Color(0xFF35354A)), // AppColors.border dark
    ),

    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF26263A), // AppColors.surfaceVariant dark
      selectedColor:   AppColors.primary,
      labelStyle: const TextStyle(
        fontFamily: 'Cairo',
        color:      Color(0xFFEAEAF0), // AppColors.textPrimary dark
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    textTheme: const TextTheme(
      displayLarge:   TextStyle(fontFamily: 'Cairo', fontSize: 36, fontWeight: FontWeight.w700, color: Color(0xFFEAEAF0)),
      displayMedium:  TextStyle(fontFamily: 'Cairo', fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFFEAEAF0)),
      headlineLarge:  TextStyle(fontFamily: 'Cairo', fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFFEAEAF0)),
      headlineMedium: TextStyle(fontFamily: 'Cairo', fontSize: 25, fontWeight: FontWeight.w400, color: Color(0xFFEAEAF0)),
      headlineSmall:  TextStyle(fontFamily: 'Cairo', fontSize: 23, fontWeight: FontWeight.w600, color: Color(0xFFEAEAF0)),
      titleLarge:     TextStyle(fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFFEAEAF0)),
      titleMedium:    TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFFEAEAF0)),
      titleSmall:     TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFFD4D4E8)), // AppColors.textSecondary dark
      bodyLarge:      TextStyle(fontFamily: 'Cairo', fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xFFD4D4E8)),
      bodyMedium:     TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFA0A0B8)), // AppColors.textMuted dark
      bodySmall:      TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFA0A0B8)),
      labelLarge:     TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF707088)), // AppColors.hintTextGrey dark
      labelMedium:    TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFEAEAF0)),
      labelSmall:     TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF707088)),
    ),
  );
}

// ══════════════════════════════════════════════════════════════════════════════
// APP TEXT STYLES
// ══════════════════════════════════════════════════════════════════════════════

class AppTextStyles {
  AppTextStyles._();

  static ColorScheme _cs(BuildContext ctx) => Theme.of(ctx).colorScheme;
  static TextTheme   _tt(BuildContext ctx) => Theme.of(ctx).textTheme;

  // ── Always-white styles (on brand-colour surfaces) ────────────────────────
  static TextStyle font20RegularWhite(BuildContext ctx) =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'Cairo', color: Colors.white.withOpacity(0.53));

  static TextStyle font16MediumWhite(BuildContext ctx) =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Cairo', color: Colors.white.withOpacity(0.40));

  static TextStyle font22RegularWhite(BuildContext ctx) =>
      TextStyle(fontSize: 22, fontWeight: FontWeight.w400, fontFamily: 'Cairo', color: Colors.white.withOpacity(0.53));

  static TextStyle font14SemiBoldWhite(BuildContext ctx) =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Cairo', color: Colors.white);

  static TextStyle font16BoldWhite(BuildContext ctx) =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Cairo', color: Colors.white);

  static TextStyle font22BoldPrimary(BuildContext ctx) =>
      const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Cairo', color: Colors.white);

  static TextStyle font25RegularWhite(BuildContext ctx) =>
      const TextStyle(fontSize: 25, fontWeight: FontWeight.w400, fontFamily: 'Cairo', color: Colors.white);

  static TextStyle font36BoldWhite(BuildContext ctx) =>
      const TextStyle(fontSize: 36, fontWeight: FontWeight.w700, fontFamily: 'Cairo', color: Colors.white);

  // ── Dynamic styles ────────────────────────────────────────────────────────

  static TextStyle font23SemiBoldBlack(BuildContext ctx) =>
      TextStyle(fontSize: 23, fontWeight: FontWeight.w600, fontFamily: 'Cairo', color: _cs(ctx).onSurfaceVariant);

  static TextStyle font17MediumBlack(BuildContext ctx) =>
      TextStyle(fontSize: 17, fontWeight: FontWeight.w500, fontFamily: 'Cairo', color: _cs(ctx).onSurfaceVariant.withOpacity(0.65));

  static TextStyle font15MediumGray(BuildContext ctx) =>
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Cairo', color: _tt(ctx).labelLarge?.color);

  static TextStyle font18BoldGray(BuildContext ctx) =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Cairo', color: _cs(ctx).onSurfaceVariant);

  static TextStyle font12BoldBlack(BuildContext ctx) =>
      TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Cairo', color: _cs(ctx).onSurface);

  static TextStyle font30BoldPrimary(BuildContext ctx) =>
      const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, fontFamily: 'Cairo', color: AppColors.primary);

  static TextStyle font20RegularPrimary(BuildContext ctx) =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontFamily: 'Cairo', color: AppColors.primary.withOpacity(0.70));

  static TextStyle font16RegularMuted(BuildContext ctx) =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Cairo', color: _cs(ctx).surfaceTint);

  static TextStyle font14RegularNightfall(BuildContext ctx) =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Cairo', color: _cs(ctx).onSurfaceVariant.withOpacity(0.75));

  static TextStyle font20BoldShadowPurple(BuildContext ctx) =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Cairo', color: AppColors.ShadowPurple);

  static TextStyle font18RegularShadowPurple(BuildContext ctx) =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: 'Cairo', color: AppColors.ShadowPurple);

  static TextStyle font17RegularPrimary(BuildContext ctx) =>
      const TextStyle(fontSize: 17, fontWeight: FontWeight.w400, fontFamily: 'Cairo', color: AppColors.primary);

  static TextStyle font23RegularPrimary(BuildContext ctx) =>
      const TextStyle(fontSize: 23, fontWeight: FontWeight.w400, fontFamily: 'Cairo', color: AppColors.primary);

  static TextStyle font28BoldBlack(BuildContext ctx) =>
      TextStyle(fontSize: 28, fontWeight: FontWeight.w700, fontFamily: 'Cairo', color: _cs(ctx).onSurface);

  static TextStyle font12SemiBoldShadowPurple(BuildContext ctx) =>
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Cairo', color: AppColors.ShadowPurple);

  static TextStyle font12RegularDisabled(BuildContext ctx) =>
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Cairo', color: _tt(ctx).labelSmall?.color);
}