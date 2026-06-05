import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../utils/profile_ui_helpers.dart';
import 'profile_badge.dart';
import 'profile_glass_card.dart';
import 'profile_progress_row.dart';

class SkillFocusCard extends StatelessWidget {
  const SkillFocusCard({
    super.key,
    required this.focusSkills,
    required this.weakSkills,
  });

  final List<String> focusSkills;
  final List<String> weakSkills;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final battle = context.battleTokens.colors;

    final skills = focusSkills.isEmpty
        ? const ['Vocabulary', 'Grammar', 'Listening']
        : focusSkills.take(5).toList();

    return ProfileGlassCard(
      glowColor: auth.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...skills.map((skill) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: ProfileProgressRow(
                label: skill,
                value: profileSkillValue(skill),
                color: profileSkillColor(
                  skill: skill,
                  authAccent: auth.accent,
                  battleAccent: battle.accent,
                  app: app,
                ),
              ),
            );
          }),
          if (weakSkills.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: weakSkills.take(4).map((skill) {
                return ProfileBadge(
                  icon: Icons.warning_amber_rounded,
                  label: skill,
                  color: app.warning,
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}