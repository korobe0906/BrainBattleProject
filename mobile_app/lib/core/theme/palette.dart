import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Legacy compatibility palette.
/// New code should use Theme.of(context).extension<...>() or ThemeContextX.
abstract final class BBColors {
  static final Color darkBg = AppColorSchemes.dark.backgroundPrimary;
  static final Color darkSurface = AppColorSchemes.dark.surfacePrimary;
  static final Color darkSurfaceSecondary =
      AppColorSchemes.dark.surfaceSecondary;

  static const Color brandPink = Color(0xFFFF8FAB);
  static const Color brandRose = Color(0xFFF3B4C3);
  static const Color brandSoft = Color(0xFFFFC4D6);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color error = Color(0xFFFF6B6B);
  static const Color success = Color(0xFF48BB78);
}

abstract final class BBPalette {
  static final Color darkBg = BBColors.darkBg;
  static final Color darkSurface = BBColors.darkSurface;
  static final Color darkSurfaceSecondary = BBColors.darkSurfaceSecondary;

  static const Color brandPink = BBColors.brandPink;
  static const Color brandRose = BBColors.brandRose;
  static const Color brandSoft = BBColors.brandSoft;

  static const Color white = BBColors.white;
  static const Color black = BBColors.black;
  static const Color error = BBColors.error;
  static const Color success = BBColors.success;
}
