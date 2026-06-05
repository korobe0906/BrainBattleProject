import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/layout/auth_scaffold.dart';
import '../../auth/data/api/auth_context_api.dart';
import '../../auth/flow/auth_flow_router.dart';
import '../data/learner_profile_api.dart';

class LearningGoalOnboardingPage extends StatefulWidget {
  const LearningGoalOnboardingPage({super.key});

  static const routeName = '/profile/learning-goal';

  @override
  State<LearningGoalOnboardingPage> createState() =>
      _LearningGoalOnboardingPageState();
}

class _LearningGoalOnboardingPageState
    extends State<LearningGoalOnboardingPage> {
  String? _goalType;
  String? _currentLevel;
  String? _targetLevel;
  String _learningPreference = 'Balanced Learning';
  final Set<String> _focusSkills = {};
  bool _loading = false;

  final _goals = const [
    'IELTS Academic',
    'TOEIC',
    'Business English',
    'Daily Communication',
    'English for Travel',
    'English for Work',
  ];

  final _levels = const [
    'Beginner (A1)',
    'Elementary (A2)',
    'Intermediate (B1)',
    'Upper Intermediate (B2)',
    'Advanced (C1)',
  ];

  final _targets = const [
    'IELTS 5.5',
    'IELTS 6.0',
    'IELTS 6.5',
    'IELTS 7.0',
    'IELTS 7.5',
    'TOEIC 650+',
    'TOEIC 800+',
  ];

  final _skills = const [
    'Grammar',
    'Listening',
    'Vocabulary',
    'Reading',
    'Speaking',
    'Writing',
  ];

  bool get _canSubmit =>
      _goalType != null &&
      _currentLevel != null &&
      _targetLevel != null &&
      _focusSkills.isNotEmpty;

  Future<void> _submit() async {
    if (!_canSubmit) return;

    HapticFeedback.selectionClick();
    setState(() => _loading = true);

    try {
      await LearnerProfileApi.instance.updateMe(
        goalType: _goalType!,
        currentLevel: _currentLevel!,
        targetLevel: _targetLevel!,
        nativeLanguage: 'vi',
        targetLanguage: 'en',
        focusSkills: _focusSkills.toList(),
        weakSkills: _focusSkills.toList(),
      );

      await LearnerProfileApi.instance.completeOnboarding();

      final authContext = await AuthContextApi.instance.getMe();

      if (!mounted) return;
      AuthFlowRouter.goByContext(context, authContext);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final text = Theme.of(context).textTheme;

    return AuthScaffold(
      title: 'Learning Goal',
      subtitle: "Let's personalize your learning journey.",
      showLogo: false,
      showBackButton: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StepHeader(
            label: 'Step 1 of 3',
            value: _canSubmit ? 1 : 0.42,
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle('Choose Your Goal'),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _goals.map((goal) {
              return _ChoiceCard(
                label: goal,
                selected: _goalType == goal,
                onTap: () => setState(() => _goalType = goal),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle('Current Level'),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _levels.map((level) {
              return _PillChoice(
                label: level,
                selected: _currentLevel == level,
                onTap: () => setState(() => _currentLevel = level),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle('Target'),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _targets.map((target) {
              return _PillChoice(
                label: target,
                selected: _targetLevel == target,
                onTap: () => setState(() => _targetLevel = target),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle('Priority Skills'),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _skills.map((skill) {
              final selected = _focusSkills.contains(skill);
              return _PillChoice(
                label: skill,
                selected: selected,
                onTap: () {
                  setState(() {
                    selected
                        ? _focusSkills.remove(skill)
                        : _focusSkills.add(skill);
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle('Learning Preference'),
          const SizedBox(height: AppSpacing.md),
          ...[
            'Quick Daily Practice',
            'Deep Learning',
            'Battle Focused',
            'Balanced Learning',
          ].map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _PreferenceTile(
                label: item,
                selected: _learningPreference == item,
                onTap: () => setState(() => _learningPreference = item),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: !_canSubmit || _loading ? null : _submit,
              child: _loading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Generate Learning Path'),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'This saves real learner_profile data to Supabase PostgreSQL through your backend.',
            style: text.bodySmall?.copyWith(color: app.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({
    required this.label,
    required this.value,
  });

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: app.textSecondary)),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 5,
            backgroundColor: app.surfaceSecondary,
            valueColor: AlwaysStoppedAnimation<Color>(auth.accent),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final text = Theme.of(context).textTheme;

    return Text(
      title,
      style: text.titleMedium?.copyWith(
        color: app.textPrimary,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final text = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        width: 166,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: auth.cardBackground.withOpacity(selected ? 0.96 : 0.78),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: selected ? auth.accent : app.borderSubtle,
            width: selected ? 1.4 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: auth.heroGlow,
                    blurRadius: 22,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: text.bodyMedium?.copyWith(
            color: app.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _PillChoice extends StatelessWidget {
  const _PillChoice({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: auth.accentSoft.withOpacity(0.45),
      backgroundColor: app.surfacePrimary,
      labelStyle: TextStyle(
        color: selected ? auth.accent : app.textPrimary,
        fontWeight: FontWeight.w700,
      ),
      side: BorderSide(color: selected ? auth.accent : app.borderSubtle),
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  const _PreferenceTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final text = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: auth.cardBackground.withOpacity(0.82),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: selected ? auth.accent : app.borderSubtle,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: selected ? auth.accent : app.textSecondary,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: text.bodyMedium?.copyWith(
                  color: app.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}