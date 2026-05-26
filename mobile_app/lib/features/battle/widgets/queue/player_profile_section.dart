import 'package:flutter/material.dart';

class PlayerProfileSection extends StatelessWidget {
  const PlayerProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3E236A).withOpacity(0.65),
            const Color(0xFF201E47).withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB754FF).withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFB35CFF), Color(0xFFFF52B6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'P',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFEB4EFF),
                    border: Border.all(
                      color: const Color(0xFF301E55),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(Icons.close, size: 11, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WarriorX',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFC742), Color(0xFFFF9E00)],
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 13,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Gold II',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFB703),
                      size: 16,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFB703),
                      size: 16,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFB703),
                      size: 16,
                    ),
                    Icon(
                      Icons.star_border_rounded,
                      color: Colors.white38,
                      size: 16,
                    ),
                    Icon(
                      Icons.star_border_rounded,
                      color: Colors.white38,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: const Color(0xFF0E8FB8).withOpacity(0.18),
                  border: Border.all(
                    color: const Color(0xFF2BC8F0).withOpacity(0.75),
                  ),
                ),
                child: const Text(
                  '128 BP',
                  style: TextStyle(
                    color: Color(0xFF61E6FF),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                  children: [
                    TextSpan(text: 'Season ends in '),
                    TextSpan(
                      text: '12 days',
                      style: TextStyle(
                        color: Color(0xFFFF5C8A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white70,
            size: 18,
          ),
        ],
      ),
    );
  }
}
