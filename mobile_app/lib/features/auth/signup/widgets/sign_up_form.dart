import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/layout/auth_card.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.togglePassword,
    required this.toggleConfirmPassword,
    required this.validateEmail,
    required this.validatePassword,
    required this.validateConfirmPassword,
    required this.loadingListenable,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback togglePassword;
  final VoidCallback toggleConfirmPassword;
  final String? Function(String?) validateEmail;
  final String? Function(String?) validatePassword;
  final String? Function(String?) validateConfirmPassword;
  final ValueNotifier<bool> loadingListenable;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 14),
            _AuthTextField(
              label: 'Confirm password',
              controller: confirmPassword,
              obscureText: obscureConfirmPassword,
              validator: validateConfirmPassword,
              suffixIcon: IconButton(
                onPressed: toggleConfirmPassword,
                icon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: app.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 18),
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
                        : const Text('Create account'),
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