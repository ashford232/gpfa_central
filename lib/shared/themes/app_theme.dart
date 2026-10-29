import 'package:flutter/material.dart';
import 'package:gpfa_central/shared/utls/extensions.dart';

class AppTheme {
  AppTheme._();

  // GPFA brand colors extracted from the logo.
  static const Color gold = Color(0xFFA67E44);
  static const Color darkGold = Color(0xFF6F4B20);
  static const Color lightGold = Color(0xFFD5B878);

  static const Color woodBrown = Color(0xFF5F370F);
  static const Color deepBrown = Color(0xFF220C04);
  static const Color cream = Color(0xFFFCF9F2);

  // Light theme
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.light(
      // Primary — GPFA gold
      primary: const Color(0xFFA67E44),
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFFF0E2C5),
      onPrimaryContainer: Color(0xFF39250B),
      inversePrimary: Color(0xFFD5B878),

      // Secondary — wood brown
      secondary: Color(0xFF76502A),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE9DCC9),
      onSecondaryContainer: Color(0xFF392312),

      // Tertiary — complementary warm bronze
      tertiary: Color(0xFF846746),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFF2DFC5),
      onTertiaryContainer: Color(0xFF2D1D0C),

      // Error
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),

      // Main surfaces
      surface: Color(0xFFFFFDF9),
      onSurface: Color(0xFFFFFDF9).appropriateTextColor,
      surfaceDim: Color(0xFFE5DED4),
      surfaceBright: Color(0xFFFFFDF9),

      // Surface containers
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFFAF5ED),
      surfaceContainer: Color(0xFFF4EEE5),
      surfaceContainerHigh: Color(0xFFEDE5DA),
      surfaceContainerHighest: Color(0xFFE5DCCF),

      // Surface variants
      onSurfaceVariant: Color(0xFF51483B),
      surfaceTint: Color(0xFFA67E44),

      // Borders
      outline: Color(0xFF857969),
      outlineVariant: Color(0xFFE0D5C5),

      // Overlays
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Inverse surfaces
      inverseSurface: Color(0xFF342C22),
      onInverseSurface: Color(0xFFF7EFE4),
    ),
    scaffoldBackgroundColor: Color(0xFFFFFDF9),
    dividerColor: const Color(0xFFDCD1BF),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFDF9),
      foregroundColor: deepBrown,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFFFFDF9),
      hintStyle: const TextStyle(color: Color(0xFF8D8374)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE4DACC)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE4DACC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: gold, width: 1.5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: gold,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );

  // Dark theme
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      // Primary — GPFA gold
      primary: Color(0xFFD5B878),
      onPrimary: Color(0xFF242018),
      primaryContainer: Color(0xFF514222),
      onPrimaryContainer: Color(0xFFF5E6BF),
      inversePrimary: Color(0xFFA67E44),

      // Secondary — neutral gray
      secondary: Color(0xFFB8B9C0),
      onSecondary: Color(0xFF25262B),
      secondaryContainer: Color(0xFF3B3C43),
      onSecondaryContainer: Color(0xFFE2E2E8),

      // Tertiary — muted gold
      tertiary: Color(0xFFE0C995),
      onTertiary: Color(0xFF292213),
      tertiaryContainer: Color(0xFF4A4029),
      onTertiaryContainer: Color(0xFFF4E5C2),

      // Error
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),

      // Main surfaces
      surface: Color(0xFF18191C),
      onSurface: Color(0xFFE8E8EB),
      surfaceDim: Color(0xFF111214),
      surfaceBright: Color(0xFF393A3F),

      // Surface containers
      surfaceContainerLowest: Color(0xFF101113),
      surfaceContainerLow: Color(0xFF1D1E22),
      surfaceContainer: Color(0xFF222328),
      surfaceContainerHigh: Color(0xFF2B2C32),
      surfaceContainerHighest: Color(0xFF35363D),

      // Surface variants
      onSurfaceVariant: Color(0xFFC2C3CA),
      surfaceTint: Color(0xFFD5B878),

      // Borders
      outline: Color(0xFF85868F),
      outlineVariant: Color(0xFF45464D),

      // Overlays
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Inverse surfaces
      inverseSurface: Color(0xFFE8E8EB),
      onInverseSurface: Color(0xFF292A2F),
    ),

    scaffoldBackgroundColor: Color(0xFF18191C),
    dividerColor: const Color(0xFF493B2D),

    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF18191C),
      foregroundColor: Color(0xFF18191C).appropriateTextColor,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF241A11),
      hintStyle: const TextStyle(color: Color(0xFFB2A28D)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF493B2D)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF493B2D)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightGold, width: 1.5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightGold,
        foregroundColor: const Color(0xFF291B08),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}
