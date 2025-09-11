import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Logo động:
/// - Nền Lottie loop vô hạn
/// - Logo xoay:
///   * Chế độ cũ (finite): xoay `turnsCount` vòng trong `spinTotalDuration`, gọi onSpinEnd khi xong.
///   * Chế độ mới (constant-speed): `infiniteSpin = true` -> repeat theo `roundDuration` (1 vòng),
///     tốc độ cố định; có thể hẹn `turnsForCallback` để gọi onSpinEnd sau N vòng.
class BrainBattleLogoAnim extends StatefulWidget {
  const BrainBattleLogoAnim({
    super.key,
    required this.logoAsset,           // ex: 'assets/logo.png'
    required this.loopLottieAsset,     // ex: 'assets/animations/logo_animation.json'

    // --- CHẾ ĐỘ CŨ (finite spin) - giữ để tương thích ngược ---
    this.turnsCount = 1.0,             // số vòng nếu dùng finite spin
    this.spinTotalDuration = const Duration(seconds: 3),

    // --- CHẾ ĐỘ MỚI (constant-speed) ---
    this.infiniteSpin = false,                 // bật chế độ tốc độ cố định + repeat
    this.roundDuration = const Duration(seconds: 4), // thời gian 1 vòng
    this.turnsForCallback,                     // số vòng sau đó mới gọi onSpinEnd (khi infiniteSpin=true)

    this.spinCurve = Curves.linear,
    this.widthFactor = 0.66,
    this.logoFactor = 0.33,
    this.onSpinEnd,
  });

  final String logoAsset;
  final String loopLottieAsset;

  // Finite spin (legacy)
  final double turnsCount;
  final Duration spinTotalDuration;

  // Constant-speed infinite spin (new)
  final bool infiniteSpin;
  final Duration roundDuration;
  final double? turnsForCallback;

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
  Timer? _callbackTimer;

  @override
  void initState() {
    super.initState();

    if (widget.infiniteSpin) {
      // Constant-speed: 1 vòng = roundDuration, lặp vô hạn
      _spinCtrl = AnimationController(
        vsync: this,
        duration: widget.roundDuration,
      );

      _turns = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _spinCtrl, curve: widget.spinCurve),
      );

      _spinCtrl.repeat(); // lặp vô hạn

      // Nếu muốn callback sau N vòng (ví dụ N=6): hẹn giờ
      if (widget.onSpinEnd != null && (widget.turnsForCallback ?? 0) > 0) {
        final micros = (widget.roundDuration.inMicroseconds *
                (widget.turnsForCallback ?? 0))
            .round();
        _callbackTimer = Timer(Duration(microseconds: micros), () {
          if (mounted) widget.onSpinEnd?.call();
        });
      }
    } else {
      // Finite spin: xoay turnsCount vòng trong spinTotalDuration
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
    }

    _lottieCtrl = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _callbackTimer?.cancel();
    _spinCtrl.dispose();
    _lottieCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final double boxSize =
        (screenW * widget.widthFactor).clamp(180.0, 320.0) as double;
    final double logoSize =
        (screenW * widget.logoFactor).clamp(100.0, 180.0) as double;

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
            turns: _turns, // 0..1 lặp theo roundDuration khi infiniteSpin = true
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
