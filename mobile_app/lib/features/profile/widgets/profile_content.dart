import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/loading/bb_loading_overlay.dart';
import '../../auth/data/models/auth_me_response.dart';
import 'account_security_card.dart';
import 'learning_snapshot_card.dart';
import 'profile_hero_card.dart';
import 'profile_section_title.dart';
import 'reward_wallet_card.dart';
import 'skill_focus_card.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
    required this.loading,
    required this.authContext,
    required this.onRefresh,
    required this.onLogout,
  });

  final bool loading;
  final AuthMeResponse? authContext;
  final Future<void> Function() onRefresh;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final data = authContext;
    final profile = data?.profile;
    final learner = data?.learnerProfile;

    return BBLoadingOverlay(
      loading: loading,
      label: 'Loading profile...',
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.2, -0.9),
            radius: 1.15,
            colors: [
              context.authTokens.colors.accent.withOpacity(0.16),
              app.backgroundPrimary,
            ],
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileHeroCard(
                    displayName: data?.displayName ?? 'Learner',
                    username: profile?.username ?? 'username',
                    email: data?.email ?? profile?.email ?? 'Signed in',
                    status: profile?.status ?? '-',
                    roles: data?.roles ?? const [],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  RewardWalletCard(
                    walletCount: data?.wallets.length ?? 0,
                    verifiedEmail: data?.emailConfirmedAt != null,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const ProfileSectionTitle('Learning Snapshot'),
                  const SizedBox(height: AppSpacing.sm),
                  LearningSnapshotCard(
                    currentLevel: learner?.currentLevel ?? 'Not set',
                    goal: learner?.targetLevel ?? 'Not set',
                    targetLanguage: learner?.targetLanguage ?? 'Not set',
                    focusSkills: learner?.focusSkills ?? const [],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const ProfileSectionTitle('Skill Focus'),
                  const SizedBox(height: AppSpacing.sm),
                  SkillFocusCard(
                    focusSkills: learner?.focusSkills ?? const [],
                    weakSkills: learner?.weakSkills ?? const [],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const ProfileSectionTitle('Account & Security'),
                  const SizedBox(height: AppSpacing.sm),
                  AccountSecurityCard(
                    email: data?.email ?? profile?.email ?? 'Signed in',
                    status: profile?.status ?? '-',
                    roles: data?.roles ?? const [],
                    timezone: data?.settings?.timezone,
                    language: data?.settings?.language,
                    notificationEnabled:
                        data?.settings?.notificationEnabled,
                    onRefresh: onRefresh,
                    onLogout: onLogout,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}