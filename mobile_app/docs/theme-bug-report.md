# Theme Bug Report

## Summary
- Total issues: 14 grouped theme bugs across about 30 affected files.
- Most critical problems:
  - The app has a theme system, but most screens bypass it with hardcoded colors and local palettes.
  - Dark/light mode support is incomplete because many screens force dark surfaces and white text regardless of theme.
  - Theme tokens and `ThemeExtension` classes exist, but they are not actually consumed by the feature widgets.

## Detailed Issues

### [Category: Hardcoded Colors]

- File: `lib/features/auth/login/login_page.dart` (approx. lines 95-407)
- Problem: The login screen hardcodes the entire visual palette instead of using theme tokens.
- Code:
```dart
backgroundColor: BBColors.darkBg,
...
backgroundColor: const Color(0xFFF3B4C3),
foregroundColor: Colors.black,
...
fillColor: const Color(0xFF3A3150),
...
color: Colors.white,
```
- Why it is a problem: The page duplicates color values already present in the theme layer and cannot adapt cleanly to future design changes.
- Severity: High
- Fix suggestion: Replace local color literals with `context.authTokens.colors` and shared `ThemeData` styles for inputs, buttons, and text.

- File: `lib/features/auth/signup/sign_up_page.dart` (approx. lines 77-276)
- Problem: Signup duplicates the same dark palette and brand pink accents as login, but with its own local constants.
- Code:
```dart
static const _pinkBrain = Color(0xFFFF8FAB);
static const _pinkBattle = Color(0xFFF3B4C3);
...
backgroundColor: BBColors.darkBg,
...
fillColor: const Color(0xFF3A3150),
```
- Why it is a problem: Signup and login should share the same theme source of truth, but they currently drift in local styling.
- Severity: High
- Fix suggestion: Pull the page colors from theme extensions and extract a shared auth form component.

- File: `lib/features/auth/forgot/forgot_start_page.dart`, `lib/features/auth/forgot/forgot_otp_page.dart`, `lib/features/auth/forgot/forgot_new_password_page.dart` (approx. lines 63-225)
- Problem: The forgot-password flow repeats the same hardcoded dark surfaces, white text, and pink CTA colors across three separate screens.
- Code:
```dart
backgroundColor: BBColors.darkBg,
...
fillColor: const Color(0xFF3A3150),
...
backgroundColor: const Color(0xFFF3B4C3),
foregroundColor: Colors.black,
```
- Why it is a problem: This is duplicated styling that makes the reset flow brittle and inconsistent with the design system.
- Severity: High
- Fix suggestion: Create a shared auth sheet/form theme and reuse it across reset screens.

- File: `lib/features/auth/splash/splash_page.dart` and `lib/features/auth/starter/starter_page.dart` (approx. lines 22-187 and 18-462)
- Problem: The onboarding entry flow uses private palette classes and hardcoded brand colors instead of app theme tokens.
- Code:
```dart
static const _black = Color(0xFF000000);
static const _pinkBrain = Color(0xFFFF8FAB);
static const _pinkBattle = Color(0xFFF3B4C3);
...
static const plumA = Color(0xFF281E2C);
static const plumB = Color(0xFF34233B);
static const pinkBorder = Color(0x33FF8FAB);
```
- Why it is a problem: Splash and starter define a parallel mini-theme that is disconnected from `AppTheme` and hard to maintain.
- Severity: High
- Fix suggestion: Move brand surfaces and accents into the theme extension layer and reuse them from the widgets.

- File: `lib/features/shortvideo/widgets/bottom_bar.dart`, `lib/features/shortvideo/widgets/comment_sheet.dart`, `lib/features/shortvideo/widgets/caption_widget.dart` (approx. lines 1-220, 1-380, 1-131)
- Problem: Multiple shortvideo widgets use raw black/white/red color literals for backgrounds, text, badges, and action states.
- Code:
```dart
color: Colors.black.withOpacity(0.35),
...
backgroundColor: Colors.white,
...
color: Colors.redAccent,
...
backgroundColor: const Color(0xFF111111),
...
style: const TextStyle(color: Colors.white70),
```
- Why it is a problem: The shortvideo UI is visually locked to one style and does not derive its colors from the theme system.
- Severity: High
- Fix suggestion: Replace direct literals with semantic surface/text/action tokens from theme extensions.

