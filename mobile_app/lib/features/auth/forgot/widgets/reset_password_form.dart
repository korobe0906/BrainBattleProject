import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/layout/auth_card.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    super.key,
    required this.formKey,
    required this.password,
    required this.confirmPassword,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.togglePassword,
    required this.toggleConfirmPassword,
    required this.validatePassword,
    required this.validateConfirmPassword,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback togglePassword;
  final VoidCallback toggleConfirmPassword;
  final String? Function(String?) validatePassword;
  final String? Function(String?) validateConfirmPassword;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return AuthCard(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: password,
              obscureText: obscurePassword,
              validator: validatePassword,
              style: TextStyle(color: app.textPrimary),
              decoration: InputDecoration(
                labelText: 'New password',
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
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: confirmPassword,
              obscureText: obscureConfirmPassword,
              validator: validateConfirmPassword,
              style: TextStyle(color: app.textPrimary),
              decoration: InputDecoration(
                labelText: 'Confirm new password',
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
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text('Update password'),
            ),
          ],
        ),
      ),
    );
  }
}