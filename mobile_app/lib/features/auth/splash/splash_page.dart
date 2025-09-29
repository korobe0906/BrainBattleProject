// lib/features/auth/splash/splash_page.dart
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

  Duration? _animDuration; // duration lấy từ lottie (sync)
  bool _navigated = false;

  void _goNext() {
    if (!mounted || _navigated) return;
    _navigated = true;
    Navigator.of(context).pushReplacementNamed(StarterPage.routeName);
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
              BrainBattleLogoAnim(
                logoAsset: 'assets/logo.png',
                loopLottieAsset: 'assets/animations/animated_logo_light_pink.json',

                // ✅ Đồng bộ spin với Lottie:
                syncToLottie: true,
                minTotalDuration: const Duration(seconds: 5),
                spinCurve: Curves.linear,

                // Khi biết duration của Lottie -> set cho FallingText
                onTimelineReady: (dur) {
                  if (!mounted) return;
                  setState(() {
                    _animDuration = dur;
                  });
                },

                // Khi Lottie (và spin) kết thúc -> chữ cũng xong -> điều hướng
                onAllDone: _goNext,
              ),

              const SizedBox(height: 28),

              // ✅ Chỉ render khi đã biết duration của Lottie
              if (_animDuration != null)
                FallingText(
                  text: _title,
                  totalDuration: _animDuration!,
                  distance: 64,                    // rơi “rõ” hơn
                  dropCurve: Curves.easeOutQuint,  // nhanh & mượt
                  fadeHeadPortion: 0.20,           // xuất hiện sớm hơn
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
