import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../app.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_extensions.dart';

class NeonScaffold extends StatelessWidget {
  const NeonScaffold({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.showBack = false,
    this.onBack,
    this.actions = const [],
    this.bottomNavigationBar,
    this.padding = AppSpacing.pagePadding,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget> actions;
  final Widget? bottomNavigationBar;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final battle = context.battleTokens.colors;
    final text = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: app.backgroundPrimary,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.15, -0.9),
                  radius: 1.15,
                  colors: [
                    auth.accent.withOpacity(isDark ? 0.28 : 0.16),
                    battle.accent.withOpacity(isDark ? 0.10 : 0.06),
                    app.backgroundPrimary,
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: isDark ? 0.34 : 0.16,
                child: Lottie.asset(
                  'assets/animations/animation_point.json',
                  fit: BoxFit.cover,
                  repeat: true,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      if (showBack)
                        _CircleIconButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: onBack ?? () => Navigator.of(context).maybePop(),
                        ),
                      if (showBack) const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: showBack
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.start,
                          children: [
                            if (title != null)
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    auth.brandPrimary,
                                    auth.brandSecondary,
                                    battle.accent,
                                  ],
                                ).createShader(bounds),
                                child: Text(
                                  title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: text.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.7,
                                  ),
                                ),
                              ),
                            if (subtitle != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                subtitle!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: text.bodySmall?.copyWith(
                                  color: app.textSecondary,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Toggle theme',
                        onPressed: () => BrainBattleApp.of(context).toggleTheme(),
                        icon: Icon(
                          isDark
                              ? Icons.light_mode_rounded
                              : Icons.dark_mode_rounded,
                          color: app.textPrimary,
                        ),
                      ),
                      ...actions,
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: padding,
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: auth.cardBackground.withOpacity(0.76),
          border: Border.all(color: auth.accent.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: auth.accent.withOpacity(0.22),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(icon, color: app.textPrimary, size: 18),
      ),
    );
  }
}