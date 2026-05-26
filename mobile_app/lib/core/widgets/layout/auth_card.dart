import 'package:flutter/material.dart';

import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_extensions.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: auth.cardBackground.withOpacity(0.92),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: app.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: auth.heroGlow,
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}