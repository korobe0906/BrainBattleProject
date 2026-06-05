import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../utils/profile_ui_helpers.dart';
import 'profile_badge.dart';
import 'profile_glass_card.dart';

class ProfileHeroCard extends StatelessWidget {
  const ProfileHeroCard({
    super.key,
    required this.displayName,
    required this.username,
    required this.email,
    required this.status,
    required this.roles,
  });

  final String displayName;
  final String username;
  final String email;
  final String status;
  final List<String> roles;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final battle = context.battleTokens.colors;
    final text = Theme.of(context).textTheme;

    final roleText = roles.isEmpty ? 'learner' : roles.join(' · ');

    return ProfileGlassCard(
      glowColor: auth.accent,
      child: Row(
        children: [
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  auth.brandPrimary,
                  auth.brandSecondary,
                  battle.accent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: auth.accent.withOpacity(0.30),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              profileInitials(displayName),
              style: text.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.titleLarge?.copyWith(
                    color: app.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '@$username',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodyMedium?.copyWith(
                    color: app.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodySmall?.copyWith(
                    color: app.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ProfileBadge(
                      icon: Icons.verified_rounded,
                      label: status,
                      color: app.success,
                    ),
                    ProfileBadge(
                      icon: Icons.shield_rounded,
                      label: roleText,
                      color: auth.accent,
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