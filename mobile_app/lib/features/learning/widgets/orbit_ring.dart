import 'dart:math';
import 'package:flutter/material.dart';

class OrbitRing extends StatelessWidget {
  final double radius;
  final Color color;
  final bool dashed;
  const OrbitRing({super.key, required this.radius, this.color = const Color(0x22FFFFFF), this.dashed = false});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(radius * 2),
      painter: _OrbitPainter(color, dashed),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  final Color color; final bool dashed;
  const _OrbitPainter(this.color, this.dashed);
  @override
  void paint(Canvas canvas, Size size) {
    final r = min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = color;

    if (!dashed) {
      canvas.drawCircle(center, r, paint);
    } else {
      const dash = 14.0, gap = 8.0;
      final count = (2 * pi * r / (dash + gap)).floor();
      for (var i = 0; i < count; i++) {
        final start = i * (dash + gap) / r;
        canvas.drawArc(Rect.fromCircle(center: center, radius: r), start, dash / r, false, paint);
      }
    }
  }
  @override
  bool shouldRepaint(covariant _OrbitPainter old) => old.color != color || old.dashed != dashed;
}

class PlanetButton extends StatelessWidget {
  final double size;
  final Color color;
  final String? label;
  final bool glow;
  final VoidCallback onTap;
  final Object? heroTag;
  const PlanetButton({
    super.key,
    required this.size,
    required this.color,
    this.label,
    this.glow = false,
    required this.onTap,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final core = Container(
      width: size, height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle, color: color,
        gradient: const RadialGradient(colors: [Colors.white24, Colors.black26], center: Alignment.topLeft),
        boxShadow: glow
            ? [BoxShadow(color: color.withOpacity(0.6), blurRadius: 28, spreadRadius: 2)]
            : [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 8)],
      ),
    );

    final planet = GestureDetector(onTap: onTap, child: heroTag!=null ? Hero(tag: heroTag!, child: core) : core);

    if (label == null) return planet;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      planet,
      const SizedBox(height: 6),
      SizedBox(
        width: size * 1.6,
        child: Text(label!, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white70, fontSize: 12)),
      )
    ]);
  }
}
