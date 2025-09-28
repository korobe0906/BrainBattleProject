import 'package:flutter/material.dart';
import 'palette.dart';

ThemeData bbDarkTheme()  => ThemeData(useMaterial3: true, colorScheme: BBPalette.scheme(Brightness.dark));
ThemeData bbLightTheme() => ThemeData(useMaterial3: true, colorScheme: BBPalette.scheme(Brightness.light));

class BBColors {
  static const Color yellow = Color(0xFFF1C40F);
  static const Color darkBg = Color(0xFF0F141A);
  static const Color darkCard = Color(0xFF1B222A);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFBFC7CF);
}

