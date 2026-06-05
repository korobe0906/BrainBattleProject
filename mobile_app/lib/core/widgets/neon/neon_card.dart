import 'package:flutter/material.dart';

import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_extensions.dart';

class NeonCard extends StatelessWidget {
  const NeonCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.accent,
    this.glow = true,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? accent;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = accent ?? auth.accent;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: auth.cardBackground.withOpacity(isDark ? 0.88 : 0.84),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: color.withOpacity(isDark ? 0.48 : 0.34)),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: color.withOpacity(isDark ? 0.24 : 0.14),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: app.backgroundPrimary.withOpacity(0.18),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}