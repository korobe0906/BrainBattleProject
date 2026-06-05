import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/neon/neon_button.dart';
import '../../../core/widgets/neon/neon_card.dart';
import '../../../core/widgets/neon/neon_scaffold.dart';
import '../login/login_page.dart';
import '../signup/sign_up_page.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  static const routeName = '/starter';

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  final _pageCtrl = PageController();
  int _current = 0;

  static const _slides = [
    _StarterSlide(
      icon: Icons.auto_awesome_rounded,
      title: 'Learn languages through battle',
      subtitle:
          'Build skills, challenge friends, and turn language learning into a real game journey.',
    ),
    _StarterSlide(
      icon: Icons.bolt_rounded,
      title: 'Practice faster, remember longer',
      subtitle:
          'Personalized lessons and quick battles help you improve every day without boring drills.',
    ),
    _StarterSlide(
      icon: Icons.shield_rounded,
      title: 'Verified rewards coming next',
      subtitle:
          'Your progress, rewards, and blockchain verification will connect in one production flow.',
    ),
  ];

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _goLogin() {
    Navigator.of(context).pushNamed(LoginPage.routeName);
  }

  void _goSignup() {
    Navigator.of(context).pushNamed(SignUpPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final battle = context.battleTokens.colors;

    return NeonScaffold(
      title: 'BrainBattle',
      subtitle: 'Competitive language learning',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 360,
            child: PageView.builder(
              controller: _pageCtrl,
              itemCount: _slides.length,
              onPageChanged: (value) => setState(() => _current = value),
              itemBuilder: (context, index) {
                final slide = _slides[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: NeonCard(
                    accent: index == 1 ? battle.accent : auth.accent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                auth.brandPrimary,
                                auth.brandSecondary,
                                battle.accent,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: auth.accent.withOpacity(0.35),
                                blurRadius: 30,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Icon(slide.icon, color: Colors.white, size: 46),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: app.textPrimary,
                                    fontWeight: FontWeight.w900,
                                    height: 1.08,
                                  ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          slide.subtitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: app.textSecondary,
                                height: 1.45,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_slides.length, (index) {
              final selected = index == _current;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: selected ? 26 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  color: selected ? auth.accent : app.borderStrong,
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.xl),
          NeonButton(
            label: 'Start Learning',
            icon: Icons.rocket_launch_rounded,
            onPressed: _goSignup,
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton(
            onPressed: _goLogin,
            child: const Text('I already have an account'),
          ),
        ],
      ),
    );
  }
}

class _StarterSlide {
  const _StarterSlide({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}