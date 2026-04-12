import 'player_slot_data.dart';

class BattlePlayer {
  final String id;
  final String name;
  final BattleRole? role;
  final bool ready;
  final bool isYou;

  const BattlePlayer({
    required this.id,
    required this.name,
    this.role,
    required this.ready,
    this.isYou = false,
  });

  /// Create a copy with some fields replaced
  BattlePlayer copyWith({
    String? id,
    String? name,
    BattleRole? role,
    bool? ready,
    bool? isYou,
  }) {
    return BattlePlayer(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      ready: ready ?? this.ready,
      isYou: isYou ?? this.isYou,
    );
  }

  /// Convert to PlayerSlotData for widget consumption
  PlayerSlotData toPlayerSlotData() {
    return PlayerSlotData(
      name: name,
      role: role,
      ready: ready,
      isYou: isYou,
    );
  }

  /// Factory for creating an empty slot
  factory BattlePlayer.empty({String? id}) {
    return BattlePlayer(
      id: id ?? 'empty_${DateTime.now().millisecondsSinceEpoch}',
      name: '',
      role: null,
      ready: false,
    );
  }

  bool get isEmpty => name.isEmpty;
}
