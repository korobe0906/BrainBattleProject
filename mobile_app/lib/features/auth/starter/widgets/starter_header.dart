import 'package:flutter/material.dart';

import '../../../../app.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/brand/brand_logo.dart';

class StarterHeader extends StatelessWidget {
  const StarterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned.fill(
      top: 24,
      child: Stack(
        children: [
          Positioned(
            right: 16,
            top: 0,
            child: IconButton(
              tooltip: 'Toggle theme',
              onPressed: () => BrainBattleApp.of(context).toggleTheme(),
              icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: app.textPrimary,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: AppSpacing.xs),
                Image(
                  image: AssetImage('assets/brainbattle_logo_light_pink.png'),
                  width: 92,
                  height: 92,
                ),
                SizedBox(height: 22),
                BrandLogo(scale: 1.18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}