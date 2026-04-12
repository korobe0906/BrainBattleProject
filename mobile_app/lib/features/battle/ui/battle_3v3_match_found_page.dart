import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../battle_routes.dart';
import '../models/battle_stage.dart';

class Battle3v3MatchFoundPage extends StatefulWidget {
  final String roomCode;

  const Battle3v3MatchFoundPage({
    super.key,
    required this.roomCode,
  });

  static const routeName = BattleRoutes.v3MatchFound;
  static const stage = BattleStage.matchFound;

  @override
  State<Battle3v3MatchFoundPage> createState() => _Battle3v3MatchFoundPageState();
}

class _Battle3v3MatchFoundPageState extends State<Battle3v3MatchFoundPage> {
  late Timer _timer;
  int _remaining = 3;

  final List<_MatchPlayer> _teamA = const [
    _MatchPlayer(name: 'You', initials: 'YO', role: 'Listening', isYou: true),
    _MatchPlayer(name: 'SkyWalker', initials: 'SK', role: 'Grammar'),
    _MatchPlayer(name: 'NightBlade', initials: 'NI', role: 'Vocabulary'),
  ];

  final List<_MatchPlayer> _teamB = const [
    _MatchPlayer(name: 'ShadowHunter', initials: 'SH', role: 'Listening'),
    _MatchPlayer(name: 'FireStorm', initials: 'FI', role: 'Grammar'),
    _MatchPlayer(name: 'IcePhoenix', initials: 'IC', role: 'Vocabulary'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_remaining <= 1) {
        timer.cancel();
        Navigator.of(context).pushReplacementNamed(BattleRoutes.play);
        return;
      }
      setState(() => _remaining--);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BBColors.darkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFFF7EA8), Color(0xFFB968FF)],
                ).createShader(bounds),
                child: const Text(
                  'MATCH FOUND',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Preparing team battle...',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.65),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _TeamColumn(
                      title: 'Your Team',
                      teamColor: const Color(0xFFFF7EA8),
                      players: _teamA,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _TeamColumn(
                      title: 'Opponent Team',
                      teamColor: const Color(0xFF00D9FF),
                      players: _teamB,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF201540), Color(0xFF161431)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: const Color(0xFF7C3CDB).withOpacity(0.55)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Match Info',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _infoRow('Mode', 'Team Battle'),
                    const SizedBox(height: 10),
                    _infoRow('Questions', '10'),
                    const SizedBox(height: 10),
                    _infoRow('Scoring', 'Accuracy + Speed'),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Battle starting in',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: 108,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF57AA7), Color(0xFFB968FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF7EA8).withOpacity(0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  _remaining <= 1 ? 'GO!' : '$_remaining',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.65),
            fontSize: 15,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _TeamColumn extends StatelessWidget {
  final String title;
  final Color teamColor;
  final List<_MatchPlayer> players;

  const _TeamColumn({
    required this.title,
    required this.teamColor,
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              color: teamColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        for (final player in players) ...[
          _PlayerTile(player: player, accent: teamColor),
          if (player != players.last) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _PlayerTile extends StatelessWidget {
  final _MatchPlayer player;
  final Color accent;

  const _PlayerTile({required this.player, required this.accent});

  @override
  Widget build(BuildContext context) {
    final borderColor = player.isYou
        ? const Color(0xFFFF7EA8).withOpacity(0.8)
        : Colors.white.withOpacity(0.14);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF21193A), Color(0xFF17172B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: player.isYou
                    ? const [Color(0xFFF57AA7), Color(0xFFB968FF)]
                    : const [Color(0xFF00D9FF), Color(0xFF8C52FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              player.initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20 / 1.2,
                    fontWeight: player.isYou ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  player.role,
                  style: TextStyle(
                    color: accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
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

class _MatchPlayer {
  final String name;
  final String initials;
  final String role;
  final bool isYou;

  const _MatchPlayer({
    required this.name,
    required this.initials,
    required this.role,
    this.isYou = false,
  });
}
