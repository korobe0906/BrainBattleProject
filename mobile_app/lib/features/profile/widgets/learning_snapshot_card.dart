import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import 'profile_glass_card.dart';
import 'profile_info_tile.dart';
import 'profile_progress_row.dart';

class LearningSnapshotCard extends StatelessWidget {
  const LearningSnapshotCard({
    super.key,
    required this.currentLevel,
    required this.goal,
    required this.targetLanguage,
    required this.focusSkills,
  });

  final String currentLevel;
  final String goal;
  final String targetLanguage;
  final List<String> focusSkills;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final battle = context.battleTokens.colors;
    final completion = focusSkills.isEmpty ? 0.24 : 0.62;

    return ProfileGlassCard(
      glowColor: battle.accent,
      borderColor: battle.accent.withOpacity(0.5),
      child: Column(
        children: [
          ProfileInfoTile(
            icon: Icons.language_rounded,
            label: 'Target Language',
            value: targetLanguage,
            color: battle.accent,
          ),
          const SizedBox(height: AppSpacing.md),
          ProfileInfoTile(
            icon: Icons.flag_rounded,
            label: 'Goal',
            value: goal,
            color: app.info,
          ),
          const SizedBox(height: AppSpacing.md),
          ProfileInfoTile(
            icon: Icons.trending_up_rounded,
            label: 'Current Level',
            value: currentLevel,
            color: app.success,
          ),
          const SizedBox(height: AppSpacing.lg),
          ProfileProgressRow(
            label: 'Profile Completion',
            value: completion,
            color: battle.accent,
          ),
        ],
      ),
    );
  }
}