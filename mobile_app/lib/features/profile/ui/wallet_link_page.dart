import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/neon/neon_button.dart';
import '../../../core/widgets/neon/neon_card.dart';
import '../../../core/widgets/neon/neon_scaffold.dart';

class WalletLinkPage extends StatelessWidget {
  const WalletLinkPage({super.key});

  static const routeName = '/profile/wallet-link';

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;
    final battle = context.battleTokens.colors;

    return NeonScaffold(
      title: 'Connect Wallet',
      subtitle: 'Prepare your blockchain reward identity.',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NeonCard(
            accent: app.warning,
            child: Column(
              children: [
                Icon(Icons.account_balance_wallet_rounded,
                    size: 68, color: app.warning),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Wallet Linking',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: app.textPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'This flow will connect user identity, reward ledger, and on-chain verification. Backend wallet endpoint is already prepared for the next blockchain slice.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: app.textSecondary,
                        height: 1.45,
                      ),
                ),
                const SizedBox(height: AppSpacing.xl),
                NeonButton(
                  label: 'Connect MetaMask / Wallet',
                  icon: Icons.link_rounded,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Wallet linking will be connected in blockchain phase.',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          NeonCard(
            accent: battle.accent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WalletStep(
                  icon: Icons.verified_user_rounded,
                  title: 'Verify learner identity',
                  color: auth.accent,
                ),
                const SizedBox(height: AppSpacing.md),
                _WalletStep(
                  icon: Icons.bolt_rounded,
                  title: 'Bind BrainPoint reward wallet',
                  color: app.warning,
                ),
                const SizedBox(height: AppSpacing.md),
                _WalletStep(
                  icon: Icons.shield_rounded,
                  title: 'Enable blockchain reward verification',
                  color: app.success,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletStep extends StatelessWidget {
  const _WalletStep({
    required this.icon,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: app.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}