import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import 'profile_glass_card.dart';
import 'profile_info_tile.dart';

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

    final hasGoal = currentLevel != 'Not set' ||
        goal != 'Not set' ||
        targetLanguage != 'Not set' ||
        focusSkills.isNotEmpty;

    return ProfileGlassCard(
      glowColor: battle.accent,
      borderColor: battle.accent.withOpacity(0.5),
      child: hasGoal
          ? Column(
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
                if (focusSkills.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  ProfileInfoTile(
                    icon: Icons.auto_awesome_rounded,
                    label: 'Focus Skills',
                    value: focusSkills.join(', '),
                    color: app.warning,
                  ),
                ],
              ],
            )
          : _EmptyLearningState(color: battle.accent),
    );
  }
}

class _EmptyLearningState extends StatelessWidget {
  const _EmptyLearningState({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final text = Theme.of(context).textTheme;

    return Column(
      children: [
        Icon(Icons.route_rounded, color: color, size: 42),
        const SizedBox(height: AppSpacing.md),
        Text(
          'No learning goal yet',
          style: text.titleMedium?.copyWith(
            color: app.textPrimary,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Set a language goal anytime from the Learn tab.',
          textAlign: TextAlign.center,
          style: text.bodySmall?.copyWith(
            color: app.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}