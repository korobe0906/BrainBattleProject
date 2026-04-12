import 'package:flutter/material.dart';

class PlayerSlot extends StatelessWidget {
  final String name;
  final bool isYou;
  final bool waiting;
  final bool isReady;

  const PlayerSlot({
    super.key,
    required this.name,
    this.isYou = false,
    this.waiting = false,
    this.isReady = false,
  });

  @override
  Widget build(BuildContext context) {
    if (waiting) {
      // Waiting for opponent state
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16161F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2B1640).withOpacity(0.6),
              ),
              child: Icon(
                Icons.person,
                color: Colors.white.withOpacity(0.4),
                size: 32,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Waiting...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    }

    final borderColor = isYou
        ? const Color(0xFFFF7EA8).withOpacity(0.65)
        : const Color(0xFF00D9FF).withOpacity(0.45);

    final accent = isYou ? const Color(0xFFFF7EA8) : const Color(0xFF00D9FF);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isYou
              ? const [Color(0xFF2D1B3D), Color(0xFF1A1627)]
              : const [Color(0xFF1A233D), Color(0xFF111A2C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isYou
                    ? const [Color(0xFFF57AA7), Color(0xFFB968FF)]
                    : const [Color(0xFF00D9FF), Color(0xFF8C52FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: accent.withOpacity(0.28),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 36),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              isYou ? 'You' : 'Opponent',
              style: TextStyle(
                color: accent,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isReady
                    ? Icons.check_circle_rounded
                    : Icons.hourglass_bottom_rounded,
                color: isReady ? const Color(0xFF3BFFB0) : Colors.white54,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                isReady ? 'Ready' : 'Not ready',
                style: TextStyle(
                  color: isReady ? const Color(0xFF3BFFB0) : Colors.white60,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
