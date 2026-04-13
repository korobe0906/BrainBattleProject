import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/theme/theme_extensions.dart';
import 'widgets/starter_header.dart';
import 'widgets/starter_popup.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});
  static const routeName = '/starter';

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  final _pageCtrl = PageController();
  int _current = 0;

  static const List<StarterSlide> _slides = [
    StarterSlide(
      '🌟 Learn English - Play - Connect',
      'Discover a new way to learn English through games, videos, and a vibrant social community — every lesson feels like an adventure!',
    ),
    StarterSlide(
      '🔥 Level Up - Join the Battle!',
      'Turn learning into a quest. Level up, form clans, chat with friends, and climb the leaderboard today!',
    ),
    StarterSlide(
      '💬 Study Less, Live More',
      'Experience personalized learning that adapts to your pace — connect, share, and grow with learners worldwide.',
    ),
    StarterSlide(
      '🚀 Unlock Your World',
      'Begin your English journey today — where skills, emotion, and community unite in one powerful experience.',
    ),
    StarterSlide(
      '⚔️ Compete - Learning Together!',
      'Collect achievements that reflect your growth.',
    ),
  ];

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final cardMinHeight = (h * 0.46).clamp(350.0, 560.0);

    return Scaffold(
      backgroundColor: app.backgroundPrimary,
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
            child: Stack(
              children: [
                const StarterHeader(),
                StarterPopup(
                  minHeight: cardMinHeight,
                  pageCtrl: _pageCtrl,
                  currentIndex: _current,
                  slides: _slides,
                  onPageChanged: (i) => setState(() => _current = i),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}