- File: `lib/features/battle/ui/battle_1v1_lobby_page.dart` and related battle lobby widgets (approx. lines 99-254)
- Problem: Battle lobby UI relies on white-on-dark styling, hardcoded success green, and direct opacity-based color tuning.
- Code:
```dart
backgroundColor: BBColors.darkBg,
...
color: Colors.white70,
...
color: _canGoMatchFound
    ? const Color(0xFF3BFFB0)
    : Colors.white54,
```
- Why it is a problem: These values are not backed by battle theme tokens and are difficult to align with the rest of the app.
- Severity: Medium
- Fix suggestion: Use battle theme tokens from `BattleThemeTokens` and derive states from the semantic palette.

### [Category: Theme Misuse]

- File: `lib/core/theme/theme_extensions.dart`, `lib/core/theme/app_theme.dart`, `lib/core/theme/palette.dart`
- Problem: The theme extension system exists, but it is effectively unused by the UI layer.
- Code:
```dart
extension ThemeContextX on BuildContext {
  AppThemeTokens get appTokens => theme.extension<AppThemeTokens>()!;
  AuthThemeTokens get authTokens => theme.extension<AuthThemeTokens>()!;
  BattleThemeTokens get battleTokens => theme.extension<BattleThemeTokens>()!;
}
```
- Why it is a problem: The codebase maintains a modern theme architecture but most screens still import raw colors or legacy palette classes, so the design system is not enforced.
- Severity: High
- Fix suggestion: Make theme extensions the default access path for all feature UI and phase out direct palette imports in widgets.

- File: `lib/features/auth/*`, `lib/features/shortvideo/*`, `lib/features/community/*`, `lib/features/battle/*`
- Problem: Pages and widgets create their own `TextStyle`, `InputDecoration`, `OutlinedButton.styleFrom`, and `ElevatedButton.styleFrom` values instead of using app-level theme defaults.
- Code:
```dart
style: ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFFF3B4C3),
  foregroundColor: Colors.black,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
),
```
- Why it is a problem: Theme-level typography, spacing, and component styling are bypassed, so component appearance drifts per screen.
- Severity: High
- Fix suggestion: Push button, input, and card styling into `ThemeData` and reuse shared components.

- File: `lib/core/widgets/bb_card.dart`, `lib/core/widgets/bb_button.dart`, `lib/core/widgets/battle_invite_card.dart`
- Problem: Shared widgets still mix theme palette imports and literal colors, which defeats the purpose of a shared design system.
- Code:
```dart
import '../../core/theme/palette.dart';
...
gradient: const LinearGradient(colors: [BBPalette.pink, BBPalette.purple]),
...
color: Color(0x1AFFFFFF),
```
- Why it is a problem: The shared component layer should be the primary consumer of theme tokens, not a second source of color definitions.
- Severity: Medium
- Fix suggestion: Convert shared widgets to consume `ThemeContextX` tokens and avoid raw color literals except in the theme layer.

- File: `lib/features/shortvideo/widgets/share_sheet.dart`
- Problem: Share sheet checks `Theme.of(context).brightness`, but then still hardcodes container, divider, and icon colors.
- Code:
```dart
color: isDark ? const Color(0xFF1C1C1C) : Colors.white,
...
color: Colors.grey.withOpacity(0.5),
...
leading: const Icon(Icons.link, color: Colors.blue),
```
- Why it is a problem: This is partial theme awareness only; it does not actually bind the sheet to the app’s semantic palette.
- Severity: Medium
- Fix suggestion: Use semantic theme colors for surfaces, borders, and action icons instead of hardcoded Material colors.

### [Category: Dark Mode Issues]

- File: `lib/app.dart`, `lib/features/auth/splash/splash_page.dart`, `lib/features/auth/starter/starter_page.dart`, `lib/features/auth/login/login_page.dart`, `lib/features/auth/signup/sign_up_page.dart`, `lib/features/auth/forgot/*`
- Problem: The app uses `ThemeMode.system`, but large parts of the auth experience still force dark backgrounds and white text, so light-mode users get a dark UI inside a system-light app.
- Code:
```dart
return MaterialApp(
  theme: bbLightTheme(),
  darkTheme: bbDarkTheme(),
  themeMode: ThemeMode.system,
)
```
```dart
backgroundColor: BBColors.darkBg,
...
color: Colors.white,
```
- Why it is a problem: The global theme can switch, but the auth flow does not follow it, which creates a broken visual contract.
- Severity: High
- Fix suggestion: Replace hardcoded dark surfaces with semantic background/surface tokens and let the app theme decide the actual colors.

