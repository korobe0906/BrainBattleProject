import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../../core/theme/app_theme.dart';
import '../battle_routes.dart';
import '../models/player_slot_data.dart';
import '../models/battle_3v3_lobby_state.dart';
import '../models/battle_stage.dart';
import '../widgets/battle_3v3/lobby/lobby_actions.dart';
import '../widgets/battle_3v3/lobby/lobby_header.dart';
import '../widgets/battle_3v3/lobby/role_selector.dart';
import '../widgets/battle_3v3/lobby/room_code_card.dart';
import '../widgets/battle_3v3/lobby/team_panel.dart';

class Battle3v3LobbyPage extends StatefulWidget {
  final String roomCode;
  final bool isHost;

  const Battle3v3LobbyPage({
    super.key,
    required this.roomCode,
    required this.isHost,
  });
  static const routeName = BattleRoutes.v3Lobby;
  static const stage = BattleStage.lobby;

  @override
  State<Battle3v3LobbyPage> createState() => _Battle3v3LobbyPageState();
}

class _Battle3v3LobbyPageState extends State<Battle3v3LobbyPage> {
  late Battle3v3LobbyState _state;
  Timer? _syncTimer;

  @override
  void initState() {
    super.initState();
    // Initialize state with mock data - structure ready for API integration
    _state = Battle3v3LobbyState.mock(
      roomCode: widget.roomCode,
      currentUserId: 'user_current', // TODO: Get from auth service
      isHost: widget.isHost,
    );

    _syncTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _state = _state.copyWith(
          myTeam: _state.myTeam.copyWith(
            players: _state.myTeam.players.map((player) {
              if (player.isYou) return player;
              return player.copyWith(ready: true);
            }).toList(),
          ),
          enemyTeam: _state.enemyTeam.copyWith(
            players: _state.enemyTeam.players
                .map((player) => player.copyWith(ready: true))
                .toList(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    super.dispose();
  }

  void _pickRole(BattleRole role) {
    // Prevent selecting a role already taken by another player in my team
    if (_state.isRoleTakenInMyTeam(role)) {
      // If already selected by current user, allow switch
      if (_state.myRole != role) return;
    }

    setState(() {
      _state = _state.updateMyRole(role);
    });
  }

  void _toggleReady() {
    setState(() {
      _state = _state.toggleMyReady();
    });
  }

  String roleLabel(BattleRole role) {
    switch (role) {
      case BattleRole.grammar:
        return 'Grammar';
      case BattleRole.listening:
        return 'Listening';
      case BattleRole.vocabulary:
        return 'Vocabulary';
    }
  }

  IconData roleIcon(BattleRole role) {
    switch (role) {
      case BattleRole.grammar:
        return Icons.spellcheck_rounded;
      case BattleRole.listening:
        return Icons.headphones_rounded;
      case BattleRole.vocabulary:
        return Icons.menu_book_rounded;
    }
  }

  Color roleColor(BattleRole role) {
    switch (role) {
      case BattleRole.listening:
        return const Color(0xFF00D9FF);
      case BattleRole.grammar:
        return const Color(0xFF9B62E9);
      case BattleRole.vocabulary:
        return const Color(0xFF4CA3FF);
    }
  }

  Future<void> _copyCode() async {
    await Clipboard.setData(ClipboardData(text: _state.roomCode.toUpperCase()));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Room code copied'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Generate player slots dynamically from state
    final myTeamSlots = _state.myTeam.toPlayerSlotDataList();
    final enemySlots = _state.enemyTeam.toPlayerSlotDataList();

    // Get roles taken in my team
    final takenRoles = _state.myTeam.takenRoles;

    // Get my current role
    final myRole = _state.myRole ?? BattleRole.listening;

    // Determine action button state
    final isStartEnabled = widget.isHost && _state.canStartBattle;

    return Scaffold(
      backgroundColor: BBColors.darkBg,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LobbyHeader(onBack: () => Navigator.of(context).pop()),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoomCodeCard(
                        roomCode: _state.roomCode,
                        onCopy: _copyCode,
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          'Players connected: ${_state.playersConnected} / ${_state.maxPlayers}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 30 / 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Center(
                        child: Text(
                          'Waiting for teammates...',
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Center(
                        child: Text(
                          'Each team has 3 players and each role must be unique.',
                          style: TextStyle(color: Colors.white54, fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 16),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isSmallScreen = constraints.maxWidth < 580;

                          if (isSmallScreen) {
                            // Stack vertically on small screens
                            return Column(
                              children: [
                                TeamPanel(
                                  title: _state.myTeam.name,
                                  slots: myTeamSlots,
                                  roleLabel: roleLabel,
                                  roleIcon: roleIcon,
                                  roleColor: roleColor,
                                ),
                                const SizedBox(height: 12),
                                TeamPanel(
                                  title: _state.enemyTeam.name,
                                  slots: enemySlots,
                                  roleLabel: roleLabel,
                                  roleIcon: roleIcon,
                                  roleColor: roleColor,
                                ),
                              ],
                            );
                          } else {
                            // Side-by-side on larger screens
                            return Row(
                              children: [
                                Expanded(
                                  child: TeamPanel(
                                    title: _state.myTeam.name,
                                    slots: myTeamSlots,
                                    roleLabel: roleLabel,
                                    roleIcon: roleIcon,
                                    roleColor: roleColor,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TeamPanel(
                                    title: _state.enemyTeam.name,
                                    slots: enemySlots,
                                    roleLabel: roleLabel,
                                    roleIcon: roleIcon,
                                    roleColor: roleColor,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 15),
                          children: [
                            const TextSpan(
                              text: 'Your role: ',
                              style: TextStyle(color: Colors.white70),
                            ),
                            TextSpan(
                              text: roleLabel(myRole),
                              style: const TextStyle(
                                color: Color(0xFFFF78A8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RoleSelector(
                        selectedRole: myRole,
                        takenRoles: takenRoles,
                        onPickRole: _pickRole,
                        roleLabel: roleLabel,
                        roleIcon: roleIcon,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              LobbyActions(
                startLabel: widget.isHost ? 'Start battle' : 'Ready',
                onShare: _copyCode,
                isStartEnabled: isStartEnabled,
                onStart: () {
                  if (widget.isHost && isStartEnabled) {
                    Navigator.of(context).pushReplacementNamed(
                      BattleRoutes.v3MatchFound,
                      arguments: {'roomCode': _state.roomCode},
                    );
                  } else if (!widget.isHost) {
                    _toggleReady();
                  }
                },
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Battle starts when all players are ready.',
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}