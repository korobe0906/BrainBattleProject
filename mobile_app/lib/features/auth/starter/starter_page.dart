import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class StarterPage extends StatelessWidget {
  const StarterPage({super.key});
  static const routeName = '/starter';

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
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
                      image: AssetImage('assets/logo.png'),
                      width: 92,
                      height: 92,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'BrainBattle',
                      style: text.displayMedium!.copyWith(
                        color: BBColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Card vàng
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                decoration: BoxDecoration(
                  color: BBColors.yellow,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Learn the local language for free!',
                      textAlign: TextAlign.center,
                      style: text.titleMedium!.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Learn all local languages\ninteractively at your fingertips!',
                      textAlign: TextAlign.center,
                      style: text.bodyMedium!.copyWith(
                        color: Colors.black87,
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
                            color: Colors.black.withOpacity(active ? 0.8 : 0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
  Navigator.pushReplacementNamed(context, '/messaging');
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
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
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