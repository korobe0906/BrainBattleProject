import 'dart:math';
import 'package:flutter/material.dart';

class Starfield extends StatefulWidget {
  final int count;
  const Starfield({super.key, this.count = 120});

  @override
  State<Starfield> createState() => _StarfieldState();
}

class _StarfieldState extends State<Starfield> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final List<_Star> _stars;
  final _rnd = Random();

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
    _stars = List.generate(widget.count, (_) => _Star.random(_rnd));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => CustomPaint(painter: _StarPainter(_stars, _c.value)),
    );
  }
}

class _Star {
  double x, y, z, speed, size;
  _Star(this.x, this.y, this.z, this.speed, this.size);
  factory _Star.random(Random r) => _Star(
        r.nextDouble(), r.nextDouble(), r.nextDouble(), 0.02 + r.nextDouble() * 0.08, 0.5 + r.nextDouble() * 1.2);
}

class _StarPainter extends CustomPainter {
  final List<_Star> stars; final double t;
  _StarPainter(this.stars, this.t);

  @override
  void paint(Canvas c, Size s) {
    final p = Paint()..color = Colors.white.withOpacity(0.8);
    for (final st in stars) {
      final depth = (st.z + t * st.speed) % 1.0;
      final px = st.x * s.width;
      final py = (st.y * s.height + depth * 40) % s.height;
      p.maskFilter = MaskFilter.blur(BlurStyle.normal, 0.8 + (1 - depth) * 2);
      c.drawCircle(Offset(px, py), st.size * (1.2 - depth), p);
    }
  }
  @override
  bool shouldRepaint(covariant _StarPainter old) => true;
}
