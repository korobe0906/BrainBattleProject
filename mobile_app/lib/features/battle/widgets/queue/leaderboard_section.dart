import 'package:flutter/material.dart';

import '../../models/leader.dart';

class LeaderboardSection extends StatelessWidget {
  const LeaderboardSection({super.key});

  List<Leader> get _topPlayers => const [
    Leader(
      rank: 1,
      name: 'ShadowHunter',
      league: 'Platinum I',
      rating: 1820,
      streak: 7,
    ),
    Leader(
      rank: 2,
      name: 'StormBreaker',
      league: 'Gold III',
      rating: 1765,
      streak: 6,
    ),
    Leader(
      rank: 3,
      name: 'NightWolf',
      league: 'Gold II',
      rating: 1710,
      streak: 4,
    ),
    Leader(
      rank: 4,
      name: 'IronFist',
      league: 'Gold I',
      rating: 1690,
      streak: 3,
    ),
    Leader(
      rank: 5,
      name: 'PhoenixRise',
      league: 'Silver III',
      rating: 1650,
      streak: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.emoji_events_rounded,
              color: Color(0xFFFFC107),
              size: 20,
            ),
            SizedBox(width: 6),
            Text(
              'Top Warriors Today',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          itemCount: _topPlayers.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return LeaderboardTile(player: _topPlayers[index]);
          },
        ),
      ],
    );
  }
}

class LeaderboardTile extends StatelessWidget {
  final Leader player;

  const LeaderboardTile({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    final topThree = player.rank <= 3;
    final badgeColor = switch (player.rank) {
      1 => const Color(0xFFFFB703),
      2 => const Color(0xFFBFC9D4),
      3 => const Color(0xFFFF7A00),
      _ => const Color(0xFFE149FF),
    };

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF151C2E),
        border: Border.all(
          color: topThree
              ? badgeColor.withOpacity(0.75)
              : Colors.white.withOpacity(0.07),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: badgeColor.withOpacity(0.2),
            ),
            alignment: Alignment.center,
            child: Text(
              player.rank == 1 ? '🏆' : '#${player.rank}',
              style: TextStyle(
                color: topThree ? badgeColor : Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${player.league} • Rating: ${player.rating}',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: const Color(0xFF6D2B2B).withOpacity(0.35),
              border: Border.all(
                color: const Color(0xFFFF8A00).withOpacity(0.7),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  size: 14,
                  color: Color(0xFFFFA726),
                ),
                const SizedBox(width: 5),
                Text(
                  '${player.streak}',
                  style: const TextStyle(
                    color: Color(0xFFFFC46B),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
