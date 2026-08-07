import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AngelusColors {
  const AngelusColors._();

  static const Color night = Color(0xFF14110F);
  static const Color ivory = Color(0xFFF4EFE6);
  static const Color muted = Color(0xFF8C837A);
  static const Color gold = Color(0xFFC9A96A);
}

class AppTheme {
  const AppTheme._();

  static ThemeData get dark {
    final ThemeData base = ThemeData.dark(useMaterial3: true);
    final TextTheme serif =
        GoogleFonts.cormorantGaramondTextTheme(base.textTheme);

    return base.copyWith(
      scaffoldBackgroundColor: AngelusColors.night,
      colorScheme: base.colorScheme.copyWith(
        primary: AngelusColors.gold,
        surface: AngelusColors.night,
        onSurface: AngelusColors.ivory,
      ),
      textTheme: serif.copyWith(
        displaySmall: serif.displaySmall?.copyWith(
          color: AngelusColors.ivory,
          fontSize: 34,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.5,
          height: 1.3,
        ),
        bodyMedium: serif.bodyMedium?.copyWith(
          color: AngelusColors.muted,
          fontSize: 17,
          height: 1.6,
        ),
        bodySmall: serif.bodySmall?.copyWith(
          color: AngelusColors.muted,
          fontSize: 16,
          fontStyle: FontStyle.italic,
          height: 1.7,
        ),
        labelSmall: serif.labelSmall?.copyWith(
          color: AngelusColors.muted,
          fontSize: 12,
          letterSpacing: 3.2,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: serif.labelLarge?.copyWith(
          color: AngelusColors.ivory,
          fontSize: 15,
          letterSpacing: 3.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AngelusColors.muted),
      ),
    );
  }
}