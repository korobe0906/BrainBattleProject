import 'package:flutter/material.dart';

class BattleRoomCodeBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? trailingText;
  final Widget? leading;
  final Widget? bottom;
  final VoidCallback? onTap;

  const BattleRoomCodeBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingText,
    this.leading,
    this.bottom,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4C2E80).withOpacity(0.5),
            const Color(0xFF2A2F55).withOpacity(0.45),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9F5DFF).withOpacity(0.2),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (trailingText != null)
                      Text(
                        trailingText!,
                        style: const TextStyle(
                          color: Color(0xFF4DE8FF),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
                if (bottom != null) ...[const SizedBox(height: 12), bottom!],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
