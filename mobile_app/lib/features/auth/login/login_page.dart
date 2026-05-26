import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/widgets/layout/auth_scaffold.dart';
import '../../profile/ui/learner_profile_page.dart';
import '../forgot/forgot_password_page.dart';
import '../signup/sign_up_page.dart';
import 'login_controller.dart';
import 'widgets/login_form.dart';
import 'widgets/social_login_section.dart';

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

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your email';
    final ok = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    ).hasMatch(v.trim());
    if (!ok) return 'Invalid email';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Please enter your password';
    if (v.length < 6) return 'At least 6 characters';
    return null;
  }

  Future<void> _submit() async {
    HapticFeedback.selectionClick();
    if (!_formKey.currentState!.validate()) return;

    final ok = await _vm.login(_email.text.trim(), _password.text);
    if (!mounted) return;

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );
      Navigator.of(context).pushReplacementNamed(
        LearnerProfilePage.routeName,
      );
      return;
    }

    final err = _vm.error.value ?? 'Login failed';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(err)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome back',
      subtitle: 'Sign in to continue learning.',
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LoginForm(
            formKey: _formKey,
            email: _email,
            password: _password,
            obscurePassword: _obscurePassword,
            togglePassword: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            validateEmail: _validateEmail,
            validatePassword: _validatePassword,
            errorListenable: _vm.error,
            loadingListenable: _vm.loading,
            onForgotPassword: () {
              Navigator.pushNamed(context, ForgotPasswordPage.routeName);
            },
            onSubmit: _submit,
          ),
          const SizedBox(height: 20),
          const SocialLoginSection(),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, SignUpPage.routeName);
              },
              child: const Text("Don't have an account? Sign up"),
            ),
          ),
        ],
      ),
    );
  }
}