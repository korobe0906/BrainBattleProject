import 'package:flutter/material.dart';

class BBColors {
  static const Color yellow = Color(0xFFF1C40F);
  static const Color darkBg = Color(0xFF0F141A);
  static const Color darkCard = Color(0xFF1B222A);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFBFC7CF);
}

ThemeData bbDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: BBColors.darkBg,
    colorScheme: const ColorScheme.dark(
      primary: BBColors.yellow,
      secondary: BBColors.yellow,
    ),
    useMaterial3: true,
  );
}
