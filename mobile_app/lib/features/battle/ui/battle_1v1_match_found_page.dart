import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../battle_routes.dart';
import '../models/battle_stage.dart';

class Battle1v1MatchFoundPage extends StatefulWidget {
  final String battleType;
  final String opponentName;

  const Battle1v1MatchFoundPage({
    super.key,
    required this.battleType,
    required this.opponentName,
  });

  static const routeName = BattleRoutes.v1MatchFound;
  static const stage = BattleStage.matchFound;

  @override
  State<Battle1v1MatchFoundPage> createState() => _Battle1v1MatchFoundPageState();
}

class _Battle1v1MatchFoundPageState extends State<Battle1v1MatchFoundPage> {
  late Timer _countdownTimer;
  int _remaining = 3;

  @override
  void initState() {
    super.initState();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    _countdownTimer.cancel();
    super.dispose();
  }

  String _battleTypeLabel(String type) {
    switch (type) {
      case 'LISTENING':
        return 'Listening';
      case 'VOCABULARY':
        return 'Vocabulary';
      case 'GRAMMAR':
        return 'Grammar';
      default:
        return 'Mixed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BBColors.darkBg,
      body: SafeArea(
        child: Padding(
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
                'Preparing battle...',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.65),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _PlayerCard(
                      name: 'You',
                      isYou: true,
                      modeLabel: _battleTypeLabel(widget.battleType),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _PlayerCard(
                      name: widget.opponentName,
                      isYou: false,
                      modeLabel: _battleTypeLabel(widget.battleType),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _MatchInfoPanel(modeLabel: _battleTypeLabel(widget.battleType)),
              const Spacer(),
              Text(
                'Battle starts in',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 14),
              _GoButton(remaining: _remaining),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final String name;
  final bool isYou;
  final String modeLabel;

  const _PlayerCard({
    required this.name,
    required this.isYou,
    required this.modeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isYou ? const Color(0xFFFF7EA8) : const Color(0xFF00D9FF);
    final glowColor = isYou ? const Color(0xFFFF7EA8) : const Color(0xFF00D9FF);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF2B1640), Color(0xFF1A132B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: borderColor.withOpacity(0.8)),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.2),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
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
            ),
            alignment: Alignment.center,
            child: Text(
              name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: borderColor.withOpacity(0.15),
              border: Border.all(color: borderColor.withOpacity(0.6)),
            ),
            child: Text(
              modeLabel,
              style: TextStyle(
                color: borderColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchInfoPanel extends StatelessWidget {
  final String modeLabel;

  const _MatchInfoPanel({required this.modeLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _InfoRow(label: 'Mode:', value: modeLabel),
          const SizedBox(height: 12),
          const _InfoRow(label: 'Questions:', value: '10'),
          const SizedBox(height: 12),
          const _InfoRow(label: 'Scoring:', value: 'Accuracy + Speed'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
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
            fontSize: 24 / 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _GoButton extends StatelessWidget {
  final int remaining;

  const _GoButton({required this.remaining});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        remaining <= 1 ? 'GO!' : '$remaining',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 38 / 2,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
