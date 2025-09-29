import 'dart:math';
import 'package:flutter/material.dart';
import '../data/lesson_model.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onTap;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = _accentColorFor(lesson);
    final bg = isDark ? const Color(0xFF141C34) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF111111);
    final textSecondary = isDark ? Colors.white70 : Colors.black54;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
          ],
          // nhẹ nhàng như ánh sao
          gradient: isDark
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [bg, bg.withOpacity(0.92)],
                )
              : null,
        ),
        child: Row(
          children: [
            // Hành tinh nhỏ (avatar) với glow
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: accent.withOpacity(0.55), blurRadius: 24, spreadRadius: 2),
                    ],
                  ),
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent,
                    gradient: const RadialGradient(
                      colors: [Colors.white24, Colors.black26],
                      center: Alignment.topLeft,
                      radius: 1.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _twoLetter(lesson.title),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),

            // Nội dung
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // tiêu đề + chip level
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lesson.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _LevelChip(level: lesson.level.toString(), color: accent),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if ((lesson.description).isNotEmpty)
                    Text(
                      lesson.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: textSecondary, height: 1.25),
                    ),
                  const SizedBox(height: 10),

                  // thanh tiến độ mảnh + % chữ
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: _clamp01(lesson.progress),
                            minHeight: 6,
                            backgroundColor: (isDark ? Colors.white10 : Colors.black12),
                            color: accent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${(_clamp01(lesson.progress) * 100).round()}%',
                        style: TextStyle(color: textSecondary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // vòng tiến độ tròn nhỏ + mũi tên
            SizedBox(
              width: 52,
              height: 52,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: _clamp01(lesson.progress)),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    builder: (_, v, __) => CircularProgressIndicator(
                      value: v,
                      strokeWidth: 5,
                      color: accent,
                      backgroundColor: isDark ? Colors.white12 : Colors.black12,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: textSecondary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === helpers ===
  static double _clamp01(double v) => v.isNaN ? 0 : v.clamp(0.0, 1.0);
  static String _twoLetter(String s) {
    final parts = s.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) return (parts[0].isNotEmpty ? parts[0][0] : '') + (parts[1].isNotEmpty ? parts[1][0] : '');
    return s.isNotEmpty ? s[0] : '?';
  }

  // Tạo màu nhấn ổn định theo lesson (ưu tiên field color nếu model có)
  Color _accentColorFor(Lesson l) {
    try {
      // nếu model có field color (Color?) -> dùng luôn
      final colorField = (l as dynamic).color;
      if (colorField is Color) return colorField;
    } catch (_) {}
    // fallback: băm theo title để ra màu ổn định
    final palette = <Color>[
      const Color(0xFF00C2FF),
      const Color(0xFFFF6B6B),
      const Color(0xFFF7B500),
      const Color(0xFF7C4DFF),
      const Color(0xFF2ECC71),
      const Color(0xFFFF8A65),
      const Color(0xFF26A69A),
    ];
    final h = l.title.hashCode.abs();
    return palette[h % palette.length];
  }
}

class _LevelChip extends StatelessWidget {
  final String level;
  final Color color;
  const _LevelChip({required this.level, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? color.withOpacity(0.18) : color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, size: 14, color: color),
          const SizedBox(width: 6),
          Text('Lv. $level', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isDark ? Colors.white : Colors.black87)),
        ],
      ),
    );
  }
}
