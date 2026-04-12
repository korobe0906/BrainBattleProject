import 'package:flutter/material.dart';

class BattleModePanel extends StatelessWidget {
  final String battleType;
  final String Function(String battleType) mapBattleTypeLabel;

  const BattleModePanel({
    super.key,
    required this.battleType,
    required this.mapBattleTypeLabel,
  });

  Color _getColorForMode(String battleType) {
    switch (battleType) {
      case 'LISTENING':
        return const Color(0xFF00D9FF);
      case 'VOCABULARY':
        return const Color(0xFF4CA3FF);
      case 'GRAMMAR':
        return const Color(0xFF9B62E9);
      case 'MIXED':
        return const Color(0xFFFF78A8);
      default:
        return Colors.white70;
    }
  }

  IconData _getIconForMode(String battleType) {
    switch (battleType) {
      case 'LISTENING':
        return Icons.headphones_rounded;
      case 'VOCABULARY':
        return Icons.menu_book_rounded;
      case 'GRAMMAR':
        return Icons.spellcheck_rounded;
      case 'MIXED':
        return Icons.auto_awesome_rounded;
      default:
        return Icons.bolt_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final modeColor = _getColorForMode(battleType);
    final modeIcon = _getIconForMode(battleType);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1632), Color(0xFF0F0B1B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: modeColor.withOpacity(0.3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: modeColor.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: modeColor.withOpacity(0.18),
                ),
                child: Icon(
                  modeIcon,
                  color: modeColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mapBattleTypeLabel(battleType),
                      style: TextStyle(
                        color: modeColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '10 questions • ~2 minutes',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: modeColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: modeColor.withOpacity(0.7),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Scoring and timing handled automatically. Battle starts when both ready.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}