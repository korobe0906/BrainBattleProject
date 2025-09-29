import 'dart:math';
import 'package:flutter/material.dart';

class PlanetFX extends StatefulWidget {
  final bool expanded;                 // đổi từ false -> true sẽ rung
  final Widget child;
  final Duration shakeDuration;
  final Duration rippleDuration;
  final double amplitude;              // 👈 biên độ rung (px)
  final int waves;                     // 👈 số nhịp rung (sóng sin)

  const PlanetFX({
    super.key,
    required this.expanded,
    required this.child,
    this.shakeDuration = const Duration(milliseconds: 420),
    this.rippleDuration = const Duration(milliseconds: 520),
    this.amplitude = 6,                // 👈 tăng từ 4 lên 6 cho dễ thấy
    this.waves = 8,                    // 👈 nhiều nhịp hơn
  });

  @override
  State<PlanetFX> createState() => _PlanetFXState();
}

class _PlanetFXState extends State<PlanetFX> with TickerProviderStateMixin {
  late final AnimationController _shake;
  late final AnimationController _ripple;
  bool _didExpand = false;

  @override
  void initState() {
    super.initState();
    _shake = AnimationController(vsync: this, duration: widget.shakeDuration);
    _ripple = AnimationController(vsync: this, duration: widget.rippleDuration);
  }

  @override
  void didUpdateWidget(covariant PlanetFX oldWidget) {
    super.didUpdateWidget(oldWidget);
    // chỉ khi chuyển từ đóng -> mở
    if (!oldWidget.expanded && widget.expanded) {
      _didExpand = true;
      _shake.forward(from: 0);
      _ripple.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _shake.dispose();
    _ripple.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = CurvedAnimation(parent: _shake, curve: Curves.easeOutCubic).value;
    // rung: sin(waves * PI * t) * (1 - t) * amplitude
    final dx = sin(t * pi * widget.waves) * (1 - t) * widget.amplitude;

    return AnimatedBuilder(
      animation: Listenable.merge([_shake, _ripple]),
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            if (_didExpand) _RippleRings(progress: _ripple.value),
            Transform.translate(offset: Offset(dx, 0), child: widget.child),
          ],
        );
      },
    );
  }
}

class _RippleRings extends StatelessWidget {
  final double progress; // 0..1
  const _RippleRings({required this.progress});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _ring(progress),
          _ring((progress - 0.25).clamp(0.0, 1.0)),
        ],
      ),
    );
  }

  Widget _ring(double p) {
    if (p <= 0) return const SizedBox.shrink();
    return Opacity(
      opacity: (1 - p) * 0.8,
      child: Transform.scale(
        scale: 1 + p * 0.8,
        child: Container(
          width: 72, height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.35 * (1 - p)), width: 2),
          ),
        ),
      ),
    );
  }
}
