import 'lesson_model.dart';

class LessonService {
  Future<List<Lesson>> fetchLessons() async {
    // Tạm fake dữ liệu, sau này thay bằng API
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Lesson(
        id: "1",
        title: "Greetings",
        description: "Learn how to say hello and goodbye",
        level: "A1",
        progress: 0.3,
        status: LessonStatus.unlocked,   // 👈 thêm
      ),
      Lesson(
        id: "2",
        title: "Numbers & Colors",
        description: "Practice numbers and basic colors",
        level: "A1",
        progress: 0.7,
        status: LessonStatus.completed,  // 👈 thêm
      ),
      Lesson(
        id: "3",
        title: "Family & Friends",
        description: "Introduce your family and friends",
        level: "A2",
        progress: 0.1,
        status: LessonStatus.locked,     // 👈 thêm
      ),
    ];
  }
}
