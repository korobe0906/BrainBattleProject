import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import 'profile_action_button.dart';
import 'profile_glass_card.dart';
import 'profile_info_tile.dart';

class AccountSecurityCard extends StatelessWidget {
  const AccountSecurityCard({
    super.key,
    required this.email,
    required this.status,
    required this.roles,
    required this.timezone,
    required this.language,
    required this.notificationEnabled,
    required this.onRefresh,
    required this.onLogout,
  });

  final String email;
  final String status;
  final List<String> roles;
  final String? timezone;
  final String? language;
  final bool? notificationEnabled;
  final VoidCallback onRefresh;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    return ProfileGlassCard(
      glowColor: auth.accent,
      child: Column(
        children: [
          ProfileInfoTile(
            icon: Icons.mail_rounded,
            label: 'Email',
            value: email,
            color: auth.accent,
          ),
          const SizedBox(height: AppSpacing.md),
          ProfileInfoTile(
            icon: Icons.verified_user_rounded,
            label: 'Account Status',
            value: status,
            color: app.success,
          ),
          const SizedBox(height: AppSpacing.md),
          ProfileInfoTile(
            icon: Icons.admin_panel_settings_rounded,
            label: 'Roles',
            value: roles.isEmpty ? '-' : roles.join(', '),
            color: app.info,
          ),
          const SizedBox(height: AppSpacing.md),
          ProfileInfoTile(
            icon: Icons.settings_rounded,
            label: 'Settings',
            value:
                '${language ?? '-'} · ${timezone ?? '-'} · Notifications ${notificationEnabled == true ? 'on' : 'off'}',
            color: app.warning,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: ProfileActionButton(
                  label: 'Refresh',
                  icon: Icons.refresh_rounded,
                  onTap: onRefresh,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: ProfileActionButton(
                  label: 'Logout',
                  icon: Icons.logout_rounded,
                  danger: true,
                  onTap: onLogout,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}