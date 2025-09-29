import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/splash/splash_page.dart';
import 'features/auth/starter/starter_page.dart';
import 'features/messaging/ui/conversations_page.dart';
import 'features/learning/learning.dart';
import 'features/learning/ui/galaxy_map_screen.dart';


class BrainBattleApp extends StatelessWidget {
  const BrainBattleApp({super.key});

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      title: 'BrainBattle',
      debugShowCheckedModeBanner: false,
      theme: bbLightTheme(),
      darkTheme: bbDarkTheme(),
      initialRoute: SplashPage.routeName,         

      routes: {
        SplashPage.routeName: (_) => const SplashPage(),
        StarterPage.routeName: (_) => const StarterPage(),
        ConversationsPage.routeName: (_) => const ConversationsPage(),
        LessonsScreen.routeName: (_) => const LessonsScreen(),
       
      },

      // (tuỳ chọn) fallback nếu gõ nhầm route
      onUnknownRoute: (_) =>
          MaterialPageRoute(builder: (_) => const StarterPage()),
    );

  }
}
