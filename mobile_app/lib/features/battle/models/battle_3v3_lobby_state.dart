import 'battle_team.dart';
import 'battle_player.dart';
import 'player_slot_data.dart';

enum RoomStatus { waiting, ready, starting }

class Battle3v3LobbyState {
  final String roomCode;
  final int maxPlayers;
  final BattleTeam myTeam;
  final BattleTeam enemyTeam;
  final String currentUserId;
  final BattleRole? myRole;
  final bool isHost;
  final RoomStatus roomStatus;

  const Battle3v3LobbyState({
    required this.roomCode,
    this.maxPlayers = 6,
    required this.myTeam,
    required this.enemyTeam,
    required this.currentUserId,
    this.myRole,
    required this.isHost,
    this.roomStatus = RoomStatus.waiting,
  });

  /// Get total players connected across both teams
  int get playersConnected => myTeam.connectedCount + enemyTeam.connectedCount;

  /// Check if both teams are complete
  bool get bothTeamsComplete => myTeam.isComplete && enemyTeam.isComplete;

  /// Check if roles are valid (no duplicates within each team, each role used once)
  bool get isRoleValid {
    final myTeamRoles = myTeam.takenRoles;
    final enemyTeamRoles = enemyTeam.takenRoles;
    
    // No duplicates within each team
    if (myTeamRoles.length < myTeam.connectedCount ||
        enemyTeamRoles.length < enemyTeam.connectedCount) {
      return false;
    }
    
    // Each team should have max 3 roles
    return true;
  }

  /// Check if all players in both teams are ready (only if complete)
  bool get allPlayersReady => bothTeamsComplete && myTeam.allReady && enemyTeam.allReady;

  /// Check if battle can start
  bool get canStartBattle => bothTeamsComplete && isRoleValid && allPlayersReady;

  /// Create a copy with some fields replaced
  Battle3v3LobbyState copyWith({
    String? roomCode,
    int? maxPlayers,
    BattleTeam? myTeam,
    BattleTeam? enemyTeam,
    String? currentUserId,
    BattleRole? myRole,
    bool? isHost,
    RoomStatus? roomStatus,
  }) {
    return Battle3v3LobbyState(
      roomCode: roomCode ?? this.roomCode,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      myTeam: myTeam ?? this.myTeam,
      enemyTeam: enemyTeam ?? this.enemyTeam,
      currentUserId: currentUserId ?? this.currentUserId,
      myRole: myRole ?? this.myRole,
      isHost: isHost ?? this.isHost,
      roomStatus: roomStatus ?? this.roomStatus,
    );
  }

  /// Update my role and sync with my team's player
  Battle3v3LobbyState updateMyRole(BattleRole newRole) {
    // Find current user in team and update
    final myPlayerIndex = myTeam.players.indexWhere((p) => p.isYou);
    if (myPlayerIndex < 0) return this;

    final updatedPlayer = myTeam.players[myPlayerIndex].copyWith(role: newRole);
    final updatedTeam = myTeam.updatePlayer(myPlayerIndex, updatedPlayer);

    return copyWith(
      myTeam: updatedTeam,
      myRole: newRole,
    );
  }

  /// Update ready state for current user
  Battle3v3LobbyState toggleMyReady() {
    final myPlayerIndex = myTeam.players.indexWhere((p) => p.isYou);
    if (myPlayerIndex < 0) return this;

    final updatedPlayer =
        myTeam.players[myPlayerIndex].copyWith(ready: !myTeam.players[myPlayerIndex].ready);
    final updatedTeam = myTeam.updatePlayer(myPlayerIndex, updatedPlayer);

    return copyWith(myTeam: updatedTeam);
  }

  /// Check if a role is taken in my team
  bool isRoleTakenInMyTeam(BattleRole role) => myTeam.isRoleTaken(role);

  /// Get my player from team
  BattlePlayer? getMyPlayer() {
    try {
      return myTeam.players.firstWhere((p) => p.isYou);
    } catch (e) {
      return null;
    }
  }

  /// Create initial state with mock data (for testing/development)
  factory Battle3v3LobbyState.mock({
    required String roomCode,
    required String currentUserId,
    required bool isHost,
  }) {
    final myTeam = BattleTeam(
      id: 'team_a',
      name: 'Team A (Your team)',
      players: [
        BattlePlayer(
          id: currentUserId,
          name: 'You',
          role: BattleRole.listening,
          ready: isHost,
          isYou: true,
        ),
        const BattlePlayer(
          id: 'teammate_1',
          name: 'SkyWalker',
          role: BattleRole.grammar,
          ready: false,
        ),
        const BattlePlayer(
          id: 'teammate_2',
          name: 'NightBlade',
          role: BattleRole.vocabulary,
          ready: false,
        ),
      ],
    );

    final enemyTeam = BattleTeam(
      id: 'team_b',
      name: 'Team B',
      players: [
        const BattlePlayer(
          id: 'enemy_1',
          name: 'Enemy 1',
          role: BattleRole.grammar,
          ready: true,
        ),
        const BattlePlayer(
          id: 'enemy_2',
          name: 'Enemy 2',
          role: BattleRole.vocabulary,
          ready: false,
        ),
        const BattlePlayer(
          id: 'enemy_3',
          name: 'Enemy 3',
          role: BattleRole.listening,
          ready: false,
        ),
      ],
    );

    return Battle3v3LobbyState(
      roomCode: roomCode,
      myTeam: myTeam,
      enemyTeam: enemyTeam,
      currentUserId: currentUserId,
      myRole: BattleRole.listening,
      isHost: isHost,
      roomStatus: RoomStatus.waiting,
    );
  }
}
