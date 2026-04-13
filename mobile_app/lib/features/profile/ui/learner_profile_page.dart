import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/loading/bb_loading_overlay.dart';
import '../../auth/data/services/user_session.dart';
import '../../auth/login/login_page.dart';

class LearnerProfilePage extends StatefulWidget {
  const LearnerProfilePage({super.key});

  static const routeName = '/learner-profile';

  @override
  State<LearnerProfilePage> createState() => _LearnerProfilePageState();
}

class _LearnerProfilePageState extends State<LearnerProfilePage> {
  bool _loading = false;

  Future<void> _logout() async {
    setState(() => _loading = true);

    await Future.delayed(const Duration(milliseconds: 600));
    await UserSession.instance.clear();

    if (!mounted) return;

    setState(() => _loading = false);

    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginPage.routeName,
      (route) => false,
    );
  }

  Future<void> _simulateLoading() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: app.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: app.backgroundPrimary,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Learner Profile',
          style: text.titleMedium?.copyWith(
            color: app.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: () {
              BrainBattleApp.of(context).toggleTheme();
            },
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: app.textPrimary,
            ),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: _logout,
            icon: Icon(
              Icons.logout_rounded,
              color: app.textPrimary,
            ),
          ),
        ],
      ),
      body: BBLoadingOverlay(
        loading: _loading,
        label: 'Loading profile...',
        child: SafeArea(
          child: SingleChildScrollView(
            padding: AppSpacing.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: auth.cardBackground.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    border: Border.all(color: app.borderSubtle),
                    boxShadow: [
                      BoxShadow(
                        color: auth.heroGlow,
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: auth.accentSoft,
                        child: Icon(
                          Icons.school_rounded,
                          size: 40,
                          color: auth.accent,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Demo Learner',
                        style: text.titleLarge?.copyWith(
                          color: app.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'English learner • Auth preview mode',
                        style: text.bodyMedium?.copyWith(
                          color: app.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                _SectionCard(
                  title: 'Current level',
                  child: Row(
                    children: const [
                      Expanded(
                        child: _InfoTile(
                          icon: Icons.rocket_launch_rounded,
                          label: 'Level',
                          value: 'A2',
                        ),
                      ),
                      SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _InfoTile(
                          icon: Icons.local_fire_department_rounded,
                          label: 'Streak',
                          value: '12 days',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const _SectionCard(
                  title: 'Learning stats',
                  child: Column(
                    children: [
                      _ProgressRow(label: 'Vocabulary', value: 0.72),
                      SizedBox(height: AppSpacing.md),
                      _ProgressRow(label: 'Listening', value: 0.54),
                      SizedBox(height: AppSpacing.md),
                      _ProgressRow(label: 'Grammar', value: 0.81),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _SectionCard(
                  title: 'Quick actions',
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _simulateLoading,
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Simulate loading'),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            BrainBattleApp.of(context).toggleTheme();
                          },
                          icon: Icon(
                            isDark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                          ),
                          label: const Text('Toggle theme'),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _logout,
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text('Logout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: app.surfacePrimary.withOpacity(0.88),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: app.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: text.titleMedium?.copyWith(
              color: app.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: auth.cardBackground.withOpacity(0.78),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: app.borderSubtle),
      ),
      child: Column(
        children: [
          Icon(icon, color: auth.accent, size: 24),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: text.titleMedium?.copyWith(
              color: app.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: text.bodySmall?.copyWith(
              color: app.textSecondary,
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
  });

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

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
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '$percent%',
              style: text.bodySmall?.copyWith(
                color: app.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 10,
            backgroundColor: app.surfaceSecondary,
            valueColor: AlwaysStoppedAnimation<Color>(auth.accent),
          ),
        ),
      ],
    );
  }
}