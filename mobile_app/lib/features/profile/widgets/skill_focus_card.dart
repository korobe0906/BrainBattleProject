import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import 'profile_badge.dart';
import 'profile_glass_card.dart';

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

    final hasSkills = focusSkills.isNotEmpty || weakSkills.isNotEmpty;

    return ProfileGlassCard(
      glowColor: auth.accent,
      child: hasSkills
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (focusSkills.isNotEmpty) ...[
                  Text(
                    'Focus Skills',
                    style: TextStyle(
                      color: app.textPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: focusSkills.map((skill) {
                      return ProfileBadge(
                        icon: Icons.auto_awesome_rounded,
                        label: skill,
                        color: battle.accent,
                      );
                    }).toList(),
                  ),
                ],
                if (weakSkills.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Needs Attention',
                    style: TextStyle(
                      color: app.textPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: weakSkills.map((skill) {
                      return ProfileBadge(
                        icon: Icons.warning_amber_rounded,
                        label: skill,
                        color: app.warning,
                      );
                    }).toList(),
                  ),
                ],
              ],
            )
          : _EmptySkillState(color: auth.accent),
    );
  }
}

class _EmptySkillState extends StatelessWidget {
  const _EmptySkillState({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final text = Theme.of(context).textTheme;

    return Column(
      children: [
        Icon(Icons.psychology_alt_rounded, color: color, size: 42),
        const SizedBox(height: AppSpacing.md),
        Text(
          'No skill focus selected',
          style: text.titleMedium?.copyWith(
            color: app.textPrimary,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Choose your priority skills in Learn to personalize training.',
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