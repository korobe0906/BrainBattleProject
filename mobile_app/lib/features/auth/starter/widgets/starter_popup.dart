import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../login/login_page.dart';
import '../../signup/sign_up_page.dart';

class StarterPopup extends StatelessWidget {
  const StarterPopup({
    super.key,
    required this.minHeight,
    required this.pageCtrl,
    required this.currentIndex,
    required this.onPageChanged,
    required this.slides,
  });

  final double minHeight;
  final PageController pageCtrl;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final List<StarterSlide> slides;

  @override
  Widget build(BuildContext context) {
    final auth = context.authTokens.colors;
    final app = context.appTokens.colors;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(AppSpacing.lg),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.xl,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        constraints: BoxConstraints(minHeight: minHeight),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              auth.cardBackground,
              app.surfaceSecondary,
            ],
          ),
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          border: Border.all(color: app.borderStrong, width: 1),
          boxShadow: [
            BoxShadow(
              blurRadius: 22,
              offset: const Offset(0, 10),
              color: auth.heroGlow,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _Grabber(),
            const SizedBox(height: AppSpacing.lg),
            _Slides(
              controller: pageCtrl,
              slides: slides,
              onPageChanged: onPageChanged,
            ),
            const SizedBox(height: AppSpacing.sm),
            _Dots(length: slides.length, current: currentIndex),
            const SizedBox(height: AppSpacing.xl),

            // 🔥 Buttons: Sign up + Login
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, SignUpPage.routeName),
                    icon: const Icon(Icons.person_add_alt_1_rounded, size: 18),
                    label: const Text('Sign up'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, LoginPage.routeName),
                    icon: const Icon(Icons.lock_open_rounded, size: 18),
                    label: const Text('Login'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xs),
          ],
        ),
      ),
    );
  }
}

class StarterSlide {
  final String title;
  final String subtitle;
  const StarterSlide(this.title, this.subtitle);
}

class _Grabber extends StatelessWidget {
  const _Grabber();

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return Container(
      width: 64,
      height: 5,
      decoration: BoxDecoration(
        color: app.textSecondary.withOpacity(0.35),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    );
  }
}

class _Slides extends StatelessWidget {
  const _Slides({
    required this.controller,
    required this.slides,
    required this.onPageChanged,
  });

  final PageController controller;
  final List<StarterSlide> slides;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;

    return SizedBox(
      height: 132,
      child: PageView.builder(
        controller: controller,
        itemCount: slides.length,
        onPageChanged: onPageChanged,
        itemBuilder: (_, i) {
          final slide = slides[i];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                slide.title,
                textAlign: TextAlign.center,
                style: text.titleMedium?.copyWith(
                  color: app.textPrimary,
                  fontSize: 21,
                  height: 1.25,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                slide.subtitle,
                textAlign: TextAlign.center,
                style: text.bodyMedium?.copyWith(
                  color: app.textSecondary,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({
    required this.length,
    required this.current,
  });

  final int length;
  final int current;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: active ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? auth.accent : app.textSecondary.withOpacity(0.35),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
        );
      }),
    );
  }
}