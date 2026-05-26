import 'battle_player.dart';
import 'player_slot_data.dart';

class BattleTeam {
  final String id;
  final String name;
  final List<BattlePlayer> players;

  const BattleTeam({
    required this.id,
    required this.name,
    required this.players,
  });

  /// Get count of connected (non-empty) players
  int get connectedCount => players.where((p) => !p.isEmpty).length;

  /// Check if team is complete (all 3 slots filled with roles)
  bool get isComplete => players.length == 3 && players.every((p) => !p.isEmpty);

  /// Check if all players are ready
  bool get allReady => players.every((p) => p.isEmpty || p.ready);

  /// Get all roles taken in this team
  Set<BattleRole> get takenRoles => {
        for (final player in players)
          if (player.role != null) player.role!,
      };

  /// Check if a role is taken in this team
  bool isRoleTaken(BattleRole role) => takenRoles.contains(role);

  /// Get list of PlayerSlotData for widget consumption
  List<PlayerSlotData> toPlayerSlotDataList() {
    return players.map((p) => p.toPlayerSlotData()).toList();
  }

  /// Create a copy with updated players
  BattleTeam copyWith({
    String? id,
    String? name,
    List<BattlePlayer>? players,
  }) {
    return BattleTeam(
      id: id ?? this.id,
      name: name ?? this.name,
      players: players ?? this.players,
    );
  }

  /// Update a player at a specific index
  BattleTeam updatePlayer(int index, BattlePlayer player) {
    if (index < 0 || index >= players.length) return this;
    final newPlayers = [...players];
    newPlayers[index] = player;
    return copyWith(players: newPlayers);
  }

  /// Factory for creating a team with 3 empty slots
  factory BattleTeam.empty(String id, String name) {
    return BattleTeam(
      id: id,
      name: name,
      players: [
        BattlePlayer.empty(id: '${id}_1'),
        BattlePlayer.empty(id: '${id}_2'),
        BattlePlayer.empty(id: '${id}_3'),
      ],
    );
  }
}
