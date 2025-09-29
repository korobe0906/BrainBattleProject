import 'dart:math';
import 'package:flutter/material.dart';
import '../data/lesson_model.dart'; // để dùng LessonStatus

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

  // 👇 thêm mới:
  final LessonStatus status; // locked / unlocked / completed
  final double progress;     // 0..1

  const PlanetButton({
    super.key,
    required this.size,
    required this.color,
    this.label,
    this.glow = false,
    required this.onTap,
    this.heroTag,
    this.status = LessonStatus.unlocked,
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final core = Stack(
      alignment: Alignment.center,
      children: [
        // Vòng tiến độ
        SizedBox(
          width: size + 14,
          height: size + 14,
          child: CustomPaint(
            painter: _ProgressRingPainter(
              progress: progress.clamp(0.0, 1.0),
              trackColor: Colors.white12,
              progressColor: _ringColor(),
              stroke: 5,
            ),
          ),
        ),

        // Hào quang (completed hoặc đang chọn)
        if (glow || status == LessonStatus.completed)
          Container(
            width: size + 16,
            height: size + 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.55), blurRadius: 28, spreadRadius: 2),
              ],
            ),
          ),

        // Thân hành tinh
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _planetColor(),
            gradient: const RadialGradient(
              colors: [Colors.white24, Colors.black26],
              center: Alignment.topLeft,
              radius: 1.0,
            ),
          ),
          child: _planetCenterIcon(),
        ),

        // Khoá (nếu locked)
        if (status == LessonStatus.locked)
          const Positioned(
            right: 0,
            bottom: 0,
            child: Icon(Icons.lock, size: 18, color: Colors.white70),
          ),
      ],
    );

    final tappable = GestureDetector(onTap: onTap, child: heroTag != null ? Hero(tag: heroTag!, child: core) : core);

    if (label == null) return tappable;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        tappable,
        const SizedBox(height: 6),
        SizedBox(
          width: size * 1.8,
          child: Text(
            label!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ——— visuals helpers ———
  Color _planetColor() {
    switch (status) {
      case LessonStatus.locked:
        return color.withOpacity(0.35); // tối mờ
      case LessonStatus.completed:
        return color; // sáng + có glow
      case LessonStatus.unlocked:
      default:
        return color.withOpacity(0.9);
    }
  }

  Color _ringColor() {
    if (status == LessonStatus.completed) {
      return color;               // đầy đủ
    }
    return color.withOpacity(0.9); // đang học
  }

  Widget _planetCenterIcon() {
    switch (status) {
      case LessonStatus.locked:
        return const Icon(Icons.lock_outline, color: Colors.white70, size: 20);
      case LessonStatus.completed:
        return const Icon(Icons.check, color: Colors.white, size: 22);
      case LessonStatus.unlocked:
      default:
        return const SizedBox.shrink();
    }
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;     // 0..1
  final double stroke;
  final Color trackColor;
  final Color progressColor;

  _ProgressRingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    this.stroke = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final r = min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: r);

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = trackColor;
    canvas.drawArc(rect, -pi / 2, 2 * pi, false, track);

    if (progress <= 0) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [progressColor, progressColor],
      ).createShader(rect);

    canvas.drawArc(rect, -pi / 2, 2 * pi * progress, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter old) {
    return old.progress != progress ||
        old.trackColor != trackColor ||
        old.progressColor != progressColor ||
        old.stroke != stroke;
  }
}
