import 'package:flutter/material.dart';

class LobbyActionButton extends StatelessWidget {
  final bool isHost;
  final bool isEnabled;
  final bool isGuestReady;
  final VoidCallback onPressed;

  const LobbyActionButton({
    super.key,
    required this.isHost,
    required this.isEnabled,
    required this.isGuestReady,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final activeGradient = isHost
        ? const [Color(0xFFF57AA7), Color(0xFFF76095)]
        : const [Color(0xFF00D9FF), Color(0xFF6A88FF)];

    final inactiveGradient = [
      const Color(0xFF4A556B).withOpacity(0.4),
      const Color(0xFF2A364B).withOpacity(0.4),
    ];

    final buttonLabel = isHost
        ? 'Start duel'
        : (isGuestReady ? 'Ready ✓' : 'Ready');

    final textColor = isEnabled
        ? (isHost ? const Color(0xFF1A0B1B) : const Color(0xFF08121B))
        : Colors.white.withOpacity(0.5);

    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: LinearGradient(
            colors: isEnabled ? activeGradient : inactiveGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: (isHost
                            ? const Color(0xFFFF7EB6)
                            : const Color(0xFF00D9FF))
                        .withOpacity(0.42),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: isEnabled ? onPressed : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  buttonLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    fontSize: 15.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}