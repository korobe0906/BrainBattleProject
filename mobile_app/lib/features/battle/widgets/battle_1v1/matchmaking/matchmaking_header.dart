import 'package:flutter/material.dart';

class MatchmakingHeader extends StatelessWidget {
  final VoidCallback onCancel;

  const MatchmakingHeader({
    super.key,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: Colors.white70,
          onPressed: onCancel,
        ),
        const Text(
          '1v1 Duel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFB8860B)),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Row(
            children: [
              Icon(Icons.circle, size: 8, color: Color(0xFFFFD700)),
              SizedBox(width: 6),
              Text(
                'Gold II',
                style: TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
