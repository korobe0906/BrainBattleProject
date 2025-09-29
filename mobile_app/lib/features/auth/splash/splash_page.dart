// lib/features/auth/splash/splash_page.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../starter/starter_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _navigated = false;
  bool _lottieReady = false;

  static const _black      = Color(0xFF000000);
  static const _pinkBrain  = Color(0xFFFF8FAB);
  static const _pinkBattle = Color(0xFFF3B4C3);

  void _goNext() {
    if (!mounted || _navigated) return;
    _navigated = true;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const StarterPage(),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondary, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // Khi Lottie load xong, chỉ chuẩn bị thôi (chưa chạy)
    // Sau 3 giây mới forward
    Future.delayed(const Duration(seconds: 3), () {
      if (_lottieReady && mounted) {
        _controller.forward(from: 0);
      }
    });

    // Khi Lottie chạy xong 1 vòng → chuyển trang
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goNext();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final titleSize = (w * 0.10).clamp(26.0, 40.0).toDouble();
    final subSize   = (titleSize * 0.38).clamp(10.0, 16.0).toDouble();
  final lottieHeight = (w * 0.55).clamp(200.0, 280.0);

    return Scaffold(
      backgroundColor: _black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: lottieHeight,
                child: Lottie.asset(
                  'assets/animations/logo_animation_light.json',
                  controller: _controller,
                  frameRate: FrameRate.max,
                  repeat: false,
                  animate: false, // chỉ chạy khi mình gọi forward
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..value = 0.0;
                    _lottieReady = true;
                  },
                ),
              ),
              const SizedBox(height: 28),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'BRAIN ',
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4.0,
                        color: _pinkBrain,
                      ),
                    ),
                    TextSpan(
                      text: 'BATTLE',
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4.0,
                        color: _pinkBattle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'LANGUAGE LEARNING',
                style: TextStyle(
                  fontSize: subSize,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
