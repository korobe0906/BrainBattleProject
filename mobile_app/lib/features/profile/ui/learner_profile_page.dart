import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../core/services/auth_session_service.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/loading/bb_loading_overlay.dart';
import '../../auth/data/api/auth_context_api.dart';
import '../../auth/data/models/auth_me_response.dart';
import '../../auth/login/login_page.dart';

class LearnerProfilePage extends StatefulWidget {
  const LearnerProfilePage({super.key});

  static const routeName = '/learner-profile';

  @override
  State<LearnerProfilePage> createState() => _LearnerProfilePageState();
}

class _LearnerProfilePageState extends State<LearnerProfilePage> {
  bool _loading = true;
  AuthMeResponse? _authContext;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _loading = true);

    try {
      final data = await AuthContextApi.instance.getMe();

      if (!mounted) return;
      setState(() => _authContext = data);
    } catch (_) {
      await AuthSessionService.instance.signOut();

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        LoginPage.routeName,
        (route) => false,
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _logout() async {
    setState(() => _loading = true);

    try {
      await AuthSessionService.instance.signOut();
    } finally {
      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        LoginPage.routeName,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final battle = context.battleTokens.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final data = _authContext;
    final profile = data?.profile;
    final learner = data?.learnerProfile;

    final displayName = data?.displayName ?? 'Learner';
    final email = data?.email ?? profile?.email ?? 'Signed in';
    final username = profile?.username ?? 'username';
    final level = learner?.currentLevel ?? '-';
    final goal = learner?.targetLevel ?? '-';
    final skills = learner?.focusSkills ?? const <String>[];

    return Scaffold(
      backgroundColor: app.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: app.backgroundPrimary,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'PROFILE',
          style: text.titleLarge?.copyWith(
            color: auth.accent,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.6,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadProfile,
            icon: Icon(Icons.refresh_rounded, color: app.textPrimary),
          ),
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: () => BrainBattleApp.of(context).toggleTheme(),
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: app.textPrimary,
            ),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: _logout,
            icon: Icon(Icons.logout_rounded, color: app.textPrimary),
          ),
        ],
      ),
      body: BBLoadingOverlay(
        loading: _loading,
        label: 'Loading real profile...',
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _loadProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroProfileCard(
                    displayName: displayName,
                    username: username,
                    email: email,
                    status: profile?.status ?? '-',
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _BrainPointCard(walletCount: data?.wallets.length ?? 0),
                  const SizedBox(height: AppSpacing.xl),
                  _SectionTitle('ACCOUNT'),
                  const SizedBox(height: AppSpacing.sm),
                  _SectionCard(
                    child: Column(
                      children: [
                        _InfoRow(label: 'Status', value: profile?.status ?? '-'),
                        _InfoRow(
                          label: 'Roles',
                          value: data?.roles.join(', ') ?? '-',
                        ),
                        _InfoRow(
                          label: 'Email verified',
                          value: data?.emailConfirmedAt != null ? 'Yes' : 'No',
                        ),
                        _InfoRow(
                          label: 'Timezone',
                          value: data?.settings?.timezone ?? '-',
                        ),
                        _InfoRow(
                          label: 'Language',
                          value: data?.settings?.language ?? '-',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _SectionTitle('LEARNING PROFILE'),
                  const SizedBox(height: AppSpacing.sm),
                  _SectionCard(
                    child: Column(
                      children: [
                        _InfoRow(label: 'Current level', value: level),
                        _InfoRow(label: 'Goal', value: goal),
                        _InfoRow(
                          label: 'Goal type',
                          value: learner?.goalType ?? '-',
                        ),
                        _InfoRow(
                          label: 'Target language',
                          value: learner?.targetLanguage ?? '-',
                        ),
                        _InfoRow(
                          label: 'Focus skills',
                          value: skills.isEmpty ? '-' : skills.join(', '),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _SectionTitle('SKILL SNAPSHOT'),
                  const SizedBox(height: AppSpacing.sm),
                  _SectionCard(
                    child: Column(
                      children: [
                        _ProgressRow(
                          label: 'Grammar',
                          value: skills.contains('Grammar') ? 0.72 : 0.35,
                          color: auth.accent,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _ProgressRow(
                          label: 'Listening',
                          value: skills.contains('Listening') ? 0.68 : 0.42,
                          color: battle.accent,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _ProgressRow(
                          label: 'Vocabulary',
                          value: skills.contains('Vocabulary') ? 0.70 : 0.38,
                          color: app.info,
                        ),
                      ],
                    ),
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

class _HeroProfileCard extends StatelessWidget {
  const _HeroProfileCard({
    required this.displayName,
    required this.username,
    required this.email,
    required this.status,
  });

  final String displayName;
  final String username;
  final String email;
  final String status;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: auth.cardBackground.withOpacity(0.92),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: auth.accent.withOpacity(0.45)),
        boxShadow: [
          BoxShadow(
            color: auth.heroGlow,
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: auth.accentSoft,
            child: Text(
              displayName.isNotEmpty
                  ? displayName.substring(0, 1).toUpperCase()
                  : 'L',
              style: text.headlineMedium?.copyWith(
                color: app.textPrimary,
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
                  style: text.titleLarge?.copyWith(
                    color: app.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '@$username',
                  style: text.bodyMedium?.copyWith(color: app.textSecondary),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  email,
                  style: text.bodySmall?.copyWith(color: app.textSecondary),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.sm),
                Chip(
                  label: Text(status),
                  visualDensity: VisualDensity.compact,
                  backgroundColor: auth.accentSoft.withOpacity(0.35),
                  labelStyle: TextStyle(
                    color: auth.accent,
                    fontWeight: FontWeight.w800,
                  ),
                  side: BorderSide(color: auth.accent.withOpacity(0.45)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BrainPointCard extends StatelessWidget {
  const _BrainPointCard({
    required this.walletCount,
  });

  final int walletCount;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: app.warning.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: app.warning.withOpacity(0.65)),
      ),
      child: Row(
        children: [
          Icon(Icons.bolt_rounded, color: app.warning, size: 34),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$walletCount wallet connected',
                  style: text.titleMedium?.copyWith(
                    color: app.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Reward and blockchain identity will connect here later.',
                  style: text.bodySmall?.copyWith(color: app.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final auth = context.authTokens.colors;

    return Row(
      children: [
        Expanded(child: Divider(color: auth.accent.withOpacity(0.25))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            title,
            style: TextStyle(
              color: auth.accent,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(child: Divider(color: auth.accent.withOpacity(0.25))),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: app.surfacePrimary.withOpacity(0.88),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: app.borderSubtle),
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: text.bodyMedium?.copyWith(color: app.textSecondary),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: text.bodyMedium?.copyWith(
                color: app.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;

    final percent = (value * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: text.bodyMedium?.copyWith(
                  color: app.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              '$percent%',
              style: text.bodyMedium?.copyWith(
                color: app.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: app.surfaceSecondary,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}