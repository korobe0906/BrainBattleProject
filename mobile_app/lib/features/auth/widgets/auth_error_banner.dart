import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';

class AuthErrorBanner extends StatelessWidget {
  const AuthErrorBanner({
    super.key,
    required this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null || message!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final app = context.appTokens.colors;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: app.error.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: app.error.withOpacity(0.45)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: app.error),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message!,
              style: TextStyle(
                color: app.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}