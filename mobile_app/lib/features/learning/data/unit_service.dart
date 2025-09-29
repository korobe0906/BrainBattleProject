import 'package:flutter/material.dart';
import 'unit_model.dart';
import 'lesson_model.dart';

class UnitService {
  Future<List<Unit>> fetchUnits() async {
    await Future.delayed(const Duration(milliseconds: 400));

    final u1 = [
      Lesson(id:"1-1", title:"Greetings",        description:"Hello/Goodbye",   level:"A1", progress:0.35, status: LessonStatus.unlocked),
      Lesson(id:"1-2", title:"Numbers & Colors", description:"Basics",          level:"A1", progress:1.00, status: LessonStatus.completed),
      Lesson(id:"1-3", title:"Family & Friends", description:"Introduce",       level:"A2", progress:0.10, status: LessonStatus.locked),
    ];
    final u2 = [
      Lesson(id:"2-1", title:"Food & Drinks",    description:"Ordering",        level:"A1", progress:0.20, status: LessonStatus.unlocked),
      Lesson(id:"2-2", title:"At School",        description:"Class phrases",   level:"A1", progress:0.00, status: LessonStatus.locked),
      Lesson(id:"2-3", title:"City & Transport", description:"Directions",      level:"A2", progress:0.90, status: LessonStatus.unlocked),
    ];
    final u3 = [
      Lesson(id:"3-1", title:"Travel Plans",     description:"Booking",         level:"A2", progress:0.55, status: LessonStatus.unlocked),
      Lesson(id:"3-2", title:"Hotel Talk",       description:"Check-in",        level:"A2", progress:0.00, status: LessonStatus.locked),
    ];

    return [
      Unit(id:"U1", title:"Unit 1 • Basics",     color: const Color(0xFFFFD166), lessons: u1),
      Unit(id:"U2", title:"Unit 2 • Daily Life", color: const Color(0xFF00C2FF), lessons: u2),
      Unit(id:"U3", title:"Unit 3 • Travel",     color: const Color(0xFF7C4DFF), lessons: u3),
    ];
  }
}
