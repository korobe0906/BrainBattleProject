import 'package:flutter/material.dart';
import 'lesson_model.dart';

class Unit {
  final String id;
  final String title;
  final Color color;        // màu chủ đạo cho Sun/hệ
  final List<Lesson> lessons;

  Unit({
    required this.id,
    required this.title,
    required this.color,
    required this.lessons,
  });
}
