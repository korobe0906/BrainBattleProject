import 'package:flutter/material.dart';
import '../../../models/player_slot_data.dart';
import 'role_badge.dart';
import 'status_indicator.dart';

class PlayerSlot extends StatelessWidget {
  final PlayerSlotData data;
  final String Function(BattleRole) roleLabel;
  final IconData Function(BattleRole) roleIcon;
  final Color Function(BattleRole) roleColor;

  const PlayerSlot({
    super.key,
    required this.data,
    required this.roleLabel,
    required this.roleIcon,
    required this.roleColor,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = data.name == null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isEmpty
              ? Colors.white.withOpacity(0.10)
              : (data.isYou
                    ? const Color(0xFFFF7EA8).withOpacity(0.75)
                    : Colors.white.withOpacity(0.14)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: data.isYou
                  ? const LinearGradient(
                      colors: [Color(0xFFF57AA7), Color(0xFFB968FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: data.isYou ? null : const Color(0xFF32364D),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.person_outline_rounded,
              size: 18,
              color: data.isYou ? Colors.white : Colors.white70,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              data.name ?? 'Empty slot',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isEmpty ? Colors.white38 : Colors.white,
                fontSize: 15,
                fontWeight: data.isYou ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          if (!isEmpty && data.role != null) ...[
            const SizedBox(width: 6),
            Flexible(
              child: RoleBadge(
                label: roleLabel(data.role!),
                icon: roleIcon(data.role!),
                color: roleColor(data.role!),
              ),
            ),
            const SizedBox(width: 6),
          ],
          SizedBox(
            width: 48,
            child: StatusIndicator(ready: data.ready, empty: isEmpty),
          ),
        ],
      ),
    );
  }
}