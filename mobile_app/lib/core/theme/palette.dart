import 'package:flutter/material.dart';

class BBPalette {
  // Dải hồng bạn đã có
  static const pink50  = Color(0xFFFFE5EC);
  static const pink100 = Color(0xFFFFC2D1);
  static const pink200 = Color(0xFFFFB3C6);
  static const pink300 = Color(0xFFFF8FAB);
  static const pink400 = Color(0xFFFB6F92);

  // Alias + thêm vài màu dùng chung (không xóa cái hiện có)
  static const pink   = Color(0xFFFF66CC);
  static const purple = Color(0xFF9B66FF);

  static const Color darkBg  = Color(0xFF0E0A14);
  static const Color glass   = Color(0x0FFFFFFF);
  static const Color surface = Color(0x1AFFFFFF);
  static const Color text    = Color(0xFFECE7F6);
  static const Color textDim = Color(0xFFBFB6D6);
  static const Color success = Color(0xFF43E6A2);
  static const Color warning = Color(0xFFFFB960);
  static const Color danger  = Color(0xFFFF6B6B);

  // ColorScheme M3
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
