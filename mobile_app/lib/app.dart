import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/splash/splash_page.dart';
import 'features/auth/starter/starter_page.dart';
import 'features/messaging/ui/conversations_page.dart';
import 'features/learning/learning.dart';
import 'features/learning/ui/galaxy_map_screen.dart';
import 'features/community/community_shell.dart';

class BrainBattleApp extends StatelessWidget {
  const BrainBattleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainBattle',
      debugShowCheckedModeBanner: false,
      theme: bbLightTheme(),
      darkTheme: bbDarkTheme(),
      themeMode: ThemeMode.dark, // tránh nháy nền trắng
      home: const SplashPage(), // build Splash ngay, không qua tra cứu route
      routes: {
        StarterPage.routeName: (_) => const StarterPage(),
        CommunityShell.routeName: (_) => const CommunityShell(), // ok
        LessonsScreen.routeName: (_) => const LessonsScreen(),
      },
      onUnknownRoute: (_) =>
          MaterialPageRoute(builder: (_) => const StarterPage()),
    );
  }
}
