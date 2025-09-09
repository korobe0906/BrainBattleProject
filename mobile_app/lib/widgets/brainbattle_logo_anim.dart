import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Logo động: nền Lottie loop vô hạn + logo xoay N vòng rồi dừng.
/// - Có callback `onSpinEnd` để báo hoàn tất xoay.
class BrainBattleLogoAnim extends StatefulWidget {
  const BrainBattleLogoAnim({
    super.key,
    required this.logoAsset,           // ex: 'assets/logo.png'
    required this.loopLottieAsset,     // ex: 'assets/animations/logo_animation.json'
    this.turnsCount = 1.0,             // số vòng xoay của logo (1 = 360°)
    this.spinTotalDuration = const Duration(seconds: 3),
    this.spinCurve = Curves.linear,
    this.widthFactor = 0.66,           // tỉ lệ bề rộng khung so với chiều ngang màn hình
    this.logoFactor = 0.33,            // tỉ lệ bề rộng logo so với chiều ngang màn hình
    this.onSpinEnd,
  });

  final String logoAsset;
  final String loopLottieAsset;

  final double turnsCount;
  final Duration spinTotalDuration;
  final Curve spinCurve;

  final double widthFactor;
  final double logoFactor;

  final VoidCallback? onSpinEnd;

  @override
  State<BrainBattleLogoAnim> createState() => _BrainBattleLogoAnimState();
}

class _BrainBattleLogoAnimState extends State<BrainBattleLogoAnim>
    with TickerProviderStateMixin {
  late final AnimationController _spinCtrl;
  late final Animation<double> _turns;
  late final AnimationController _lottieCtrl;

  @override
  void initState() {
    super.initState();

    _spinCtrl = AnimationController(
      vsync: this,
      duration: widget.spinTotalDuration,
    )..addStatusListener((st) {
        if (st == AnimationStatus.completed) {
          widget.onSpinEnd?.call();
        }
      });

    _turns = Tween<double>(begin: 0, end: widget.turnsCount).animate(
      CurvedAnimation(parent: _spinCtrl, curve: widget.spinCurve),
    );

    _spinCtrl.forward();

    _lottieCtrl = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _spinCtrl.dispose();
    _lottieCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final double boxSize = (screenW * widget.widthFactor).clamp(180.0, 320.0) as double;
    final double logoSize = (screenW * widget.logoFactor).clamp(100.0, 180.0) as double;

    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset(
            widget.loopLottieAsset,
            controller: _lottieCtrl,
            fit: BoxFit.contain,
            onLoaded: (comp) {
              _lottieCtrl
                ..duration = comp.duration
                ..repeat();
            },
          ),
          RotationTransition(
            turns: _turns,
            child: Image.asset(
              widget.logoAsset,
              width: logoSize,
              height: logoSize,
            ),
          ),
        ],
      ),
    );
  }
}
