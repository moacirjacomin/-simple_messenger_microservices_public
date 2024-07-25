import 'package:flutter/material.dart';

// Link to get the color variants: https://material.io/design/color/the-color-system.html#tools-for-picking-colors
class AppColors {
  static const int _primaryValue = 0xFFE9B501;
  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFFCFCE5),
      100: Color(0xFFF8F6BF),
      200: Color(0xFFF3EF94),
      300: Color(0xFFEFE969),
      400: Color(0xFFECE546),
      500: Color(0xFFE9E01B),
      600: Color(0xFFE9CE13),
      700: Color(_primaryValue),
      800: Color(0xFFE89F00),
      900: Color(0xFFE67500),
    },
  );

  static const int _secondaryValue = 0xFF212121;
  static const MaterialColor secondary = MaterialColor(
    _secondaryValue,
    <int, Color>{
      50: Color(0xFFF5F5F5),
      100: Color(0xFFE9E9E9),
      200: Color(0xFFD9D9D9),
      300: Color(0xFFC4C4C4),
      400: Color(0xFF9D9D9D),
      500: Color(0xFF7B7B7B),
      600: Color(0xFF555555),
      700: Color(0xFF434343),
      800: Color(0xFF262626),
      900: Color(_secondaryValue),
    },
  );

  static const success = Color(0xFF14CCAC);
  static const error = Color(0xFFFF3F4A);
  static const buttonDisabled = Color(0xFFDBDBDB);
}
