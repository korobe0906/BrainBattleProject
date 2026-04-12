import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';
import 'theme_extensions.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final global = AppColorSchemes.light;
    final auth = AppColorSchemes.authLight;
    final battle = AppColorSchemes.battleLight;

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: auth.accent,
          brightness: Brightness.light,
        ).copyWith(
          primary: auth.accent,
          secondary: battle.accent,
          surface: global.surfacePrimary,
          error: global.error,
          onPrimary: global.textInverse,
          onSecondary: global.textInverse,
          onSurface: global.textPrimary,
          onError: global.textInverse,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: global.backgroundPrimary,
      canvasColor: global.backgroundPrimary,
      textTheme: AppTextStyles.textTheme(
        textPrimary: global.textPrimary,
        textSecondary: global.textSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: global.backgroundPrimary,
        foregroundColor: global.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: global.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: global.surfacePrimary,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          side: BorderSide(color: global.borderSubtle),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: global.borderSubtle,
        thickness: 1,
        space: 1,
      ),
      iconTheme: IconThemeData(color: global.textPrimary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: auth.inputBackground,
        hintStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          color: global.textSecondary,
        ),
        labelStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          color: global.textSecondary,
        ),
        helperStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          color: global.textSecondary,
        ),
        errorStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          color: global.error,
        ),
        contentPadding: AppSpacing.inputContentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: global.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: global.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: auth.accent, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: global.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: global.error, width: 1.4),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: global.borderSubtle),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: auth.accent,
          foregroundColor: global.textInverse,
          disabledBackgroundColor: global.surfaceSecondary,
          disabledForegroundColor: global.textSecondary,
          textStyle: const TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: auth.accent,
          disabledForegroundColor: global.textSecondary,
          side: BorderSide(color: auth.accent),
          textStyle: const TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: auth.accent,
          textStyle: const TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: global.surfaceSecondary,
        contentTextStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          color: global.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: auth.accent,
        linearTrackColor: global.surfaceSecondary,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppThemeTokens(colors: global),
        AuthThemeTokens(colors: auth),
        BattleThemeTokens(colors: battle),
      ],
    );
  }

  static ThemeData dark() {
    final global = AppColorSchemes.dark;
    final auth = AppColorSchemes.authDark;
    final battle = AppColorSchemes.battleDark;

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: auth.accent,
          brightness: Brightness.dark,
        ).copyWith(
          primary: auth.accent,
          secondary: battle.accent,
          surface: global.surfacePrimary,
          error: global.error,
          onPrimary: global.textInverse,
          onSecondary: global.textPrimary,
          onSurface: global.textPrimary,
          onError: global.textInverse,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: global.backgroundPrimary,
      canvasColor: global.backgroundPrimary,
      textTheme: AppTextStyles.textTheme(
        textPrimary: global.textPrimary,
        textSecondary: global.textSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: global.backgroundPrimary,
        foregroundColor: global.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: global.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: global.surfacePrimary,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          side: BorderSide(color: global.borderSubtle),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: global.borderSubtle,
        thickness: 1,
        space: 1,
      ),
      iconTheme: IconThemeData(color: global.textPrimary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: auth.inputBackground,
        hintStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          color: global.textSecondary,
        ),
        labelStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          color: global.textSecondary,
        ),
        helperStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          color: global.textSecondary,
        ),
        errorStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          color: global.error,
        ),
        contentPadding: AppSpacing.inputContentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: global.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: global.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: auth.accent, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: global.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: global.error, width: 1.4),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: global.borderSubtle),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: auth.accent,
          foregroundColor: Colors.black,
          disabledBackgroundColor: global.surfaceSecondary,
          disabledForegroundColor: global.textSecondary,
          textStyle: const TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: auth.accent,
          disabledForegroundColor: global.textSecondary,
          side: BorderSide(color: auth.accent),
          textStyle: const TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: auth.accent,
          textStyle: const TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: global.surfaceSecondary,
        contentTextStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          color: global.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: auth.accent,
        linearTrackColor: global.surfaceSecondary,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppThemeTokens(colors: global),
        AuthThemeTokens(colors: auth),
        BattleThemeTokens(colors: battle),
      ],
    );
  }
}

/// Backward-compatible top-level helpers
ThemeData bbLightTheme() => AppTheme.light();
ThemeData bbDarkTheme() => AppTheme.dark();
