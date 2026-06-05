import 'package:flutter/material.dart';

import '../../../core/config/app_env.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/neon/neon_button.dart';
import '../../../core/widgets/neon/neon_card.dart';
import '../../../core/widgets/neon/neon_scaffold.dart';
import '../login/login_page.dart';
import '../signup/signup_controller.dart';
import '../widgets/auth_neon_intro.dart';

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

  void _goLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginPage.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeonScaffold(
      title: 'Verify Email',
      subtitle: 'One last step before entering BrainBattle.',
      showBack: true,
      onBack: _goLogin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthNeonIntro(
            icon: Icons.mark_email_read_rounded,
            title: 'Check your inbox',
            subtitle:
                'We sent a verification link. Confirm your email, then come back and login.',
          ),
          const SizedBox(height: AppSpacing.xl),
          NeonCard(
            child: Column(
              children: [
                Text(
                  widget.email,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: AppSpacing.xl),
                ValueListenableBuilder<bool>(
                  valueListenable: _vm.loading,
                  builder: (_, loading, __) {
                    return NeonButton(
                      label: 'Resend Verification Email',
                      icon: Icons.send_rounded,
                      loading: loading,
                      onPressed: loading ? null : _resend,
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton(
                  onPressed: _goLogin,
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}