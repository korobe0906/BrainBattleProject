import 'package:flutter/material.dart';
import 'app_colors.dart';

@immutable
class AppThemeTokens extends ThemeExtension<AppThemeTokens> {
  final AppSemanticColors colors;

  const AppThemeTokens({required this.colors});

  @override
  AppThemeTokens copyWith({AppSemanticColors? colors}) {
    return AppThemeTokens(colors: colors ?? this.colors);
  }

  @override
  AppThemeTokens lerp(ThemeExtension<AppThemeTokens>? other, double t) {
    if (other is! AppThemeTokens) return this;
    return AppThemeTokens(
      colors: AppSemanticColors.lerp(colors, other.colors, t),
    );
  }
}

@immutable
class AuthThemeTokens extends ThemeExtension<AuthThemeTokens> {
  final AuthSemanticColors colors;

  const AuthThemeTokens({required this.colors});

  @override
  AuthThemeTokens copyWith({AuthSemanticColors? colors}) {
    return AuthThemeTokens(colors: colors ?? this.colors);
  }

  @override
  AuthThemeTokens lerp(ThemeExtension<AuthThemeTokens>? other, double t) {
    if (other is! AuthThemeTokens) return this;
    return AuthThemeTokens(
      colors: AuthSemanticColors.lerp(colors, other.colors, t),
    );
  }
}

@immutable
class BattleThemeTokens extends ThemeExtension<BattleThemeTokens> {
  final BattleSemanticColors colors;

  const BattleThemeTokens({required this.colors});

  @override
  BattleThemeTokens copyWith({BattleSemanticColors? colors}) {
    return BattleThemeTokens(colors: colors ?? this.colors);
  }

  @override
  BattleThemeTokens lerp(ThemeExtension<BattleThemeTokens>? other, double t) {
    if (other is! BattleThemeTokens) return this;
    return BattleThemeTokens(
      colors: BattleSemanticColors.lerp(colors, other.colors, t),
    );
  }
}

extension ThemeContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  AppThemeTokens get appTokens => theme.extension<AppThemeTokens>()!;
  AuthThemeTokens get authTokens => theme.extension<AuthThemeTokens>()!;
  BattleThemeTokens get battleTokens => theme.extension<BattleThemeTokens>()!;
}
