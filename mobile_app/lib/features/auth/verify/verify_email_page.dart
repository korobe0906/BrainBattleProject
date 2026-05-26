import 'package:flutter/material.dart';

import '../../../core/config/app_env.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/layout/auth_card.dart';
import '../../../core/widgets/layout/auth_scaffold.dart';
import '../login/login_page.dart';
import '../signup/signup_controller.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({
    super.key,
    required this.email,
  });

  static const routeName = '/auth/verify-email';

  final String email;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late final SignUpController _vm;

  @override
  void initState() {
    super.initState();
    _vm = SignUpController();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  Future<void> _resend() async {
    final ok = await _vm.resendOtp(
      email: widget.email,
      emailRedirectTo: AppEnv.authCallbackUrl,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Verification email resent'
              : (_vm.errorMessage ?? 'Failed to resend email'),
        ),
      ),
    );
  }

  void _goToLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginPage.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    return AuthScaffold(
      showLogo: true,
      showBackButton: true,
      onBackPressed: _goToLogin,
      child: AuthCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mark_email_read_rounded,
              size: 72,
              color: auth.accent,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Verify your email',
              textAlign: TextAlign.center,
              style: text.titleLarge?.copyWith(
                color: app.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'We sent a verification link to:',
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(
                color: app.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              widget.email,
              textAlign: TextAlign.center,
              style: text.titleMedium?.copyWith(
                color: app.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _goToLogin,
                child: const Text("I've verified"),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _resend,
                child: const Text('Resend email'),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: _goToLogin,
              child: const Text('Back to login'),
            ),
          ],
        ),
      ),
    );
  }
}