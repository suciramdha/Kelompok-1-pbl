import 'package:flutter/material.dart';

/// Typography Seblak Lokuak — Plus Jakarta Sans.
abstract final class AppTypography {
  static const fontFamily = 'PlusJakartaSans';

  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 30,
      height: 1.2,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.6,
    ),
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 22,
      height: 1.2727,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.22,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      height: 1.3,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      height: 1.3333,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 1.375,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 1.4286,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      height: 1.3333,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 1.2857,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.14,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      height: 1.3333,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.24,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      height: 1.2727,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.33,
    ),
  );

  /// Style khusus harga; warna diberikan dari theme di widget.
  static const TextStyle price = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 1.2222,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.18,
  );
}
