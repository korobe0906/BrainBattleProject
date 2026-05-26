import 'package:flutter/material.dart';
import 'team_slot_avatar.dart';

class TeamPreviewSection extends StatelessWidget {
  const TeamPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF191D34), Color(0xFF151D30)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Team (1 / 3 players)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              TeamSlotAvatar(filled: true, label: 'You'),
              SizedBox(width: 12),
              TeamSlotAvatar(filled: false, label: 'Empty'),
              SizedBox(width: 12),
              TeamSlotAvatar(filled: false, label: 'Empty'),
            ],
          ),
        ],
      ),
    );
  }
}