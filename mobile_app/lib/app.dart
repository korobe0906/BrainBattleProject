import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/callback/auth_callback_page.dart';
import 'features/auth/forgot/forgot_password_page.dart';
import 'features/auth/forgot/reset_password_page.dart';
import 'features/auth/login/login_page.dart';
import 'features/auth/signup/sign_up_page.dart';
import 'features/auth/splash/splash_page.dart';
import 'features/auth/starter/starter_page.dart';
import 'features/auth/verify/verify_email_page.dart';
import 'features/profile/ui/complete_profile_page.dart';
import 'features/profile/ui/language_goal_setup_page.dart';
import 'features/profile/ui/learner_profile_page.dart';
import 'features/profile/ui/learning_goal_onboarding_page.dart';
import 'features/profile/ui/wallet_link_page.dart';
import 'features/shell/learner_shell_page.dart';

class BrainBattleApp extends StatefulWidget {
  const BrainBattleApp({super.key});

  static _BrainBattleAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_BrainBattleAppState>()!;

  @override
  State<BrainBattleApp> createState() => _BrainBattleAppState();
}

class _BrainBattleAppState extends State<BrainBattleApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  StreamSubscription<AuthState>? _authSub;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  void initState() {
    super.initState();

    _authSub = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final navigator = _navigatorKey.currentState;
      if (navigator == null) return;

      if (data.event == AuthChangeEvent.passwordRecovery) {
        navigator.pushNamed(ResetPasswordPage.routeName);
      }
    });
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'BrainBattle',
      debugShowCheckedModeBanner: false,
      theme: bbLightTheme(),
      darkTheme: bbDarkTheme(),
      themeMode: _themeMode,
      home: const SplashPage(),
      routes: {
        StarterPage.routeName: (_) => const StarterPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        SignUpPage.routeName: (_) => const SignUpPage(),
        ForgotPasswordPage.routeName: (_) => const ForgotPasswordPage(),
        LearnerProfilePage.routeName: (_) => const LearnerProfilePage(),
        CompleteProfilePage.routeName: (_) => const CompleteProfilePage(),
        LearningGoalOnboardingPage.routeName: (_) =>
            const LearningGoalOnboardingPage(),
        LanguageGoalSetupPage.routeName: (_) => const LanguageGoalSetupPage(),
        WalletLinkPage.routeName: (_) => const WalletLinkPage(),
        LearnerShellPage.routeName: (_) => const LearnerShellPage(),
        AuthCallbackPage.routeName: (_) => const AuthCallbackPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case VerifyEmailPage.routeName:
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (_) =>
                  VerifyEmailPage(email: (args?['email'] as String?) ?? ''),
            );

          case ResetPasswordPage.routeName:
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (_) =>
                  ResetPasswordPage(email: (args?['email'] as String?) ?? ''),
            );
        }
        return null;
      },
      onUnknownRoute: (_) =>
          MaterialPageRoute(builder: (_) => const StarterPage()),
    );
  }
}