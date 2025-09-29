import 'package:flutter/material.dart';
import '../data/lesson_model.dart';
import '../widgets/skill_planet.dart'; // để lấy enum Skill

class LessonDetailScreen extends StatelessWidget {
  final Lesson lesson;
  final Skill? initialSkill;   // 👈 thêm tuỳ chọn kỹ năng
  final Object? heroTag;       // 👈 cho Hero animation từ SkillPlanet

  const LessonDetailScreen({
    super.key,
    required this.lesson,
    this.initialSkill,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),
      appBar: AppBar(
        title: Text(
          initialSkill != null
              ? "${lesson.title} • ${initialSkill!.label}"
              : lesson.title,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (heroTag != null)
              Hero(
                tag: heroTag!,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: initialSkill != null
                          ? Icon(initialSkill!.icon, color: Colors.white)
                          : Text(lesson.title[0]),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Text(
              lesson.description,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text("Level: ${lesson.level}",
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
