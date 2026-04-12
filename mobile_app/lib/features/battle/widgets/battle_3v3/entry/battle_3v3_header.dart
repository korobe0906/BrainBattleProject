import 'package:flutter/material.dart';

class Battle3v3Header extends StatelessWidget {
  final VoidCallback onBack;

  const Battle3v3Header({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Colors.white,
          ),
          onPressed: onBack,
          splashRadius: 22,
        ),
        const SizedBox(width: 4),
        const Expanded(
          child: Text(
            '3v3 Team Battle',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: const LinearGradient(
              colors: [Color(0xFF2C2202), Color(0xFF120D00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: const Color(0xFFFFB703).withOpacity(0.55),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFB703).withOpacity(0.35),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shield_outlined,
                size: 14,
                color: Color(0xFFFFC94A),
              ),
              SizedBox(width: 6),
              Text(
                'Gold II ★★★☆☆',
                style: TextStyle(
                  color: Color(0xFFFFC94A),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}