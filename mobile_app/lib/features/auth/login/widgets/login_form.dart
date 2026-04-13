import 'package:flutter/material.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/layout/auth_card.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
    required this.obscurePassword,
    required this.togglePassword,
    required this.validateEmail,
    required this.validatePassword,
    required this.errorListenable,
    required this.loadingListenable,
    required this.onForgotPassword,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;
  final bool obscurePassword;
  final VoidCallback togglePassword;
  final String? Function(String?) validateEmail;
  final String? Function(String?) validatePassword;
  final ValueNotifier<String?> errorListenable;
  final ValueNotifier<bool> loadingListenable;
  final VoidCallback onForgotPassword;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;

    return AuthCard(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _AuthTextField(
              label: 'Email',
              controller: email,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            ),
            const SizedBox(height: 14),
            _AuthTextField(
              label: 'Password',
              controller: password,
              obscureText: obscurePassword,
              validator: validatePassword,
              suffixIcon: IconButton(
                onPressed: togglePassword,
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: app.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onForgotPassword,
                child: const Text('Forgot password?'),
              ),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<String?>(
              valueListenable: errorListenable,
              builder: (_, msg, __) {
                if (msg == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    msg,
                    style: text.bodySmall?.copyWith(color: app.error),
                  ),
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: loadingListenable,
              builder: (_, isLoading, __) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : onSubmit,
                    child: isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: app.textInverse,
                            ),
                          )
                        : const Text('Login'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.label,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: app.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon,
      ),
    );
  }
}