import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Logo động: nền Lottie loop vô hạn + logo xoay N vòng rồi dừng.
/// - Tự scale theo kích thước màn hình (responsive)
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
  });

  final String logoAsset;
  final String loopLottieAsset;

  /// Số vòng xoay của logo. Có thể là số thực (vd 1.5 vòng).
  final double turnsCount;

  /// Tổng thời gian xoay turnsCount vòng.
  final Duration spinTotalDuration;

  /// Curve cho xoay (linear = đều).
  final Curve spinCurve;

  /// Khung Lottie chiếm bao nhiêu bề ngang màn hình (0→1).
  final double widthFactor;

  /// Logo chiếm bao nhiêu bề ngang màn hình (0→1).
  final double logoFactor;

  @override
  State<BrainBattleLogoAnim> createState() => _BrainBattleLogoAnimState();
}

class _BrainBattleLogoAnimState extends State<BrainBattleLogoAnim>
    with TickerProviderStateMixin {
  late final AnimationController _spinCtrl;
  late final Animation<double> _turns;        // 0 → turnsCount
  late final AnimationController _lottieCtrl; // loop lottie

  @override
  void initState() {
    super.initState();

    // Xoay logo: chạy 1 lần rồi dừng
    _spinCtrl = AnimationController(
      vsync: this,
      duration: widget.spinTotalDuration,
    );
    _turns = Tween<double>(begin: 0, end: widget.turnsCount).animate(
      CurvedAnimation(parent: _spinCtrl, curve: widget.spinCurve),
    );
    _spinCtrl.forward();

    // Lottie: lặp vô hạn (set duration theo composition để mượt)
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

    // Tính kích thước responsive, kèm clamp để tránh quá to/nhỏ.
    final boxSize = (screenW * widget.widthFactor).clamp(180.0, 320.0);
    final logoSize = (screenW * widget.logoFactor).clamp(100.0, 180.0);

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
