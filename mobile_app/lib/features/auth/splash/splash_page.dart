import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../widgets/brainbattle_logo_anim.dart';
import '../../../widgets/falling_text.dart';

import '../starter/starter_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const String _title = 'BrainBattle';
  static const Duration _splashDuration = Duration(seconds: 20);

  @override
  void initState() {
    super.initState();
    // Sau 20s thì điều hướng sang StarterPage
    Future.delayed(_splashDuration, () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(StarterPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final double titleSize = (screenW * 0.085).clamp(24.0, 34.0) as double;

    return Scaffold(
      backgroundColor: BBColors.darkBg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo xoay trong 20s (không cần onSpinEnd vì đã có timer 20s)
              const BrainBattleLogoAnim(
                logoAsset: 'assets/logo.png',
                loopLottieAsset: 'assets/animations/logo_animation.json',
                infiniteSpin: true, // dùng tốc độ cố định + repeat
                roundDuration: Duration(
                  seconds: 4,
                ), // 1 vòng = 4s -> 20s ≈ 5 vòng
                spinCurve: Curves.linear, // giữ vận tốc góc đều
              ),
              const SizedBox(height: 28),
              // dưới logo:
              FallingText(
                text: _title,
                totalDuration: const Duration(
                  seconds: 20,
                ), // <-- đổi từ duration -> totalDuration
                distance: 64,
                dropCurve: Curves.easeOutBack,
                fadeHeadPortion: 0.35,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  color: BBColors.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
