import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/theme_extensions.dart';

class NeonSectionTitle extends StatelessWidget {
  const NeonSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final auth = context.authTokens.colors;

    return Row(
      children: [
        Expanded(child: Divider(color: auth.accent.withOpacity(0.25))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: auth.accent,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(child: Divider(color: auth.accent.withOpacity(0.25))),
      ],
    );
  }
}