import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/neon/neon_button.dart';
import '../../../core/widgets/neon/neon_card.dart';
import '../../../core/widgets/neon/neon_scaffold.dart';

class ShellPlaceholderPage extends StatelessWidget {
  const ShellPlaceholderPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.primaryActionLabel,
    this.onPrimaryAction,
  });

  factory ShellPlaceholderPage.home({
    required VoidCallback onGoLearn,
  }) {
    return ShellPlaceholderPage(
      title: 'Home',
      subtitle: 'Your BrainBattle command center is ready.',
      icon: Icons.auto_awesome_rounded,
      primaryActionLabel: 'Personalize Learning',
      onPrimaryAction: onGoLearn,
    );
  }

  final String title;
  final String subtitle;
  final IconData icon;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final battle = context.battleTokens.colors;

    return NeonScaffold(
      title: title,
      subtitle: subtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NeonCard(
            accent: battle.accent,
            child: Column(
              children: [
                Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        auth.brandPrimary,
                        auth.brandSecondary,
                        battle.accent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: auth.accent.withOpacity(0.30),
                        blurRadius: 26,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Icon(icon, size: 42, color: Colors.white),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: app.textPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: app.textSecondary,
                        height: 1.45,
                      ),
                ),
                if (primaryActionLabel != null) ...[
                  const SizedBox(height: AppSpacing.xl),
                  NeonButton(
                    label: primaryActionLabel!,
                    icon: Icons.arrow_forward_rounded,
                    onPressed: onPrimaryAction,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}