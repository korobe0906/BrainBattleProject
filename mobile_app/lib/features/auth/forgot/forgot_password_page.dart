import 'package:flutter/material.dart';

import '../../../core/config/app_env.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/neon/neon_button.dart';
import '../../../core/widgets/neon/neon_card.dart';
import '../../../core/widgets/neon/neon_scaffold.dart';
import '../../../core/widgets/neon/neon_text_field.dart';
import '../data/services/supabase_auth_service.dart';
import '../widgets/auth_neon_intro.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static const routeName = '/auth/forgot-password';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter your email';

    final ok = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    ).hasMatch(text);

    if (!ok) return 'Invalid email';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await SupabaseAuthService.instance.sendPasswordResetEmail(
        email: _email.text.trim(),
        redirectTo: AppEnv.resetPasswordUrl,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reset link sent. Check your email.')),
      );
    } catch (e) {
      if (!mounted) return;

      final message = e.toString().replaceFirst('Exception: ', '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeonScaffold(
      title: 'Forgot Password',
      subtitle: 'Recover your BrainBattle account.',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthNeonIntro(
            icon: Icons.lock_reset_rounded,
            title: 'Reset password',
            subtitle:
                'Enter your email. We will send a secure reset link to your inbox.',
          ),
          const SizedBox(height: AppSpacing.xl),
          NeonCard(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  NeonTextField(
                    controller: _email,
                    label: 'Email',
                    prefixIcon: Icons.mail_rounded,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  NeonButton(
                    label: 'Send Reset Link',
                    icon: Icons.send_rounded,
                    loading: _loading,
                    onPressed: _loading ? null : _submit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}