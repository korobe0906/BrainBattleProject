import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/widgets/layout/auth_scaffold.dart';
import '../data/services/supabase_auth_service.dart';
import '../login/login_page.dart';
import 'widgets/reset_password_form.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    required this.email,
  });

  static const routeName = '/auth/reset-password';

  final String email;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _loading = false;

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Please enter your new password';
    if (v.length < 6) return 'At least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String? v) {
    if (v == null || v.isEmpty) return 'Please confirm your password';
    if (v != _password.text) return 'Passwords do not match';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await SupabaseAuthService.instance.updatePassword(
        newPassword: _password.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );

      Navigator.of(context).pushNamedAndRemoveUntil(
        LoginPage.routeName,
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      final message = e.toString().replaceFirst('Exception: ', '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentEmail = Supabase.instance.client.auth.currentUser?.email;
    final subtitle = widget.email.isNotEmpty ? widget.email : (currentEmail ?? '');

    return AuthScaffold(
      title: 'Create a new password',
      subtitle: subtitle,
      showBackButton: true,
      child: ResetPasswordForm(
        formKey: _formKey,
        password: _password,
        confirmPassword: _confirmPassword,
        obscurePassword: _obscurePassword,
        obscureConfirmPassword: _obscureConfirmPassword,
        togglePassword: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
        toggleConfirmPassword: () {
          setState(() {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          });
        },
        validatePassword: _validatePassword,
        validateConfirmPassword: _validateConfirmPassword,
        onSubmit: _loading ? () {} : _submit,
      ),
    );
  }
}