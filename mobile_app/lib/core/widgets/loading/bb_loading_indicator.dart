import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';

class BBLoadingIndicator extends StatelessWidget {
  const BBLoadingIndicator({
    super.key,
    this.size = 120,
    this.label,
  });

  final double size;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Lottie.asset(
            'assets/animations/logo_animation_light.json',
            repeat: true,
            fit: BoxFit.contain,
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: app.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}