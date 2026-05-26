import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/layout/auth_card.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
    required this.formKey,
    required this.email,
    required this.validateEmail,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final String? Function(String?) validateEmail;
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
              controller: email,
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: app.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text('Send reset link'),
            ),
          ],
        ),
      ),
    );
  }
}