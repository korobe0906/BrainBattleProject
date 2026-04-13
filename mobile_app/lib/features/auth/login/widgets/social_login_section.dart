import 'package:flutter/material.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/theme_extensions.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final app = context.appTokens.colors;

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: app.borderSubtle)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'or continue with',
                style: text.labelMedium?.copyWith(color: app.textSecondary),
              ),
            ),
            Expanded(child: Divider(color: app.borderSubtle)),
          ],
        ),
        const SizedBox(height: 12),
        _SocialButton(
          label: 'Continue with Google',
          icon: Icons.g_mobiledata_rounded,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        _SocialButton(
          label: 'Continue with Facebook',
          icon: Icons.facebook_rounded,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 22),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: app.textPrimary,
          backgroundColor: app.surfacePrimary.withOpacity(0.3),
          side: BorderSide(color: app.borderSubtle),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
      ),
    );
  }
}