import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/neon/neon_button.dart';
import '../../../core/widgets/neon/neon_card.dart';
import '../../../core/widgets/neon/neon_scaffold.dart';
import '../../../core/widgets/neon/neon_text_field.dart';
import '../../auth/data/api/auth_context_api.dart';
import '../../auth/data/models/auth_me_response.dart';
import '../../auth/flow/auth_flow_router.dart';
import '../data/profile_api.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  static const routeName = '/profile/complete';

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _displayName = TextEditingController();
  final _bio = TextEditingController();

  bool _loading = false;
  bool _filledInitialData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_filledInitialData) return;
    _filledInitialData = true;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is AuthMeResponse) {
      _username.text = args.profile?.username ?? '';
      _displayName.text = args.profile?.displayName ?? '';
      _bio.text = args.profile?.bio ?? '';
    }
  }

  @override
  void dispose() {
    _username.dispose();
    _displayName.dispose();
    _bio.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter username';
    if (text.length < 3) return 'At least 3 characters';
    final ok = RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(text);
    if (!ok) return 'Only letters, numbers, dots and underscores';
    return null;
  }

  String? _validateDisplayName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter display name';
    if (text.length < 2) return 'At least 2 characters';
    return null;
  }

  Future<void> _submit() async {
    HapticFeedback.selectionClick();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await ProfileApi.instance.updateMe(
        username: _username.text.trim(),
        displayName: _displayName.text.trim(),
        bio: _bio.text.trim().isEmpty ? null : _bio.text.trim(),
      );

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
    return NeonScaffold(
      title: 'Profile Setup',
      subtitle: 'Create your BrainBattle identity.',
      showBack: false,
      child: NeonCard(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              NeonTextField(
                controller: _username,
                label: 'Username',
                prefixIcon: Icons.alternate_email_rounded,
                validator: _validateUsername,
              ),
              const SizedBox(height: AppSpacing.md),
              NeonTextField(
                controller: _displayName,
                label: 'Display name',
                prefixIcon: Icons.badge_rounded,
                validator: _validateDisplayName,
              ),
              const SizedBox(height: AppSpacing.md),
              NeonTextField(
                controller: _bio,
                label: 'Bio',
                prefixIcon: Icons.auto_awesome_rounded,
                maxLines: 3,
              ),
              const SizedBox(height: AppSpacing.xl),
              NeonButton(
                label: 'Enter BrainBattle',
                icon: Icons.rocket_launch_rounded,
                loading: _loading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}