import 'package:flutter/material.dart';

class TeamBattleInfoCard extends StatelessWidget {
  const TeamBattleInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF4A1F5B), Color(0xFF2C1F47)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFF8C47D8).withOpacity(0.5)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Team Battle Info',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InfoStatItem(
                  icon: Icons.groups_2_outlined,
                  iconColor: Color(0xFFFF8DAA),
                  value: '3',
                  label: 'Per Team',
                ),
              ),
              Expanded(
                child: InfoStatItem(
                  icon: Icons.group_outlined,
                  iconColor: Color(0xFFB969FF),
                  value: '6',
                  label: 'Total Players',
                ),
              ),
              Expanded(
                child: InfoStatItem(
                  icon: Icons.adjust_rounded,
                  iconColor: Color(0xFF00D9FF),
                  value: '10',
                  label: 'Rounds',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoStatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const InfoStatItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 13),
        ),
      ],
    );
  }
}