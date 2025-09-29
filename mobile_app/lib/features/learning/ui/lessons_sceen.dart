import 'dart:math';
import 'package:flutter/material.dart';
import '../data/lesson_service.dart';
import '../data/lesson_model.dart';
import '../widgets/lesson_card.dart';           
import 'lesson_detail_screen.dart';
import '../widgets/starfield.dart';
import '../widgets/orbit_ring.dart';
import '../widgets/skill_planet.dart';
import '../widgets/planet_fx.dart';
import 'package:flutter/services.dart'; // để HapticFeedback (tuỳ thích)
import 'daily_mission_screen.dart';




class LessonsScreen extends StatefulWidget {
  static const String routeName = '/lessons';

  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}



class _LessonsScreenState extends State<LessonsScreen> with TickerProviderStateMixin {
  final LessonService _service = LessonService();
  List<Lesson> _lessons = [];
  bool _loading = true;
  String? _expandedId;

  late final AnimationController _rotation;

  @override
  void initState() {
    super.initState();
    _rotation = AnimationController(vsync: this, duration: const Duration(seconds: 18))..repeat();
    _loadLessons();
  }

  @override
  void dispose() {
    _rotation.dispose();
    super.dispose();
  }

  Future<void> _loadLessons() async {
    try {
      final lessons = await _service.fetchLessons();
      setState(() {
        _lessons = lessons;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không tải được danh sách bài học: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0B1020) : null,
      appBar: AppBar(
        title: const Text("English Lessons"),
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : null,
        elevation: 0,
        actions: [
          // Nút chuyển giữa Orbit <-> List (fallback nếu cần xem nhanh dạng list)
          IconButton(
            tooltip: _expandedId == '_list' ? 'Xem dạng hành tinh' : 'Xem dạng danh sách',
            onPressed: () => setState(() {
              _expandedId = _expandedId == '_list' ? null : '_list';
            }),
            icon: Icon(_expandedId == '_list' ? Icons.blur_circular : Icons.view_list),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _lessons.isEmpty
              ? const Center(child: Text('Chưa có bài học'))
              : (_expandedId == '_list'
                  ? _buildListFallback()              // danh sách cũ nếu muốn
                  : _buildOrbitUI()),                 // giao diện hành tinh
    );
  }

  // ========== UI: ORBIT ==========
  Widget _buildOrbitUI() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final orbitR = min(size.width, size.height) * 0.34;

        return Stack(
          children: [
            // nền sao
            const Positioned.fill(child: Starfield(count: 120)),

            // hệ hành tinh trung tâm
            Center(
              child: AnimatedBuilder(
                animation: _rotation,
                builder: (_, __) => Stack(
                  alignment: Alignment.center,
                  children: [
                    // quỹ đạo chính
                    OrbitRing(radius: orbitR * 1.1, color: Colors.white12, dashed: true),

                    // mặt trời trang trí
                    _buildSun(orbitR),

                    // Hành tinh Daily Mission (quỹ đạo riêng, quay nhanh hơn)
                 // ..._buildDailyPlanet(orbitR * 0.75, _rotation.value),

                    // các hành tinh bài học
                    ..._buildLessonPlanets(orbitR, _rotation.value),

                    // nếu 1 lesson đang mở, hiển thị 4 kỹ năng
                    if (_expandedId != null) ..._buildSkillOrbitAndPlanets(orbitR * 0.55),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSun(double orbitR) {
    return Container(
      width: orbitR * 0.44,
      height: orbitR * 0.44,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [Color(0xFFFFF3B0), Color(0x00FFF3B0)]),
      ),
      child: Center(
        child: Container(
          width: orbitR * 0.2,
          height: orbitR * 0.2,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFFD166)),
        ),
      ),
    );
  }

 List<Widget> _buildLessonPlanets(double r, double t) {
  final widgets = <Widget>[];

  for (var i = 0; i < _lessons.length; i++) {
    final lesson = _lessons[i];
    final angle = (2 * pi * i / _lessons.length) + (2 * pi * t);
    final x = r * cos(angle);
    final y = r * sin(angle);

    // ——— xác định trạng thái ———
    final status = _resolveStatus(i, lesson);
    final selected = _expandedId == lesson.id;

     widgets.add(
  Transform.translate(
    offset: Offset(x, y),
    child: Tooltip(
      // Tooltip khi chạm
      message: "${lesson.title} – ${(lesson.progress * 100).round()}% completed",
      triggerMode: TooltipTriggerMode.tap,
      showDuration: const Duration(seconds: 2),
      preferBelow: false,
      decoration: BoxDecoration(
        color: const Color(0xFF141C34),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      child: PlanetFX(
        expanded: selected, // 👈 khi được chọn sẽ rung + ripple
        child: PlanetButton(
          size: selected ? 68 : 52,
          color: _accentColorFor(lesson),
          label: lesson.title,
          glow: selected || status == LessonStatus.completed,
          status: status,
          progress: lesson.progress,
          onTap: () {
            if (status == LessonStatus.locked) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bài này chưa mở khóa. Hoàn thành bài trước để mở!')),
              );
              return;
            }
            HapticFeedback.selectionClick(); // rung nhẹ cảm giác chạm
            setState(() {
              _expandedId = selected ? null : lesson.id;
            });
          },
        ),
      ),
    ),
  ),
);


  }
  return widgets;
}

LessonStatus _resolveStatus(int idx, Lesson lesson) {
  // Completed nếu progress >= 1
  if ((lesson.progress).clamp(0.0, 1.0) >= 1.0) return LessonStatus.completed;

  // Locked nếu bài trước chưa completed (trừ bài đầu)
  if (idx > 0) {
    final prev = _lessons[idx - 1];
    if ((prev.progress).clamp(0.0, 1.0) < 1.0) {
      return LessonStatus.locked;
    }
  }

  // Còn lại là unlocked
  return LessonStatus.unlocked;
}

List<Widget> _buildDailyPlanet(double r, double t) {
  // quay nhanh gấp 2
  final angle = (2 * pi * t * 2); // tốc độ *2
  final x = r * cos(angle);
  final y = r * sin(angle);

  final color = const Color.fromARGB(255, 255, 179, 1); // vàng nổi bật
  final selected = _expandedId == '__daily__';

  return [
    Transform.translate(
      offset: Offset(x, y),
      child: Tooltip(
        message: "Daily Mission – tap để mở",
        triggerMode: TooltipTriggerMode.tap,
        showDuration: const Duration(seconds: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF141C34),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24),
        ),
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
        child: PlanetFX(
          expanded: selected,
          // celebrate: true, // nếu muốn luôn có ripple/firework khi mở
          child: PlanetButton(
            size: selected ? 72 : 56,
            color: color,
            label: "Daily",
            glow: true, // luôn sáng để nổi
            status: LessonStatus.unlocked,
            progress: 0, // daily không có % cố định (tuỳ bạn muốn hiển thị)
            onTap: () {
              setState(() => _expandedId = '__daily__'); // cho hiệu ứng expand
              // chuyển ngay sang màn daily
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DailyMissionScreen()),
              ).then((_) {
                // thu lại sau khi trở về
                if (mounted) setState(() => _expandedId = null);
              });
            },
          ),
        ),
      ),
    ),
  ];
}


  List<Widget> _buildSkillOrbitAndPlanets(double r) {
    final lesson = _lessons.firstWhere((e) => e.id == _expandedId);
    final color = _accentColorFor(lesson);

    final ring = Positioned.fill(
      child: Center(child: OrbitRing(radius: r * 1.05, color: color.withOpacity(0.22))),
    );

   final skills = const [Skill.listening, Skill.speaking, Skill.reading, Skill.writing];
    final skillNodes = <Widget>[];

    for (var i = 0; i < skills.length; i++) {
      final angle = (pi / 2) * i - pi / 2; // 12h, 3h, 6h, 9h
      final x = r * cos(angle);
      final y = r * sin(angle);
      final tag = 'skill_${lesson.id}_${skills[i].name}';

      skillNodes.add(Transform.translate(
        offset: Offset(x, y),
        child: SkillPlanet(
          skill: skills[i],
          color: color,
          heroTag: tag,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LessonDetailScreen(
                  lesson: lesson,
                  initialSkill: skills[i],
                  heroTag: tag,
                ),
              ),
            );
          },
        ),
      ));
    }


    final centerLabel = Positioned.fill(
      child: IgnorePointer(
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(lesson.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22)),
            const SizedBox(height: 8),
            const Text('Chọn kỹ năng', style: TextStyle(color: Colors.white70)),
          ]),
        ),
      ),
    );

    return [ring, ...skillNodes, centerLabel];
  }

  // ========== UI: LIST (fallback) ==========
  Widget _buildListFallback() {
    return ListView.builder(
      itemCount: _lessons.length,
      itemBuilder: (context, index) {
        final lesson = _lessons[index];
        return LessonCard(
          lesson: lesson,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: lesson)),
            );
          },
        );
      },
    );
  }

  // ===== helpers =====
  Color _accentColorFor(Lesson l) {
    // Nếu Lesson có field color thì dùng luôn
    try {
      final dynamic dyn = l;
      final c = dyn.color;
      if (c is Color) return c;
    } catch (_) {}
    // nếu không có -> sinh màu ổn định từ title
    final palette = <Color>[
      const Color(0xFF00C2FF),
      const Color(0xFFFF6B6B),
      const Color(0xFFF7B500),
      const Color(0xFF7C4DFF),
      const Color(0xFF2ECC71),
      const Color(0xFFFF8A65),
      const Color(0xFF26A69A),
    ];
    return palette[l.title.hashCode.abs() % palette.length];
  }
}
