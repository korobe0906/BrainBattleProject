import 'lesson_model.dart';

class LessonService {
  Future<List<Lesson>> fetchLessons() async {
    // Tạm fake dữ liệu, sau này thay bằng API
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Lesson(
        id: "1",
        title: "Lesson 1: Greetings",
        description: "Learn how to say hello and goodbye",
        level: "A1",
        progress: 0.3,
      ),
      Lesson(
        id: "2",
        title: "Lesson 2: Numbers & Colors",
        description: "Practice numbers and basic colors",
        level: "A1",
        progress: 0.7,
      ),
      Lesson(
        id: "3",
        title: "Lesson 3: Family & Friends",
        description: "Introduce your family and friends",
        level: "A2",
        progress: 0.1,
      ),
    ];
  }
}
