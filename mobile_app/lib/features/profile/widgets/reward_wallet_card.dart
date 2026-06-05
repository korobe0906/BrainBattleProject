import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/widgets/neon/neon_button.dart';
import '../ui/wallet_link_page.dart';
import 'profile_glass_card.dart';

class RewardWalletCard extends StatelessWidget {
  const RewardWalletCard({
    super.key,
    required this.walletCount,
    required this.verifiedEmail,
  });

  final int walletCount;
  final bool verifiedEmail;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final text = Theme.of(context).textTheme;

    return ProfileGlassCard(
      glowColor: app.warning,
      borderColor: app.warning.withOpacity(0.58),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: app.warning.withOpacity(0.2),
                  border: Border.all(color: app.warning.withOpacity(0.65)),
                ),
                child: Icon(Icons.bolt_rounded, color: app.warning, size: 32),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$walletCount wallet connected',
                      style: text.titleMedium?.copyWith(
                        color: app.textPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      verifiedEmail
                          ? 'Ready for reward tracking and blockchain proof'
                          : 'Verify email before connecting reward wallet',
                      style: text.bodySmall?.copyWith(color: app.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          NeonButton(
            label: walletCount > 0 ? 'Manage Wallet' : 'Connect Wallet',
            icon: Icons.account_balance_wallet_rounded,
            onPressed: () {
              Navigator.of(context).pushNamed(WalletLinkPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}