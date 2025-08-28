import 'dart:async';
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../widgets/brainbattle_logo_anim.dart';
import '../starter/starter_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceCtrl;

  @override
  void initState() {
    super.initState();

    // Chữ "BrainBattle" nhảy nhè nhẹ cho sinh động
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    // Sau 5s chuyển sang Starter (giữ đúng yêu cầu flow)
    Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(StarterPage.routeName);
    });
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    // Font responsive + clamp cho ổn định trên mọi máy
    final titleSize = (screenW * 0.085).clamp(24.0, 34.0);

    return Scaffold(
      backgroundColor: BBColors.darkBg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BrainBattleLogoAnim(
                logoAsset: 'assets/logo.png',
                loopLottieAsset: 'assets/animations/logo_animation.json',
                turnsCount: 1.0,                        // xoay đúng 1 vòng
                spinTotalDuration: Duration(seconds: 4),// xoay chậm rồi dừng
                spinCurve: Curves.linear,
                widthFactor: 0.66,  // khung animation ≈ 2/3 màn hình ngang
                logoFactor: 0.33,   // logo ≈ 1/3 màn hình ngang
              ),

              const SizedBox(height: 28),               // khoảng cách logo ↔ chữ

              AnimatedBuilder(
                animation: _bounceCtrl,
                builder: (_, child) {
                  final t = _bounceCtrl.value;
                  final dy = -8 * Curves.easeOutBack.transform(t);
                  final scale = 1.0 + 0.02 * Curves.easeOut.transform(t);
                  return Transform.translate(
                    offset: Offset(0, dy),
                    child: Transform.scale(scale: scale, child: child),
                  );
                },
                child: Text(
                  'BrainBattle',
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    color: BBColors.textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
