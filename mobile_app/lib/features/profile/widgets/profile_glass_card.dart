import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';

class ProfileGlassCard extends StatelessWidget {
  const ProfileGlassCard({
    super.key,
    required this.child,
    required this.glowColor,
    this.borderColor,
  });

  final Widget child;
  final Color glowColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: auth.cardBackground.withOpacity(isDark ? 0.86 : 0.78),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: borderColor ?? glowColor.withOpacity(0.42),
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(isDark ? 0.22 : 0.16),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: app.backgroundPrimary.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}