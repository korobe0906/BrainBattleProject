import 'package:flutter/material.dart';

import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/theme_extensions.dart';

class BBButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool ghost;
  final IconData? icon;

  const BBButton.primary(
    this.label, {
    super.key,
    this.onPressed,
    this.icon,
  }) : ghost = false;

  const BBButton.ghost(
    this.label, {
    super.key,
    this.onPressed,
    this.icon,
  }) : ghost = true;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 18,
            color: ghost ? app.textPrimary : app.textInverse,
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: ghost ? app.textPrimary : app.textInverse,
          ),
        ),
      ],
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      decoration: BoxDecoration(
        gradient: ghost
            ? null
            : LinearGradient(
                colors: [auth.brandPrimary, auth.brandSecondary],
              ),
        color: ghost ? app.surfacePrimary.withOpacity(0.9) : null,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: ghost
            ? const []
            : [
                BoxShadow(
                  color: auth.heroGlow,
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
        border: ghost
            ? Border.all(color: app.borderStrong, width: 1)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}