import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/theme_extensions.dart';
import 'bb_button.dart';
import 'bb_card.dart';

class BattleInviteCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onJoin;
  final VoidCallback? onDetails;

  const BattleInviteCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onJoin,
    this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final battle = context.battleTokens.colors;

    return BBCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  battle.accent,
                  battle.accentSoft,
                  battle.accent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: battle.glow,
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              Icons.sports_martial_arts,
              size: 20,
              color: app.textInverse,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: app.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: app.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    BBButton.primary(
                      'Join Now',
                      onPressed: onJoin,
                      icon: Icons.flash_on,
                    ),
                    BBButton.ghost(
                      'Details',
                      onPressed: onDetails,
                      icon: Icons.info_outline,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}