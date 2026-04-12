import 'package:flutter/material.dart';
import '../../../models/player_slot_data.dart';
import 'player_slot.dart';

class TeamPanel extends StatelessWidget {
  final String title;
  final List<PlayerSlotData> slots;
  final String Function(BattleRole) roleLabel;
  final IconData Function(BattleRole) roleIcon;
  final Color Function(BattleRole) roleColor;

  const TeamPanel({
    super.key,
    required this.title,
    required this.slots,
    required this.roleLabel,
    required this.roleIcon,
    required this.roleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1630), Color(0xFF141428)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFF7C3CDB).withOpacity(0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          for (final slot in slots) ...[
            PlayerSlot(
              data: slot,
              roleLabel: roleLabel,
              roleIcon: roleIcon,
              roleColor: roleColor,
            ),
            if (slot != slots.last) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}