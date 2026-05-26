import 'package:flutter/material.dart';

class MatchmakingInfoPanel extends StatelessWidget {
  const MatchmakingInfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00D9FF).withOpacity(0.3),
        ),
        color: const Color(0xFF0F2B3C).withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Matchmaking Info',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: const Color(0xFF00D9FF).withOpacity(0.7),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Finding players with similar rank.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.update,
                size: 16,
                color: const Color(0xFF00D9FF).withOpacity(0.7),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Rank range expands if wait time increases.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.shield_outlined,
                size: 16,
                color: const Color(0xFF00D9FF).withOpacity(0.7),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Current search range: Gold I - Gold III',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
