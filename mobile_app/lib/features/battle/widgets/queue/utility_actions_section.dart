import 'package:flutter/material.dart';

class UtilityActionsSection extends StatelessWidget {
  final ValueChanged<String> onTap;

  const UtilityActionsSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final actions = <({String label, IconData icon})>[
      (label: 'Join Room', icon: Icons.login_rounded),
      (label: 'History', icon: Icons.history_rounded),
      (label: 'Ranks', icon: Icons.emoji_events_outlined),
      (label: 'Shop', icon: Icons.storefront_outlined),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions
          .map(
            (item) => InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => onTap(item.label),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Column(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF7A1EA5).withOpacity(0.95),
                            const Color(0xFF3A125E).withOpacity(0.95),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFCC57FF).withOpacity(0.28),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(item.icon, color: Colors.white, size: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.label,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
