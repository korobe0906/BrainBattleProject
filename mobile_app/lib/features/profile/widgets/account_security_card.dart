import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import 'profile_action_button.dart';
import 'profile_glass_card.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SecurityHeader(status: status),
          const SizedBox(height: AppSpacing.lg),
          _SecurityGrid(
            items: [
              _SecurityItem(
                icon: Icons.mail_rounded,
                label: 'Email',
                value: email,
                color: auth.accent,
              ),
              _SecurityItem(
                icon: Icons.admin_panel_settings_rounded,
                label: 'Roles',
                value: roles.isEmpty ? 'learner' : roles.join(', '),
                color: app.info,
              ),
              _SecurityItem(
                icon: Icons.language_rounded,
                label: 'Language',
                value: language ?? 'Not set',
                color: app.success,
              ),
              _SecurityItem(
                icon: Icons.schedule_rounded,
                label: 'Timezone',
                value: timezone ?? 'Not set',
                color: app.warning,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: app.surfacePrimary.withOpacity(0.55),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: app.borderSubtle),
            ),
            child: Row(
              children: [
                Icon(
                  notificationEnabled == true
                      ? Icons.notifications_active_rounded
                      : Icons.notifications_off_rounded,
                  color: notificationEnabled == true
                      ? app.success
                      : app.warning,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    notificationEnabled == true
                        ? 'Notifications are enabled'
                        : 'Notifications are disabled',
                    style: TextStyle(
                      color: app.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
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

class _SecurityHeader extends StatelessWidget {
  const _SecurityHeader({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return Row(
      children: [
        Icon(Icons.verified_user_rounded, color: app.success, size: 30),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account Status',
                style: TextStyle(
                  color: app.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: app.textPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SecurityGrid extends StatelessWidget {
  const _SecurityGrid({required this.items});

  final List<_SecurityItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _SecurityTile(item: items[0])),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _SecurityTile(item: items[1])),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(child: _SecurityTile(item: items[2])),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _SecurityTile(item: items[3])),
          ],
        ),
      ],
    );
  }
}

class _SecurityItem {
  const _SecurityItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
}

class _SecurityTile extends StatelessWidget {
  const _SecurityTile({required this.item});

  final _SecurityItem item;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 92),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: app.surfacePrimary.withOpacity(0.55),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: app.borderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(item.icon, color: item.color, size: 22),
            const SizedBox(height: AppSpacing.sm),
            Text(
              item.label,
              style: TextStyle(
                color: app.textSecondary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: app.textPrimary,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
