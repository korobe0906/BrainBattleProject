import 'package:flutter/material.dart';

// theme & tokens
import '../../core/theme/palette.dart';
import '../../core/theme/tokens.dart';

import '../../features/community/battle_invite_card.dart';


class PulsePage extends StatelessWidget {
  const PulsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.transparent,
          title: Row(children: [
            _NeonOrbit(size: 28),
            const SizedBox(width: 10),
            Text('Community', style: BBTypo.title(context)),
          ]),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(BBSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StoryRings(),
                const SizedBox(height: 16),
                Text('Happening now', style: BBTypo.subtitle(context)),
                const SizedBox(height: 8),
                BattleInviteCard(
                  title: 'JLPT N5 – 1v1',
                  subtitle: 'Starts in 10 min • Created by @Hana',
                  onJoin: () {
                    // TODO: navigate to Battle Lobby (separate module later)
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const _MockBattleLobby()));
                  },
                  onDetails: () {},
                ),
                BattleInviteCard(
                  title: 'Hiragana Quick Quiz – 3v3',
                  subtitle: '50 joined • Clan Sakura',
                  onJoin: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const _MockBattleLobby()));
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _StoryRings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chips = [
      'JLPT', 'Hiragana', 'N5', 'DailyChallenge', 'Grammar', 'Vocabulary', 'Pronunciation'
    ];
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (ctx, i) => _TopicRing(label: chips[i]),
      ),
    );
  }
}

class _TopicRing extends StatelessWidget {
  final String label;
  const _TopicRing({required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const SweepGradient(colors: [BBPalette.pink, BBPalette.purple, BBPalette.pink]),
            boxShadow: BBShadows.neon,
          ),
          child: const Center(child: Icon(Icons.tag, size: 18)),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: BBPalette.textDim))
      ],
    );
  }
}

class _NeonOrbit extends StatelessWidget {
  final double size;
  const _NeonOrbit({required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const SweepGradient(colors: [BBPalette.pink, BBPalette.purple, BBPalette.pink]),
        boxShadow: BBShadows.neon,
      ),
      child: const Center(child: Icon(Icons.bubble_chart, size: 14)),
    );
  }
}
class _MockBattleLobby extends StatelessWidget {
  const _MockBattleLobby();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, title: const Text('Battle Lobby')),
      body: const Center(child: Text('Battle module goes here…')),
    );
  }
}

