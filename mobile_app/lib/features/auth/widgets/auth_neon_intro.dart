import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';

class AuthNeonIntro extends StatelessWidget {
  const AuthNeonIntro({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final battle = context.battleTokens.colors;
    final text = Theme.of(context).textTheme;

    return Column(
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
                color: auth.accent.withOpacity(0.34),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 42),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          title,
          textAlign: TextAlign.center,
          style: text.headlineSmall?.copyWith(
            color: app.textPrimary,
            fontWeight: FontWeight.w900,
            height: 1.05,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: text.bodyMedium?.copyWith(
            color: app.textSecondary,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}