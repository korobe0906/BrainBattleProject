// lesson_model.dart
enum LessonStatus { locked, unlocked, completed }

class Lesson {
  final String id;
  final String title;
  final String description;
  final String level;
  final double progress; // 0..1
  final LessonStatus? status; // 👈 mới (có thể null)

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.progress,
    this.status, // optional
  });

  // Nếu lấy từ JSON, nhớ map status (locked|unlocked|completed) → enum.
}
