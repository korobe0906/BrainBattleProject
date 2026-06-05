import 'package:flutter/material.dart';

String profileInitials(String value) {
  final words = value
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();

  if (words.isEmpty) return 'L';

  if (words.length == 1) {
    final one = words.first;
    return one.length >= 2
        ? one.substring(0, 2).toUpperCase()
        : one.toUpperCase();
  }

  return '${words.first[0]}${words.last[0]}'.toUpperCase();
}

double profileSkillValue(String skill) {
  final normalized = skill.toLowerCase();

  if (normalized.contains('grammar')) return 0.75;
  if (normalized.contains('listening')) return 0.62;
  if (normalized.contains('vocabulary')) return 0.68;
  if (normalized.contains('reading')) return 0.58;
  if (normalized.contains('speaking')) return 0.53;
  if (normalized.contains('writing')) return 0.49;
  if (normalized.contains('pronunciation')) return 0.56;
  if (normalized.contains('conversation')) return 0.64;

  return 0.50;
}

Color profileSkillColor({
  required String skill,
  required Color authAccent,
  required Color battleAccent,
  required dynamic app,
}) {
  final normalized = skill.toLowerCase();

  if (normalized.contains('listening')) return battleAccent;
  if (normalized.contains('vocabulary')) return app.info;
  if (normalized.contains('reading')) return app.warning;
  if (normalized.contains('speaking')) return authAccent.withOpacity(0.85);
  if (normalized.contains('writing')) return app.success;

  return authAccent;
}