import 'package:flutter/material.dart';

class DuelModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? detailLabel;
  final String? detailValue;
  final String? detailSuffix;
  final Color detailValueColor;
  final IconData icon;
  final bool selected;
  final bool mixedStyle;
  final String? questionCount;
  final String? badgeText;
  final List<({String label, IconData icon})>? roles;
  final VoidCallback onTap;

  const DuelModeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.detailLabel,
    this.detailValue,
    this.detailSuffix,
    this.detailValueColor = const Color(0xFF00D9FF),
    this.mixedStyle = false,
    this.questionCount,
    this.badgeText,
    this.roles,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = mixedStyle
        ? const Color(0xFF9B62E9).withOpacity(0.7)
        : (selected
              ? const Color(0xFF9B62E9).withOpacity(0.85)
              : Colors.white.withOpacity(0.10));

    final cardGradient = mixedStyle
        ? LinearGradient(
            colors: [
              const Color(0xFF4A2D6F).withOpacity(0.9),
              const Color(0xFF2B2448).withOpacity(0.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [Color(0xFF1D273A), Color(0xFF1A2334)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: cardGradient,
          border: Border.all(color: borderColor),
          boxShadow: [
            if (mixedStyle || selected)
              BoxShadow(
                color:
                    (mixedStyle
                            ? const Color(0xFFB46BFF)
                            : const Color(0xFF8E62FF))
                        .withOpacity(0.25),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mixedStyle
                    ? const Color(0xFFF8A2C0)
                    : const Color(0xFF3A455A).withOpacity(0.75),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: mixedStyle ? const Color(0xFF351C40) : Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (badgeText != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: const Color(0xFFB779FF).withOpacity(0.25),
                            border: Border.all(
                              color: const Color(0xFFD39EFF).withOpacity(0.45),
                            ),
                          ),
                          child: Text(
                            badgeText!,
                            style: const TextStyle(
                              color: Color(0xFFE0C9FF),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      else if (questionCount != null)
                        Text(
                          questionCount!,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 15,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                  if (roles != null) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 4,
                      children: roles!
                          .map(
                            (item) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item.icon,
                                  size: 14,
                                  color: const Color(0xFF00D9FF),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  item.label,
                                  style: const TextStyle(
                                    color: Color(0xFF00D9FF),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ] else if (detailLabel != null && detailValue != null) ...[
                    const SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 13),
                        children: [
                          TextSpan(
                            text: detailLabel,
                            style: const TextStyle(color: Colors.white54),
                          ),
                          TextSpan(
                            text: detailValue,
                            style: TextStyle(
                              color: detailValueColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: detailSuffix ?? '',
                            style: const TextStyle(color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}