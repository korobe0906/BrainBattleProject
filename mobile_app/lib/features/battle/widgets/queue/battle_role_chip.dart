import 'package:flutter/material.dart';

class BattleRoleChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  const BattleRoleChip({
    super.key,
    required this.label,
    required this.icon,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? const Color(0xFFB95CFF)
        : Colors.white.withOpacity(0.14);
    final textColor = selected ? Colors.white : Colors.white70;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: LinearGradient(
              colors: selected
                  ? [
                      const Color(0xFF8F24FF).withOpacity(0.45),
                      const Color(0xFFE14DFF).withOpacity(0.18),
                    ]
                  : [
                      const Color(0xFF252C3E).withOpacity(0.65),
                      const Color(0xFF1B2231).withOpacity(0.45),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: borderColor, width: 1.1),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: const Color(0xFFA54DFF).withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: textColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
