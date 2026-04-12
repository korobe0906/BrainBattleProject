import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../battle_routes.dart';
import '../models/battle_stage.dart';

class Battle3v3MatchmakingPage extends StatefulWidget {
  final String roomCode;
  final bool isHost;

  const Battle3v3MatchmakingPage({
    super.key,
    required this.roomCode,
    required this.isHost,
  });

  static const routeName = BattleRoutes.v3Matchmaking;
  static const stage = BattleStage.matchmaking;

  @override
  State<Battle3v3MatchmakingPage> createState() => _Battle3v3MatchmakingPageState();
}

class _Battle3v3MatchmakingPageState extends State<Battle3v3MatchmakingPage> {
  late Timer _timer;
  int _elapsed = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() => _elapsed++);
      if (_elapsed >= 5) {
        timer.cancel();
        Navigator.of(context).pushReplacementNamed(
          BattleRoutes.v3Lobby,
          arguments: {
            'roomCode': widget.roomCode,
            'isHost': widget.isHost,
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _cancel() {
    _timer.cancel();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final searchingText = widget.isHost
        ? 'Waiting for teammates to join...'
        : 'Finding available team slot...';

    return Scaffold(
      backgroundColor: BBColors.darkBg,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            children: [
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: _cancel,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.08),
                          border: Border.all(color: Colors.white.withOpacity(0.15)),
                        ),
                        child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '3v3 Team Battle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30 / 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              _PulseCircle(elapsed: _elapsed),
              const SizedBox(height: 24),
              Text(
                searchingText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Room: ${widget.roomCode.toUpperCase()} • Team battle',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.65),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF201540), Color(0xFF161431)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: const Color(0xFF00D9FF).withOpacity(0.3)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Matchmaking Info',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20 / 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• 3 players per team',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• Roles must be unique in each team',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• Battle starts after all players are ready',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Searching for $_elapsed seconds...',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.white.withOpacity(0.25)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: _cancel,
                  child: const Text(
                    'Cancel search',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PulseCircle extends StatelessWidget {
  final int elapsed;

  const _PulseCircle({required this.elapsed});

  @override
  Widget build(BuildContext context) {
    final pulse = (elapsed % 2 == 0) ? 1.0 : 1.08;
    return AnimatedScale(
      duration: const Duration(milliseconds: 450),
      scale: pulse,
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFFF57AA7), Color(0xFF8C52FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF57AA7).withOpacity(0.28),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.groups_2_rounded,
          color: Colors.white,
          size: 54,
        ),
      ),
    );
  }
}
