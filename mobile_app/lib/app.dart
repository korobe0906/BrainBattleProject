import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/splash/splash_page.dart';
import 'features/auth/starter/starter_page.dart';

class BrainBattleApp extends StatelessWidget {
  const BrainBattleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainBattle',
      debugShowCheckedModeBanner: false,
      theme: bbDarkTheme(),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (_) => const SplashPage(),
        StarterPage.routeName: (_) => const StarterPage(),
      },
    );
  }
}
