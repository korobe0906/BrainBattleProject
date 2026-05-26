import 'package:flutter/material.dart';
import '../../../models/player_slot_data.dart';

class RoleSelector extends StatelessWidget {
  final BattleRole selectedRole;
  final Set<BattleRole> takenRoles;
  final ValueChanged<BattleRole> onPickRole;
  final String Function(BattleRole) roleLabel;
  final IconData Function(BattleRole) roleIcon;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.takenRoles,
    required this.onPickRole,
    required this.roleLabel,
    required this.roleIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: BattleRole.values.map((role) {
        final isSelected = role == selectedRole;
        final isTaken = takenRoles.contains(role) && !isSelected;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: role == BattleRole.vocabulary ? 0 : 8,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isTaken ? null : () => onPickRole(role),
                borderRadius: BorderRadius.circular(999),
                child: Ink(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFFF57AA7), Color(0xFFF76095)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected ? null : const Color(0xFF141C2D),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.white.withOpacity(0.16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        roleIcon(role),
                        size: 16,
                        color: isTaken
                            ? Colors.white30
                            : (isSelected ? Colors.white : Colors.white70),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        roleLabel(role),
                        style: TextStyle(
                          color: isTaken
                              ? Colors.white30
                              : (isSelected ? Colors.white : Colors.white70),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}