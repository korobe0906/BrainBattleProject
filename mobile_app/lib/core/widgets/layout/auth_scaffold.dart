import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../app.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_extensions.dart';
import '../brand/brand_logo.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.showLogo = true,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.topSpacing = 12,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final bool showLogo;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final double topSpacing;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final text = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canPop = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: app.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: showBackButton && (canPop || onBackPressed != null)
            ? IconButton(
                tooltip: 'Back',
                onPressed: onBackPressed ??
                    () {
                      Navigator.of(context).maybePop();
                    },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: app.textPrimary,
                ),
              )
            : null,
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: () {
              BrainBattleApp.of(context).toggleTheme();
            },
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: app.textPrimary,
            ),
          ),
          ...?actions,
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Lottie.asset(
                'assets/animations/animation_point.json',
                fit: BoxFit.cover,
                repeat: true,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: SingleChildScrollView(
                  padding: AppSpacing.pagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: topSpacing),
                      if (showLogo) ...[
                        const Hero(
                          tag: 'bb_logo',
                          child: Image(
                            image: AssetImage(
                              'assets/brainbattle_logo_light_pink.png',
                            ),
                            width: 90,
                            height: 90,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const BrandLogo(scale: 1.08),
                        const SizedBox(height: 20),
                      ],
                      if (title != null) ...[
                        Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: text.titleLarge?.copyWith(
                            color: app.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                      if (subtitle != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          subtitle!,
                          textAlign: TextAlign.center,
                          style: text.bodyMedium?.copyWith(
                            color: app.textSecondary,
                            height: 1.35,
                          ),
                        ),
                      ],
                      if (title != null || subtitle != null)
                        const SizedBox(height: 24),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}