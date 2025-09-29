import 'package:flutter/material.dart';

enum Skill { listening, speaking, reading, writing }
extension SkillX on Skill {
  String get label => switch (this) {
    Skill.listening => 'Nghe', Skill.speaking => 'Nói', Skill.reading => 'Đọc', Skill.writing => 'Viết',
  };
  IconData get icon => switch (this) {
    Skill.listening => Icons.headset,
    Skill.speaking => Icons.record_voice_over,
    Skill.reading => Icons.menu_book,
    Skill.writing => Icons.edit,
  };
}

class SkillPlanet extends StatelessWidget {
  final Skill skill;
  final Color color;
  final Object? heroTag;
  final VoidCallback onTap;
  const SkillPlanet({super.key, required this.skill, required this.color, required this.onTap, this.heroTag});

  @override
  Widget build(BuildContext context) {
    final node = Material(
      color: Colors.transparent,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.95),
            boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 16)]),
          child: Icon(skill.icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(skill.label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ]),
    );
    return GestureDetector(onTap: onTap, child: heroTag!=null ? Hero(tag: heroTag!, child: node) : node);
  }
}