- File: `lib/features/shortvideo/widgets/comment_sheet.dart`, `lib/features/shortvideo/widgets/bottom_bar.dart`, `lib/features/shortvideo/widgets/shortvideo_player.dart`
- Problem: These widgets assume a fully dark video-player environment and use fixed white/black contrast values without consulting the app theme.
- Code:
```dart
backgroundColor: const Color(0xFF111111),
...
style: const TextStyle(color: Colors.white70),
...
backgroundColor: Colors.white,
foregroundColor: Colors.black,
```
- Why it is a problem: In a lighter theme, the same widgets will look detached from the rest of the app and may violate contrast expectations.
- Severity: High
- Fix suggestion: Treat video-player chrome as theme-driven overlay surfaces instead of hardcoded black panels.

- File: `lib/features/community/widgets/avatar_name.dart`, `lib/features/community/widgets/active_now_strip.dart`, `lib/features/community/ui/thread/thread_page.dart`
- Problem: Community UI mixes hardcoded dark surfaces and white text with a few color-specific accents, so it will not adapt cleanly to theme changes.
- Code:
```dart
backgroundColor: const Color(0xFF443A5B),
...
color: Colors.white70,
...
color: Colors.greenAccent.shade400,
```
- Why it is a problem: Contrast and surface colors are not centrally managed, which makes dark mode behavior inconsistent across community screens.
- Severity: Medium
- Fix suggestion: Replace ad-hoc colors with theme tokens for surface, text, and status indicators.

### [Category: Inconsistent Styling]

- File: `lib/features/auth/login/login_page.dart`, `lib/features/auth/signup/sign_up_page.dart`, `lib/features/auth/forgot/*`, `lib/features/auth/starter/starter_page.dart`
- Problem: Auth screens repeat the same layout patterns, gradients, radii, and colors, but each page defines them slightly differently.
- Code:
```dart
borderRadius: BorderRadius.circular(16),
...
borderRadius: BorderRadius.circular(24),
...
fontFamily: 'PlusJakartaSans',
```
- Why it is a problem: The auth experience looks related, but its styles are fragmented and easy to drift over time.
- Severity: Medium
- Fix suggestion: Extract shared auth surfaces, form fields, buttons, and heading styles into reusable components.

- File: `lib/features/shortvideo/widgets/top_tabs.dart`, `lib/features/shortvideo/widgets/right_rail.dart`, `lib/features/shortvideo/widgets/action_buttons.dart`, `lib/features/shortvideo/widgets/comment_tile.dart`, `lib/features/shortvideo/widgets/demo_banner.dart`
- Problem: Shortvideo widgets use different opacity levels and literal colors for the same types of text and action affordances.
- Code:
```dart
color: Colors.white.withOpacity(sel ? 1 : .7),
...
color: Colors.pinkAccent,
...
color: Colors.orange.withOpacity(0.9),
```
- Why it is a problem: The UI language is inconsistent even within a single feature cluster.
- Severity: Medium
- Fix suggestion: Define a shortvideo semantic token set for primary text, secondary text, accent, warning, and overlay background.

### [Category: Bad Architecture]

- File: `lib/core/theme/app_theme.dart`, `lib/core/theme/app_colors.dart`, `lib/core/theme/palette.dart`, `lib/core/theme/theme_extensions.dart`
- Problem: The theme architecture is split across several layers, but widget code still depends on the legacy compatibility palette rather than the actual theme extension layer.
- Code:
```dart
extensions: <ThemeExtension<dynamic>>[
  AppThemeTokens(colors: global),
  AuthThemeTokens(colors: auth),
  BattleThemeTokens(colors: battle),
],
```
```dart
/// Legacy compatibility palette.
/// New code should use Theme.of(context).extension<...>() or ThemeContextX.
```
- Why it is a problem: There are now multiple sources of truth for color ownership, which makes the design system harder to evolve safely.
- Severity: High
- Fix suggestion: Promote `ThemeContextX` and theme extensions as the only source of truth for UI colors; keep `palette.dart` only as a migration bridge.

