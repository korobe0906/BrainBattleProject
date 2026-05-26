import 'package:flutter/material.dart';

class TeamSlotAvatar extends StatelessWidget {
  final bool filled;
  final String label;

  const TeamSlotAvatar({
    super.key,
    required this.filled,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: filled
                ? const LinearGradient(
                    colors: [Color(0xFFF57AA7), Color(0xFFB968FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: filled ? null : Colors.white.withOpacity(0.06),
            border: Border.all(color: Colors.white.withOpacity(0.22)),
          ),
          alignment: Alignment.center,
          child: filled
              ? const Text(
                  'You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : const Icon(Icons.circle, size: 8, color: Colors.white30),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 13),
        ),
      ],
    );
  }
}