// lib/widgets/falling_text.dart
import 'package:flutter/material.dart';
import 'package:characters/characters.dart';

/// Hiệu ứng: từng KÝ TỰ rơi tuần tự (trái -> phải) trong toàn bộ [totalDuration].
/// - Mỗi ký tự có "đoạn thời gian" riêng: start = i/n, end = (i+1)/n.
/// - Trong đoạn đó, ký tự rơi từ -distance -> 0 theo [dropCurve],
///   và fade-in ở phần đầu (tỉ lệ [fadeHeadPortion]).
/// - Mặc định: totalDuration = 20s -> nếu 10 ký tự thì mỗi ký tự rơi ~2s.
class FallingText extends StatefulWidget {
  const FallingText({
    super.key,
    required this.text,
    required this.style,
    this.totalDuration = const Duration(seconds: 20),
    this.distance = 64.0,
    this.dropCurve = Curves.easeOutQuint,
    this.fadeHeadPortion = 0.1, // 40% đầu đoạn của từng ký tự dùng để fade-in
    this.letterSpacing,
  });
  final String text;
  final TextStyle style;

  /// Tổng thời gian để TOÀN BỘ chuỗi hoàn thành (sequential)
  final Duration totalDuration;

  /// Quãng rơi theo trục Y (px, âm -> 0)
  final double distance;

  /// Đường cong rơi cho mỗi ký tự
  final Curve dropCurve;

  /// Tỉ lệ thời gian đầu trong đoạn của MỖI ký tự dành cho fade-in (0..1)
  final double fadeHeadPortion;

  final double? letterSpacing;

  @override
  State<FallingText> createState() => _FallingTextState();
}

class _FallingTextState extends State<FallingText> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<String> _chars;
  late List<Animation<double>> _drops;
  late List<Animation<double>> _fades;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  @override
  void didUpdateWidget(covariant FallingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.totalDuration != widget.totalDuration ||
        oldWidget.distance != widget.distance ||
        oldWidget.dropCurve != widget.dropCurve ||
        oldWidget.fadeHeadPortion != widget.fadeHeadPortion) {
      _ctrl.dispose();
      _setupAnimations();
    }
  }

  void _setupAnimations() {
    _ctrl = AnimationController(vsync: this, duration: widget.totalDuration);
    _chars = widget.text.characters.toList();
    final n = _chars.length;
    _drops = List.filled(n, AlwaysStoppedAnimation<double>(0));
    _fades = List.filled(n, AlwaysStoppedAnimation<double>(1));

    if (n == 0) return;

    for (int i = 0; i < n; i++) {
      // Mỗi ký tự chiếm một "đoạn" bằng nhau trong tổng thời gian
      final double start = (i / n).clamp(0.0, 1.0);
      final double end   = ((i + 1) / n).clamp(0.0, 1.0);
      final double fadeEnd = (start + (end - start) * widget.fadeHeadPortion).clamp(0.0, 1.0);

      final dropIv = Interval(start, end);
      final fadeIv = Interval(start, fadeEnd);

      final dropCurve = CurvedAnimation(parent: _ctrl, curve: _IntervalCurve(widget.dropCurve, dropIv));
      final fadeCurve = CurvedAnimation(parent: _ctrl, curve: _IntervalCurve(Curves.easeOut, fadeIv));

      _drops[i] = Tween<double>(begin: -widget.distance, end: 0).animate(dropCurve);
      _fades[i] = Tween<double>(begin: 0, end: 1).animate(fadeCurve);
    }

    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chars.isEmpty) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_chars.length, (i) {
            return Opacity(
              opacity: _fades[i].value,
              child: Transform.translate(
                offset: Offset(0, _drops[i].value),
                child: Text(
                  _chars[i],
                  style: widget.style.copyWith(
                    letterSpacing: widget.letterSpacing ?? widget.style.letterSpacing,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Curve bọc với Interval: map t (0..1) vào khoảng [iv.begin, iv.end] rồi áp curve
class _IntervalCurve extends Curve {
  final Curve base;
  final Interval iv;
  const _IntervalCurve(this.base, this.iv);

  @override
  double transform(double t) {
    final b = iv.begin, e = iv.end;
    if (t <= b) return base.transform(0);
    if (t >= e) return base.transform(1);
    final local = (t - b) / (e - b);
    return base.transform(local);
  }
}
