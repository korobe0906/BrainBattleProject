// lib/features/auth/starter/starter_page.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../learning/learning.dart';
import '../../learning/ui/galaxy_map_screen.dart';
import '../../community/community_shell.dart';
import '../../shortvideo/shortvideo.dart';

class StarterPage extends StatelessWidget {
  const StarterPage({super.key});
  static const routeName = '/starter';
  
  // Màu chữ giống Splash
  static const _pinkBrain = Color(0xFFFF8FAB);
  static const _pinkBattle = Color(0xFFF3B4C3);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final w = MediaQuery.of(context).size.width;
    final titleSize = (w * 0.09).clamp(24.0, 34.0).toDouble();

    return Scaffold(
      backgroundColor: BBColors.darkBg,
      body: SafeArea(
        child: Stack(
          children: [
            // Header logo + tên app
            Positioned.fill(
              top: 24,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const Image(
                      image: AssetImage(
                        'assets/brainbattle_logo_light_pink.png',
                      ),
                      width: 92,
                      height: 92,
                    ),
                    const SizedBox(height: 28),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'BRAIN ',
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 4.0,
                              color: _pinkBrain,
                            ),
                          ),
                          TextSpan(
                            text: 'BATTLE',
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 4.0,
                              color: _pinkBattle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Card pastel
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2238), // tím than đậm pastel
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Learn the local language for free!',
                      textAlign: TextAlign.center,
                      style: text.titleMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Learn all local languages\ninteractively at your fingertips!',
                      textAlign: TextAlign.center,
                      style: text.bodyMedium!.copyWith(
                        color: Colors.white70,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) {
                        final active = i == 1;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: active ? 18 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // Buttons (Register / Login)
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _pinkBrain,
                              side: const BorderSide(color: _pinkBrain),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, CommunityShell.routeName);

                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Register'),
                                SizedBox(width: 6),
                                Icon(Icons.arrow_right_alt, size: 18),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _pinkBattle,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Login'),
                                SizedBox(width: 6),
                                Icon(Icons.arrow_right_alt, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ✅ Nút bắt đầu học tiếng Anh
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFB3C6), // nhạt
                              Color(0xFFFB6F92), // đậm
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .transparent, // quan trọng: để lộ gradient
                            shadowColor: Colors.transparent, // bỏ bóng
                            foregroundColor: Colors.white, // text + icon trắng
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ShortVideoShell(), // ⬅️ thay vì GalaxyMapScreen
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Bắt đầu học tiếng Anh'),
                              SizedBox(width: 6),
                              Icon(Icons.school, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
