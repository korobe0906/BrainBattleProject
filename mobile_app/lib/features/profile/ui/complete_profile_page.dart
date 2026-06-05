import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/layout/auth_card.dart';
import '../../../core/widgets/layout/auth_scaffold.dart';
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
    return AuthScaffold(
      title: 'Complete Profile',
      subtitle: 'Set up your real BrainBattle learner account.',
      showBackButton: false,
      child: AuthCard(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _username,
                validator: _validateUsername,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _displayName,
                validator: _validateDisplayName,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Display name',
                  prefixIcon: Icon(Icons.badge_rounded),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _bio,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  prefixIcon: Icon(Icons.edit_note_rounded),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _submit,
                  child: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}