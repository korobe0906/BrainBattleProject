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
  final String _title = 'BrainBattle';

  late final AnimationController _lettersCtrl;
  late final List<Animation<double>> _dropYs;    // mỗi ký tự: rơi từ -Y -> 0
  late final List<Animation<double>> _opacities; // mỗi ký tự: 0 -> 1

  // Tùy chỉnh hiệu ứng
  static const double _fallDistance = 18;          // rơi xuống bao nhiêu px
  static const Duration _perCharDelay = Duration(milliseconds: 80);
  static const Duration _perCharFall = Duration(milliseconds: 450);

  @override
  void initState() {
    super.initState();

    // Tổng thời gian = delay * (n-1) + fall
    final total = _perCharDelay * (_title.length - 1) + _perCharFall;
    _lettersCtrl = AnimationController(vsync: this, duration: total)
      ..addStatusListener((st) {
        if (st == AnimationStatus.completed && mounted) {
          Navigator.of(context).pushReplacementNamed(StarterPage.routeName);
        }
      })
      ..forward();

    // Tạo animation cho từng ký tự (stagger)
    _dropYs = [];
    _opacities = [];
    for (int i = 0; i < _title.length; i++) {
      final start = i * _perCharDelay.inMilliseconds / total.inMilliseconds;
      final end = (i * _perCharDelay.inMilliseconds + _perCharFall.inMilliseconds) /
          total.inMilliseconds;

      final curved = CurvedAnimation(
        parent: _lettersCtrl,
        curve: Interval(start, end.clamp(0.0, 1.0),
            curve: Curves.easeOutBack), // bật nhẹ khi chạm đáy
      );

      final fadeCurve = CurvedAnimation(
        parent: _lettersCtrl,
        curve: Interval(start, end.clamp(0.0, 1.0), curve: Curves.easeOut),
      );

      _dropYs.add(Tween<double>(begin: -_fallDistance, end: 0).animate(curved));
      _opacities.add(Tween<double>(begin: 0, end: 1).animate(fadeCurve));
    }
  }

  @override
  void dispose() {
    _lettersCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final titleSize = (screenW * 0.085).clamp(24.0, 34.0);

    return Scaffold(
      backgroundColor: BBColors.darkBg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo động: Lottie nền loop + logo xoay đúng 1 vòng rồi dừng
              const BrainBattleLogoAnim(
                logoAsset: 'assets/logo.png',
                loopLottieAsset: 'assets/animations/logo_animation.json',
                turnsCount: 1.0,
                spinTotalDuration: Duration(seconds: 4),
                spinCurve: Curves.linear,
                widthFactor: 0.66,
                logoFactor: 0.33,
              ),
              const SizedBox(height: 28),

              // Tiêu đề: từng ký tự rơi xuống (staggered)
              _AnimatedTitle(
                title: _title,
                drops: _dropYs,
                fades: _opacities,
                fontSize: titleSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget vẽ từng ký tự với transform riêng
class _AnimatedTitle extends StatelessWidget {
  const _AnimatedTitle({
    required this.title,
    required this.drops,
    required this.fades,
    required this.fontSize,
  });

  final String title;
  final List<Animation<double>> drops;
  final List<Animation<double>> fades;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final chars = title.characters.toList(); // hỗ trợ cả emoji/Unicode
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(chars.length, (i) {
        return AnimatedBuilder(
          animation: drops[i],
          builder: (_, __) {
            return Opacity(
              opacity: fades[i].value,
              child: Transform.translate(
                offset: Offset(0, drops[i].value),
                child: Text(
                  chars[i],
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w800,
                    color: BBColors.textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
