import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/theme/app_theme.dart';
import '../battle_routes.dart';
import '../models/battle_stage.dart';
import '../widgets/battle_1v1/matchmaking/matchmaking_header.dart';
import '../widgets/battle_1v1/matchmaking/matchmaking_player_card.dart';
import '../widgets/battle_1v1/matchmaking/matchmaking_info_panel.dart';
import '../widgets/battle_1v1/matchmaking/battle_tip_card.dart';
import '../widgets/battle_1v1/matchmaking/matchmaking_search_animation.dart';

class Battle1v1MatchmakingPage extends StatefulWidget {
  final String battleType;
  final bool isHost;
  final String roomCode;

  const Battle1v1MatchmakingPage({
    super.key,
    required this.battleType,
    required this.isHost,
    required this.roomCode,
  });
  static const routeName = BattleRoutes.v1Matchmaking;
  static const stage = BattleStage.matchmaking;

  @override
  State<Battle1v1MatchmakingPage> createState() =>
      _Battle1v1MatchmakingPageState();
}

class _Battle1v1MatchmakingPageState extends State<Battle1v1MatchmakingPage> {
  late Timer _searchTimer;
  int _searchTime = 0;
  bool _isSearching = true;

  @override
  void initState() {
    super.initState();
    _startSearchTimer();
    // TODO: Integrate with actual matchmaking service
    // In production, listen to matchmaking events and navigate when opponent found
  }

  void _startSearchTimer() {
    _searchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _searchTime++;
        });
      }
      // Simulate finding opponent after 5 seconds for demo
      if (_searchTime >= 5 && _isSearching) {
        _foundOpponent();
      }
    });
  }

  void _foundOpponent() {
    if (!mounted) return;
    _searchTimer.cancel();
    setState(() => _isSearching = false);

    // Simulate delay before navigating to lobby
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        BattleRoutes.v1Lobby,
        arguments: {
          'roomCode': widget.roomCode,
          'battleType': widget.battleType,
          'isHost': widget.isHost,
          'opponentName': 'ShadowHunter',
        },
      );
    });
  }

  void _cancelSearch() {
    _searchTimer.cancel();
    Navigator.of(context).pop();
  }

  String _getEstimatedWait() {
    if (_searchTime < 10) return '~10 seconds';
    if (_searchTime < 30) return '~30 seconds';
    if (_searchTime < 60) return '~1 minute';
    return '~${(_searchTime / 60).ceil()} minutes';
  }

  String _battleTypeLabel(String type) {
    switch (type) {
      case 'LISTENING':
        return 'Listening';
      case 'VOCABULARY':
        return 'Vocabulary';
      case 'GRAMMAR':
        return 'Grammar';
      case 'MIXED':
        return 'Mixed';
      default:
        return 'Mode';
    }
  }

  @override
  void dispose() {
    _searchTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _cancelSearch();
        return false;
      },
      child: Scaffold(
        backgroundColor: BBColors.darkBg,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MatchmakingHeader(
                    onCancel: _cancelSearch,
                  ),
                  const SizedBox(height: 32),
                  // Searching animation
                  MatchmakingSearchAnimation(isSearching: _isSearching),
                  const SizedBox(height: 24),
                  // Search status text
                  const Text(
                    'Searching for opponents...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Mode info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mode: ${_battleTypeLabel(widget.battleType)}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        widget.isHost ? 'Waiting: teammates/opponent' : 'Joining private room',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Estimated wait: ${_getEstimatedWait()}',
                    style: const TextStyle(
                      color: Color(0xFF00D9FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Player profile card
                  MatchmakingPlayerCard(battleType: widget.battleType),
                  const SizedBox(height: 20),
                  // Matchmaking info panel
                  const MatchmakingInfoPanel(),
                  const SizedBox(height: 20),
                  // Battle tip
                  const BattleTipCard(),
                  const SizedBox(height: 20),
                  // Search time display
                  Text(
                    'Searching for ${_searchTime} seconds...',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Cancel button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.22),
                        ),
                        backgroundColor: BBColors.darkBg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: _cancelSearch,
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
        ),
      ),
    );
  }
}
