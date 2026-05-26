enum BattleRole { grammar, listening, vocabulary }

class PlayerSlotData {
  final String? name;
  final BattleRole? role;
  final bool ready;
  final bool isYou;

  const PlayerSlotData({
    required this.name,
    this.role,
    required this.ready,
    this.isYou = false,
  });

  const PlayerSlotData.empty()
    : name = null,
      role = null,
      ready = false,
      isYou = false;
}