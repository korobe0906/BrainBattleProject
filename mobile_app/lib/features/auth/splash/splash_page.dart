import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../app.dart';
import '../../../core/services/auth_session_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/brand/brand_logo.dart';
import '../data/api/auth_context_api.dart';
import '../starter/starter_page.dart';
import '../../profile/ui/learner_profile_page.dart';

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
  bool _animationStarted = false;

  Future<void> _goNext() async {
    if (!mounted || _navigated) return;
    _navigated = true;

    final authSession = AuthSessionService.instance;

    if (!authSession.hasValidLookingSession) {
      if (!mounted) return;
      _goToStarter();
      return;
    }

    try {
      await AuthContextApi.instance.getMe();

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        LearnerProfilePage.routeName,
      );
    } catch (_) {
      await authSession.signOut();

      if (!mounted) return;
      _goToStarter();
    }
  }

  void _goToStarter() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const StarterPage(),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  void _startAnimationIfReady() {
    if (!mounted || _animationStarted) return;
    if (!_lottieReady) return;

    _animationStarted = true;
    _controller.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted || _navigated) return;

      if (_lottieReady) {
        _startAnimationIfReady();
      } else {
        _goNext();
      }
    });

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
    final app = context.appTokens.colors;
    final w = MediaQuery.of(context).size.width;
    final lottieHeight = (w * 1.00).clamp(200.0, 280.0);

    return Scaffold(
      backgroundColor: app.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: () => BrainBattleApp.of(context).toggleTheme(),
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: app.textPrimary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: AppSpacing.pagePadding,
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
                    animate: false,
                    onLoaded: (composition) {
                      _controller
                        ..duration = composition.duration
                        ..value = 0.0;

                      _lottieReady = true;
                      _startAnimationIfReady();
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const BrandLogo(scale: 1.18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}