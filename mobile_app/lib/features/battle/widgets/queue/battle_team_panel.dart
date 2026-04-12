import 'package:flutter/material.dart';

class BattleTeamPanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final String neededText;
  final List<String> roles;
  final VoidCallback onTap;

  const BattleTeamPanel({
    super.key,
    required this.title,
    required this.subtitle,
    required this.neededText,
    required this.roles,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D7876).withOpacity(0.5),
            const Color(0xFF2D2D62).withOpacity(0.42),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D7876).withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2D8C8A), Color(0xFF33ADAA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF2D8C8A),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.groups_2_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              color: const Color(0xFF3B8DFF).withOpacity(0.2),
                              border: Border.all(
                                color: const Color(0xFF5EC6FF).withOpacity(0.7),
                              ),
                            ),
                            child: Text(
                              neededText,
                              style: const TextStyle(
                                color: Color(0xFF5EE4FF),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
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
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        runSpacing: 6,
                        children: roles
                            .map(
                              (role) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _roleIcon(role),
                                    size: 13,
                                    color: const Color(0xFF4DE8FF),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    role,
                                    style: const TextStyle(
                                      color: Color(0xFF4DE8FF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white70,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static IconData _roleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'listening':
        return Icons.headphones_rounded;
      case 'vocab':
      case 'vocabulary':
        return Icons.chrome_reader_mode_rounded;
      case 'grammar':
      default:
        return Icons.menu_book_rounded;
    }
  }
}
