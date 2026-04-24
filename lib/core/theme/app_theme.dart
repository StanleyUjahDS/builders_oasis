import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_theme_extension.dart';

class AppTheme {
  //  TEXT THEME (shared across app)
  static TextTheme _textTheme(Color textColor) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),

      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),

      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),

      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),

      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.4,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.4,
      ),

      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),

      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.3,
      ),
    );
  }

  //  DARK THEME
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: Colors.transparent,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.red500,
      secondary: AppColors.red400,
      surface: AppColors.darkSurface,
    ),

    textTheme: _textTheme(Colors.white),

    extensions: const [
      AppThemeExtension(
        success: Colors.green,
        warning: Colors.orange,
      ),
    ],

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    cardColor: AppColors.darkSurface,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.red500,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  //  LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: Colors.transparent,

    colorScheme: const ColorScheme.light(
      primary: AppColors.red500,
      secondary: AppColors.red300,
      surface: Colors.white,
    ),

    textTheme: _textTheme(Colors.black),

    extensions: const [
      AppThemeExtension(
        success: Colors.green,
        warning: Colors.orange,
      ),
    ],

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    cardColor: Colors.white,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.red500,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}