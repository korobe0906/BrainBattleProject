import 'package:flutter/material.dart';

class TeamModeExplanationCard extends StatelessWidget {
  const TeamModeExplanationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F3B52), Color(0xFF172B4E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFF00C8FF).withOpacity(0.45)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How Team Battles Work',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'A 3v3 battle includes three roles:',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              RoleDot(icon: Icons.spellcheck_rounded, label: 'Grammar'),
              Text('•', style: TextStyle(color: Colors.white38, fontSize: 14)),
              RoleDot(icon: Icons.headphones_rounded, label: 'Listening'),
              Text('•', style: TextStyle(color: Colors.white38, fontSize: 14)),
              RoleDot(icon: Icons.menu_book_rounded, label: 'Vocabulary'),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Each player must select one unique role.',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class RoleDot extends StatelessWidget {
  final IconData icon;
  final String label;

  const RoleDot({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF00D9FF)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}