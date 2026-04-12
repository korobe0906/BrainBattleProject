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

  AppSemanticColors copyWith({
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? borderSubtle,
    Color? borderStrong,
    Color? textPrimary,
    Color? textSecondary,
    Color? textInverse,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
  }) {
    return AppSemanticColors(
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderStrong: borderStrong ?? this.borderStrong,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textInverse: textInverse ?? this.textInverse,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
    );
  }

  static AppSemanticColors lerp(
    AppSemanticColors a,
    AppSemanticColors b,
    double t,
  ) {
    return AppSemanticColors(
      backgroundPrimary: Color.lerp(
        a.backgroundPrimary,
        b.backgroundPrimary,
        t,
      )!,
      backgroundSecondary: Color.lerp(
        a.backgroundSecondary,
        b.backgroundSecondary,
        t,
      )!,
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

  AuthSemanticColors copyWith({
    Color? accent,
    Color? accentSoft,
    Color? cardBackground,
    Color? inputBackground,
    Color? heroGlow,
    Color? brandPrimary,
    Color? brandSecondary,
    Color? brandTertiary,
  }) {
    return AuthSemanticColors(
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      cardBackground: cardBackground ?? this.cardBackground,
      inputBackground: inputBackground ?? this.inputBackground,
      heroGlow: heroGlow ?? this.heroGlow,
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandSecondary: brandSecondary ?? this.brandSecondary,
      brandTertiary: brandTertiary ?? this.brandTertiary,
    );
  }

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

  BattleSemanticColors copyWith({
    Color? accent,
    Color? accentSoft,
    Color? panelBackground,
    Color? panelBorder,
    Color? glow,
    Color? victory,
    Color? danger,
  }) {
    return BattleSemanticColors(
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      panelBackground: panelBackground ?? this.panelBackground,
      panelBorder: panelBorder ?? this.panelBorder,
      glow: glow ?? this.glow,
      victory: victory ?? this.victory,
      danger: danger ?? this.danger,
    );
  }

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
  static const AppSemanticColors light = AppSemanticColors(
    backgroundPrimary: Color(0xFFF8F7FB),
    backgroundSecondary: Color(0xFFFFFFFF),
    surfacePrimary: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF2EEF7),
    borderSubtle: Color(0x14000000),
    borderStrong: Color(0x26000000),
    textPrimary: Color(0xFF18141F),
    textSecondary: Color(0xFF625B71),
    textInverse: Color(0xFFFFFFFF),
    success: Color(0xFF1F9D55),
    warning: Color(0xFFB7791F),
    error: Color(0xFFD64545),
    info: Color(0xFF2B6CB0),
  );

  static const AppSemanticColors dark = AppSemanticColors(
    backgroundPrimary: Color(0xFF000000),
    backgroundSecondary: Color(0xFF141218),
    surfacePrimary: Color(0xFF281E2C),
    surfaceSecondary: Color(0xFF34233B),
    borderSubtle: Color(0x1FFFFFFF),
    borderStrong: Color(0x33FFFFFF),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xB3FFFFFF),
    textInverse: Color(0xFF000000),
    success: Color(0xFF48BB78),
    warning: Color(0xFFE9B949),
    error: Color(0xFFFF6B6B),
    info: Color(0xFF63B3ED),
  );

  static const AuthSemanticColors authLight = AuthSemanticColors(
    accent: Color(0xFFFF8FAB),
    accentSoft: Color(0xFFFDE2E8),
    cardBackground: Color(0xFFFFFFFF),
    inputBackground: Color(0xFFF6F2FA),
    heroGlow: Color(0x1AFB6F92),
    brandPrimary: Color(0xFFFF8FAB),
    brandSecondary: Color(0xFFF3B4C3),
    brandTertiary: Color(0xFFFFC4D6),
  );

  static const AuthSemanticColors authDark = AuthSemanticColors(
    accent: Color(0xFFFF8FAB),
    accentSoft: Color(0xFFF3B4C3),
    cardBackground: Color(0xFF281E2C),
    inputBackground: Color(0xFF3A3150),
    heroGlow: Color(0x22FB6F92),
    brandPrimary: Color(0xFFFF8FAB),
    brandSecondary: Color(0xFFF3B4C3),
    brandTertiary: Color(0xFFFFC4D6),
  );

  static const BattleSemanticColors battleLight = BattleSemanticColors(
    accent: Color(0xFF7C5CFA),
    accentSoft: Color(0xFFE9E1FF),
    panelBackground: Color(0xFFFFFFFF),
    panelBorder: Color(0x1A000000),
    glow: Color(0x147C5CFA),
    victory: Color(0xFF22A06B),
    danger: Color(0xFFE5484D),
  );

  static const BattleSemanticColors battleDark = BattleSemanticColors(
    accent: Color(0xFF9F7AEA),
    accentSoft: Color(0xFF44337A),
    panelBackground: Color(0xFF1F1B2E),
    panelBorder: Color(0x33FFFFFF),
    glow: Color(0x229F7AEA),
    victory: Color(0xFF48BB78),
    danger: Color(0xFFFF6B6B),
  );
}
