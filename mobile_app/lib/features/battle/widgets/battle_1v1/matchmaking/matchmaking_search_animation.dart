import 'package:flutter/material.dart';

class MatchmakingSearchAnimation extends StatelessWidget {
  final bool isSearching;

  const MatchmakingSearchAnimation({
    super.key,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [
              Color(0xFFC946F7),
              Color(0xFF6B46C1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFC946F7).withOpacity(0.5),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: isSearching
            ? const _PulsingAnimation()
            : const Icon(
                Icons.people_outline,
                size: 60,
                color: Colors.white,
              ),
      ),
    );
  }
}

class _PulsingAnimation extends StatefulWidget {
  const _PulsingAnimation();

  @override
  State<_PulsingAnimation> createState() => __PulsingAnimationState();
}

class __PulsingAnimationState extends State<_PulsingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: const Icon(
        Icons.people_outline,
        size: 60,
        color: Colors.white,
      ),
    );
  }
}
