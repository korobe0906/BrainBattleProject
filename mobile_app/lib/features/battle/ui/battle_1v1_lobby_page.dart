import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../../core/theme/app_theme.dart';
import '../battle_routes.dart';
import '../models/battle_stage.dart';
import '../widgets/battle_1v1/lobby/battle_lobby_header.dart';
import '../widgets/battle_1v1/lobby/battle_mode_panel.dart';
import '../widgets/battle_1v1/lobby/lobby_action_button.dart';
import '../widgets/battle_1v1/lobby/player_slot.dart';
import '../widgets/battle_1v1/lobby/room_code_panel.dart';

class Battle1v1LobbyPage extends StatefulWidget {
  final String roomCode;
  final String battleType;
  final bool isHost;
  final String opponentName;

  const Battle1v1LobbyPage({
    super.key,
    required this.roomCode,
    required this.battleType,
    required this.isHost,
    required this.opponentName,
  });
  static const routeName = BattleRoutes.v1Lobby;
  static const stage = BattleStage.lobby;

  @override
  State<Battle1v1LobbyPage> createState() => _Battle1v1LobbyPageState();
}

class _Battle1v1LobbyPageState extends State<Battle1v1LobbyPage> {
  bool _myReady = false;
  bool _opponentReady = false;
  Timer? _presenceTimer;

  @override
  void initState() {
    super.initState();
    _myReady = widget.isHost;
    _presenceTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _opponentReady = true;
      });
    });
  }

  @override
  void dispose() {
    _presenceTimer?.cancel();
    super.dispose();
  }

  String _battleTypeLabel(String type) {
    switch (type) {
      case 'LISTENING':
        return 'Listening battle';
      case 'VOCABULARY':
        return 'Vocabulary battle';
      case 'GRAMMAR':
        return 'Grammar battle';
      case 'MIXED':
        return 'Mixed (Listening + Vocabulary + Grammar)';
      default:
        return 'Mode set by host';
    }
  }

  Future<void> _copyCode() async {
    await Clipboard.setData(ClipboardData(text: widget.roomCode.toUpperCase()));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Room code copied'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool get _canGoMatchFound => _myReady && _opponentReady;

  void _goMatchFound() {
    Navigator.of(context).pushReplacementNamed(
      BattleRoutes.v1MatchFound,
      arguments: {
        'battleType': widget.battleType,
        'opponentName': widget.opponentName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final actionEnabled = widget.isHost ? _canGoMatchFound : true;

    return Scaffold(
      backgroundColor: BBColors.darkBg,
      appBar: BattleLobbyHeader(
        onClose: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Battle Mode Panel - Top section with visual emphasis
                      const SizedBox(height: 8),
                      BattleModePanel(
                        battleType: widget.battleType,
                        mapBattleTypeLabel: _battleTypeLabel,
                      ),
                      const SizedBox(height: 32),

                      // Central VS Section - Main visual focus
                      const Text(
                        'Players',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: PlayerSlot(
                              name: 'You',
                              isYou: true,
                              isReady: _myReady,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Text(
                                  'VS',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _canGoMatchFound ? 'READY' : 'WAIT',
                                  style: TextStyle(
                                    color: _canGoMatchFound
                                        ? const Color(0xFF3BFFB0)
                                        : Colors.white54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: PlayerSlot(
                              name: widget.opponentName,
                              waiting: widget.opponentName.isEmpty,
                              isReady: _opponentReady,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Room Code Section - Secondary importance
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Room Details',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      RoomCodePanel(
                        roomCode: widget.roomCode,
                        onCopy: _copyCode,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.isHost
                              ? 'Share this code so your opponent can join.'
                              : 'You have successfully joined the duel.',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Action Section
              Column(
                children: [
                  const SizedBox(height: 16),
                  LobbyActionButton(
                    isHost: widget.isHost,
                    isEnabled: actionEnabled,
                    isGuestReady: _myReady,
                    onPressed: () {
                      if (widget.isHost) {
                        if (_canGoMatchFound) {
                          _goMatchFound();
                        }
                        return;
                      }

                      setState(() {
                        _myReady = !_myReady;
                      });

                      if (_canGoMatchFound) {
                        Future.delayed(const Duration(milliseconds: 350), () {
                          if (mounted) _goMatchFound();
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.isHost
                        ? (_canGoMatchFound
                            ? 'All players ready. Start duel now.'
                            : 'Waiting for opponent to be ready...')
                        : (_myReady
                            ? 'Ready locked. Waiting for host...'
                            : 'Tap Ready when you are set.'),
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}