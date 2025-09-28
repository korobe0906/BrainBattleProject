import 'package:flutter/material.dart';

class BBPalette {
  static const pink50  = Color(0xFFFFE5EC); // #ffe5ec
  static const pink100 = Color(0xFFFFC2D1); // #ffc2d1
  static const pink200 = Color(0xFFFFB3C6); // #ffb3c6
  static const pink300 = Color(0xFFFF8FAB); // #ff8fab
  static const pink400 = Color(0xFFFB6F92); // #fb6f92

  // Tạo ColorScheme nhẹ nhàng cho Material 3
  static ColorScheme scheme(Brightness b) {
    final primary = pink400;
    return ColorScheme(
      brightness: b,
      primary: primary,
      onPrimary: Colors.white,
      secondary: pink300,
      onSecondary: Colors.white,
      surface: b == Brightness.light ? pink50 : const Color(0xFF121212),
      onSurface: b == Brightness.light ? const Color(0xFF222222) : Colors.white,
      background: b == Brightness.light ? Colors.white : const Color(0xFF0E0E0E),
      onBackground: b == Brightness.light ? const Color(0xFF222222) : Colors.white,
      error: Colors.red,
      onError: Colors.white,
      primaryContainer: pink100,
      onPrimaryContainer: const Color(0xFF4A1E2F),
      secondaryContainer: pink200,
      onSecondaryContainer: const Color(0xFF4A1E2F),
      surfaceContainerHighest: Colors.white,
      // các trường còn lại M3 sẽ tự suy ra
      tertiary: pink200,
      onTertiary: const Color(0xFF4A1E2F),
      tertiaryContainer: pink100,
      onTertiaryContainer: const Color(0xFF4A1E2F),
      surfaceVariant: pink100,
      onSurfaceVariant: const Color(0xFF4A1E2F),
      outline: pink300,
      outlineVariant: pink100,
      scrim: Colors.black54,
      inverseSurface: const Color(0xFF2A2A2A),
      onInverseSurface: Colors.white,
      inversePrimary: pink200,
      shadow: Colors.black26,
    );
  }
}