- File: `lib/features/auth/splash/splash_page.dart`, `lib/features/auth/starter/starter_page.dart`, `lib/features/shortvideo/widgets/share_sheet.dart`, `lib/features/battle/ui/battle_1v1_lobby_page.dart`
- Problem: Feature widgets create local color palettes and theme logic instead of consuming centralized tokens.
- Code:
```dart
class _PopupPalette {
  static const plumA = Color(0xFF281E2C);
  static const plumB = Color(0xFF34233B);
}
```
- Why it is a problem: Feature-level color ownership becomes hidden inside widget files, which prevents the theme layer from acting as the design system boundary.
- Severity: Medium
- Fix suggestion: Move every reusable color decision into the theme layer and keep widget files focused on layout and interaction.

## Affected Files List

- `lib/app.dart`
- `lib/core/theme/app_theme.dart`
- `lib/core/theme/app_colors.dart`
- `lib/core/theme/palette.dart`
- `lib/core/theme/theme_extensions.dart`
- `lib/core/widgets/bb_button.dart`
- `lib/core/widgets/bb_card.dart`
- `lib/core/widgets/battle_invite_card.dart`
- `lib/core/user/user_switcher_widget.dart`
- `lib/features/auth/splash/splash_page.dart`
- `lib/features/auth/starter/starter_page.dart`
- `lib/features/auth/login/login_page.dart`
- `lib/features/auth/signup/sign_up_page.dart`
- `lib/features/auth/verify/verify_otp_page.dart`
- `lib/features/auth/complete/complete_profile_page.dart`
- `lib/features/auth/forgot/forgot_start_page.dart`
- `lib/features/auth/forgot/forgot_otp_page.dart`
- `lib/features/auth/forgot/forgot_new_password_page.dart`
- `lib/features/battle/ui/battle_1v1_lobby_page.dart`
- `lib/features/community/widgets/avatar_name.dart`
- `lib/features/community/widgets/active_now_strip.dart`
- `lib/features/community/widgets/battle_invite_card.dart`
- `lib/features/shortvideo/widgets/bottom_bar.dart`
- `lib/features/shortvideo/widgets/caption_widget.dart`
- `lib/features/shortvideo/widgets/comment_sheet.dart`
- `lib/features/shortvideo/widgets/comment_tile.dart`
- `lib/features/shortvideo/widgets/share_sheet.dart`
- `lib/features/shortvideo/widgets/top_tabs.dart`
- `lib/features/shortvideo/widgets/right_rail.dart`
- `lib/features/shortvideo/widgets/action_buttons.dart`
- `lib/features/shortvideo/widgets/demo_banner.dart`
- `lib/features/shortvideo/widgets/shortvideo_player.dart`
- `lib/features/shortvideo/ui/shortvideo_shell.dart`
- `lib/features/shortvideo/ui/shortvideo_feed_page.dart`
- `lib/features/shortvideo/ui/post_page.dart`
- `lib/features/shortvideo/ui/profile_page.dart`
- `lib/features/shortvideo/ui/search_results_page.dart`
- `lib/features/shortvideo/ui/sound_page.dart`
- `lib/features/shortvideo/ui/video_editor_page.dart`
- `lib/features/shortvideo/ui/upload_picker_page.dart`
- `lib/features/shortvideo/ui/shorts_search_page.dart`
- `lib/features/shortvideo/ui/inbox_page.dart`
- `lib/features/shortvideo/ui/hashtag_page.dart`

## Recommendations

- Make `Theme.of(context).extension<...>()` the standard way to access app colors. Keep all semantic color ownership in `app_theme.dart` and `app_colors.dart`.
- Remove hardcoded `Color(0x...)`, `Colors.white`, `Colors.black`, and `Colors.red...` values from feature widgets unless they are truly one-off illustration assets.
- Extract shared auth, sheet, and card components so login/signup/forgot/community/shortvideo screens all reuse the same themed building blocks.
- Convert page-level button and text-field styling into `ThemeData` overrides and shared components instead of repeating `styleFrom`, `InputDecoration`, and `TextStyle` in every screen.
- Add a lint or code review rule that blocks new theme literals in UI files outside the theme layer.
- Keep `palette.dart` only as a migration shim and gradually delete direct imports from feature widgets once `ThemeContextX` adoption is complete.
- Audit every screen in light mode, dark mode, and on small screens to confirm contrast, spacing, and overlay readability after the theme cleanup.
