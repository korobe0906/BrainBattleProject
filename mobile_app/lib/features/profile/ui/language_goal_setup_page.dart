import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/neon/neon_button.dart';
import '../../../core/widgets/neon/neon_card.dart';
import '../../../core/widgets/neon/neon_scaffold.dart';
import '../../../core/widgets/neon/neon_section_title.dart';
import '../data/learner_profile_api.dart';

class LanguageGoalSetupPage extends StatefulWidget {
  const LanguageGoalSetupPage({
    super.key,
    this.embedded = false,
  });

  static const routeName = '/profile/language-goal';

  final bool embedded;

  @override
  State<LanguageGoalSetupPage> createState() => _LanguageGoalSetupPageState();
}

class _LanguageGoalSetupPageState extends State<LanguageGoalSetupPage> {
  String? _targetLanguage;
  String? _goalType;
  String? _currentLevel;
  String? _targetLevel;
  final Set<String> _skills = {};
  String _preference = 'Balanced Learning';
  bool _loading = false;

  final _languages = const [
    'English',
    'Japanese',
    'Korean',
    'Chinese',
    'French',
    'Spanish',
  ];

  final _goals = const [
    'Daily Communication',
    'Work & Career',
    'Travel',
    'Academic Study',
    'Exam Preparation',
    'Battle Practice',
  ];

  final _levels = const [
    'Beginner',
    'Elementary',
    'Intermediate',
    'Upper Intermediate',
    'Advanced',
  ];

  final _targets = const [
    'Basic Conversation',
    'Confident Communication',
    'Academic Fluency',
    'Workplace Fluency',
    'Exam Ready',
    'Battle Ready',
  ];

  final _skillOptions = const [
    'Vocabulary',
    'Grammar',
    'Listening',
    'Speaking',
    'Reading',
    'Writing',
    'Pronunciation',
    'Characters / Kanji',
    'Conversation',
  ];

  bool get _canSave =>
      _targetLanguage != null &&
      _goalType != null &&
      _currentLevel != null &&
      _targetLevel != null &&
      _skills.isNotEmpty;

  Future<void> _save() async {
    if (!_canSave) return;

    HapticFeedback.selectionClick();
    setState(() => _loading = true);

    try {
      await LearnerProfileApi.instance.updateMe(
        goalType: _goalType!,
        currentLevel: _currentLevel!,
        targetLevel: _targetLevel!,
        nativeLanguage: 'vi',
        targetLanguage: _targetLanguage!,
        focusSkills: _skills.toList(),
        weakSkills: _skills.toList(),
      );

      await LearnerProfileApi.instance.completeOnboarding();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Learning goal saved')),
      );

      if (!widget.embedded) Navigator.of(context).maybePop();
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
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        NeonCard(
          accent: context.battleTokens.colors.accent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personalize your language journey',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Optional setup. You can start learning first and adjust this later.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.appTokens.colors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        const NeonSectionTitle('Target Language'),
        const SizedBox(height: AppSpacing.md),
        _OptionWrap(
          values: _languages,
          selectedValues: {_targetLanguage},
          onTap: (v) => setState(() => _targetLanguage = v),
        ),
        const SizedBox(height: AppSpacing.xl),
        const NeonSectionTitle('Learning Goal'),
        const SizedBox(height: AppSpacing.md),
        _OptionWrap(
          values: _goals,
          selectedValues: {_goalType},
          onTap: (v) => setState(() => _goalType = v),
        ),
        const SizedBox(height: AppSpacing.xl),
        const NeonSectionTitle('Current Level'),
        const SizedBox(height: AppSpacing.md),
        _OptionWrap(
          values: _levels,
          selectedValues: {_currentLevel},
          onTap: (v) => setState(() => _currentLevel = v),
        ),
        const SizedBox(height: AppSpacing.xl),
        const NeonSectionTitle('Target'),
        const SizedBox(height: AppSpacing.md),
        _OptionWrap(
          values: _targets,
          selectedValues: {_targetLevel},
          onTap: (v) => setState(() => _targetLevel = v),
        ),
        const SizedBox(height: AppSpacing.xl),
        const NeonSectionTitle('Priority Skills'),
        const SizedBox(height: AppSpacing.md),
        _OptionWrap(
          values: _skillOptions,
          selectedValues: _skills,
          multi: true,
          onTap: (v) {
            setState(() {
              _skills.contains(v) ? _skills.remove(v) : _skills.add(v);
            });
          },
        ),
        const SizedBox(height: AppSpacing.xl),
        const NeonSectionTitle('Learning Style'),
        const SizedBox(height: AppSpacing.md),
        ...[
          'Quick Daily Practice',
          'Deep Learning',
          'Battle Focused',
          'Balanced Learning',
        ].map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _PreferenceTile(
              label: item,
              selected: _preference == item,
              onTap: () => setState(() => _preference = item),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        NeonButton(
          label: 'Save Learning Goal',
          icon: Icons.auto_awesome_rounded,
          loading: _loading,
          onPressed: _canSave ? _save : null,
        ),
      ],
    );

    if (widget.embedded) {
      return NeonScaffold(
        title: 'Learn',
        subtitle: 'Set your language goal anytime.',
        child: content,
      );
    }

    return NeonScaffold(
      title: 'Learning Goal',
      subtitle: 'Optional personalization',
      showBack: true,
      child: content,
    );
  }
}

class _OptionWrap extends StatelessWidget {
  const _OptionWrap({
    required this.values,
    required this.selectedValues,
    required this.onTap,
    this.multi = false,
  });

  final List<String> values;
  final Set<String?> selectedValues;
  final ValueChanged<String> onTap;
  final bool multi;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: values.map((value) {
        final selected = selectedValues.contains(value);
        return _NeonChip(
          label: value,
          selected: selected,
          onTap: () => onTap(value),
        );
      }).toList(),
    );
  }
}

class _NeonChip extends StatelessWidget {
  const _NeonChip({
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

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          color: selected
              ? auth.accent.withOpacity(0.24)
              : app.surfacePrimary.withOpacity(0.74),
          border: Border.all(
            color: selected ? auth.accent : app.borderSubtle,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: auth.accent.withOpacity(0.24),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? auth.accent : app.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
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

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.xl),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: app.surfacePrimary.withOpacity(0.78),
          borderRadius: BorderRadius.circular(AppRadius.xl),
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
                style: TextStyle(
                  color: app.textPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}