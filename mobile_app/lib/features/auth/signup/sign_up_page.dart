import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/config/app_env.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/neon/neon_button.dart';
import '../../../core/widgets/neon/neon_card.dart';
import '../../../core/widgets/neon/neon_scaffold.dart';
import '../../../core/widgets/neon/neon_text_field.dart';
import '../login/login_page.dart';
import '../verify/verify_email_page.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_neon_intro.dart';
import 'signup_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static const routeName = '/auth/signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  late final SignUpController _vm;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _vm = SignUpController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _vm.dispose();
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'At least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _password.text) return 'Passwords do not match';
    return null;
  }

  Future<void> _submit() async {
    HapticFeedback.selectionClick();
    if (!_formKey.currentState!.validate()) return;

    final email = _email.text.trim();
    final password = _password.text;

    final ok = await _vm.startRegistration(
      email: email,
      password: password,
      emailRedirectTo: AppEnv.authCallbackUrl,
    );

    if (!mounted) return;

    if (ok) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => VerifyEmailPage(email: email),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_vm.errorMessage ?? 'Failed to create account')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return NeonScaffold(
      title: 'Sign Up',
      subtitle: 'Create your learner identity.',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthNeonIntro(
            icon: Icons.person_add_alt_1_rounded,
            title: 'Join BrainBattle',
            subtitle:
                'Create an account to save profile, learning progress and reward history.',
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
                  const SizedBox(height: AppSpacing.md),
                  NeonTextField(
                    controller: _password,
                    label: 'Password',
                    prefixIcon: Icons.password_rounded,
                    obscureText: _obscurePassword,
                    validator: _validatePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: app.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  NeonTextField(
                    controller: _confirmPassword,
                    label: 'Confirm password',
                    prefixIcon: Icons.verified_user_rounded,
                    obscureText: _obscureConfirmPassword,
                    validator: _validateConfirmPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () => _obscureConfirmPassword =
                              !_obscureConfirmPassword,
                        );
                      },
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: app.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ValueListenableBuilder<String?>(
                    valueListenable: _vm.error,
                    builder: (_, message, __) {
                      return AuthErrorBanner(message: message);
                    },
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _vm.loading,
                    builder: (_, loading, __) {
                      return NeonButton(
                        label: 'Create Account',
                        icon: Icons.rocket_launch_rounded,
                        loading: loading,
                        onPressed: loading ? null : _submit,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
              },
              child: const Text('Already have an account? Login'),
            ),
          ),
        ],
      ),
    );
  }
}