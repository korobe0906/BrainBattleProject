import 'package:flutter/material.dart';

@immutable
class AppSemanticColors {
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color borderSubtle;
  final Color borderStrong;
  final Color textPrimary;
  final Color textSecondary;
  final Color textInverse;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  const AppSemanticColors({
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.borderSubtle,
    required this.borderStrong,
    required this.textPrimary,
    required this.textSecondary,
    required this.textInverse,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  static AppSemanticColors lerp(
    AppSemanticColors a,
    AppSemanticColors b,
    double t,
  ) {
    return AppSemanticColors(
      backgroundPrimary: Color.lerp(a.backgroundPrimary, b.backgroundPrimary, t)!,
      backgroundSecondary:
          Color.lerp(a.backgroundSecondary, b.backgroundSecondary, t)!,
      surfacePrimary: Color.lerp(a.surfacePrimary, b.surfacePrimary, t)!,
      surfaceSecondary: Color.lerp(a.surfaceSecondary, b.surfaceSecondary, t)!,
      borderSubtle: Color.lerp(a.borderSubtle, b.borderSubtle, t)!,
      borderStrong: Color.lerp(a.borderStrong, b.borderStrong, t)!,
      textPrimary: Color.lerp(a.textPrimary, b.textPrimary, t)!,
      textSecondary: Color.lerp(a.textSecondary, b.textSecondary, t)!,
      textInverse: Color.lerp(a.textInverse, b.textInverse, t)!,
      success: Color.lerp(a.success, b.success, t)!,
      warning: Color.lerp(a.warning, b.warning, t)!,
      error: Color.lerp(a.error, b.error, t)!,
      info: Color.lerp(a.info, b.info, t)!,
    );
  }
}

@immutable
class AuthSemanticColors {
  final Color accent;
  final Color accentSoft;
  final Color cardBackground;
  final Color inputBackground;
  final Color heroGlow;
  final Color brandPrimary;
  final Color brandSecondary;
  final Color brandTertiary;

  const AuthSemanticColors({
    required this.accent,
    required this.accentSoft,
    required this.cardBackground,
    required this.inputBackground,
    required this.heroGlow,
    required this.brandPrimary,
    required this.brandSecondary,
    required this.brandTertiary,
  });

  static AuthSemanticColors lerp(
    AuthSemanticColors a,
    AuthSemanticColors b,
    double t,
  ) {
    return AuthSemanticColors(
      accent: Color.lerp(a.accent, b.accent, t)!,
      accentSoft: Color.lerp(a.accentSoft, b.accentSoft, t)!,
      cardBackground: Color.lerp(a.cardBackground, b.cardBackground, t)!,
      inputBackground: Color.lerp(a.inputBackground, b.inputBackground, t)!,
      heroGlow: Color.lerp(a.heroGlow, b.heroGlow, t)!,
      brandPrimary: Color.lerp(a.brandPrimary, b.brandPrimary, t)!,
      brandSecondary: Color.lerp(a.brandSecondary, b.brandSecondary, t)!,
      brandTertiary: Color.lerp(a.brandTertiary, b.brandTertiary, t)!,
    );
  }
}

@immutable
class BattleSemanticColors {
  final Color accent;
  final Color accentSoft;
  final Color panelBackground;
  final Color panelBorder;
  final Color glow;
  final Color victory;
  final Color danger;

  const BattleSemanticColors({
    required this.accent,
    required this.accentSoft,
    required this.panelBackground,
    required this.panelBorder,
    required this.glow,
    required this.victory,
    required this.danger,
  });

  static BattleSemanticColors lerp(
    BattleSemanticColors a,
    BattleSemanticColors b,
    double t,
  ) {
    return BattleSemanticColors(
      accent: Color.lerp(a.accent, b.accent, t)!,
      accentSoft: Color.lerp(a.accentSoft, b.accentSoft, t)!,
      panelBackground: Color.lerp(a.panelBackground, b.panelBackground, t)!,
      panelBorder: Color.lerp(a.panelBorder, b.panelBorder, t)!,
      glow: Color.lerp(a.glow, b.glow, t)!,
      victory: Color.lerp(a.victory, b.victory, t)!,
      danger: Color.lerp(a.danger, b.danger, t)!,
    );
  }
}

abstract final class AppColorSchemes {
  static const AppSemanticColors dark = AppSemanticColors(
    backgroundPrimary: Color(0xFF070B14),
    backgroundSecondary: Color(0xFF111827),
    surfacePrimary: Color(0xFF19142A),
    surfaceSecondary: Color(0xFF251A3A),
    borderSubtle: Color(0x334B2D75),
    borderStrong: Color(0x995B2D91),
    textPrimary: Color(0xFFFDF7FF),
    textSecondary: Color(0xB8D7CFE6),
    textInverse: Color(0xFF080A10),
    success: Color(0xFF00D79F),
    warning: Color(0xFFFFD600),
    error: Color(0xFFFF4D6D),
    info: Color(0xFF00D9FF),
  );

  static const AppSemanticColors light = AppSemanticColors(
    backgroundPrimary: Color(0xFFF8F4FF),
    backgroundSecondary: Color(0xFFFFFFFF),
    surfacePrimary: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF1E7FF),
    borderSubtle: Color(0x334B2D75),
    borderStrong: Color(0x665B2D91),
    textPrimary: Color(0xFF161124),
    textSecondary: Color(0xFF645772),
    textInverse: Color(0xFFFFFFFF),
    success: Color(0xFF00A77B),
    warning: Color(0xFFE0A800),
    error: Color(0xFFE4375D),
    info: Color(0xFF0098C9),
  );

  static const AuthSemanticColors authDark = AuthSemanticColors(
    accent: Color(0xFFC64BFF),
    accentSoft: Color(0xFF4D1B76),
    cardBackground: Color(0xD923173A),
    inputBackground: Color(0xCC221832),
    heroGlow: Color(0x55C64BFF),
    brandPrimary: Color(0xFFFF70B8),
    brandSecondary: Color(0xFFC64BFF),
    brandTertiary: Color(0xFF19D4FF),
  );

  static const AuthSemanticColors authLight = AuthSemanticColors(
    accent: Color(0xFFA63CFF),
    accentSoft: Color(0xFFEBD7FF),
    cardBackground: Color(0xEFFFFFFF),
    inputBackground: Color(0xFFF3E9FF),
    heroGlow: Color(0x33A63CFF),
    brandPrimary: Color(0xFFFF5DAE),
    brandSecondary: Color(0xFFA63CFF),
    brandTertiary: Color(0xFF00B7E6),
  );

  static const BattleSemanticColors battleDark = BattleSemanticColors(
    accent: Color(0xFF00D9FF),
    accentSoft: Color(0xFF063A4D),
    panelBackground: Color(0xDD15142A),
    panelBorder: Color(0x663E2A73),
    glow: Color(0x5500D9FF),
    victory: Color(0xFF00D79F),
    danger: Color(0xFFFF4D6D),
  );

  static const BattleSemanticColors battleLight = BattleSemanticColors(
    accent: Color(0xFF00A8D6),
    accentSoft: Color(0xFFD8F7FF),
    panelBackground: Color(0xEEFFFFFF),
    panelBorder: Color(0x334B2D75),
    glow: Color(0x3300A8D6),
    victory: Color(0xFF00A77B),
    danger: Color(0xFFE4375D),
  );
}