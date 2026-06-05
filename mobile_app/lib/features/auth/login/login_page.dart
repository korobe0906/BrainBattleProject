import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/neon/neon_button.dart';
import '../../../core/widgets/neon/neon_card.dart';
import '../../../core/widgets/neon/neon_scaffold.dart';
import '../../../core/widgets/neon/neon_text_field.dart';
import '../flow/auth_flow_router.dart';
import '../forgot/forgot_password_page.dart';
import '../signup/sign_up_page.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_neon_intro.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/auth/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  late final LoginController _vm;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _vm = LoginController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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

  Future<void> _submit() async {
    HapticFeedback.selectionClick();
    if (!_formKey.currentState!.validate()) return;

    final ok = await _vm.login(_email.text.trim(), _password.text);
    if (!mounted) return;

    if (ok && _vm.lastAuthMe != null) {
      AuthFlowRouter.goByContext(context, _vm.lastAuthMe!);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_vm.error.value ?? 'Login failed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return NeonScaffold(
      title: 'Login',
      subtitle: 'Continue your BrainBattle journey.',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthNeonIntro(
            icon: Icons.lock_open_rounded,
            title: 'Welcome back',
            subtitle: 'Sign in to sync your profile, learning path and rewards.',
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
                  const SizedBox(height: AppSpacing.sm),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          ForgotPasswordPage.routeName,
                        );
                      },
                      child: const Text('Forgot password?'),
                    ),
                  ),
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
                        label: 'Login',
                        icon: Icons.arrow_forward_rounded,
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
                Navigator.of(context).pushReplacementNamed(
                  SignUpPage.routeName,
                );
              },
              child: const Text("Don't have an account? Create one"),
            ),
          ),
        ],
      ),
    );
  }
}