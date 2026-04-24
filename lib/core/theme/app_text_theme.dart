import 'package:flutter/material.dart';

class AppTextTheme {
  static const String fontFamily = "Poppins";

  //  DISPLAY (App name / splash / hero screens)
  static TextStyle displayLarge = const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle displayMedium = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  //  HEADINGS (screen titles)
  static TextStyle headingLarge = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle headingMedium = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static TextStyle headingSmall = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  //  BODY TEXT (descriptions / content)
  static TextStyle bodyLarge = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    height: 1.4,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    height: 1.4,
  );

  static TextStyle bodySmall = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  //  CAPTION / SUPPORT TEXT
  static TextStyle caption = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  //  BUTTON TEXT
  static TextStyle button = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
    letterSpacing: 0.3,
  );
}