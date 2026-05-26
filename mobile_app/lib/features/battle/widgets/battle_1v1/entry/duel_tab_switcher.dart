import 'package:flutter/material.dart';

class DuelTabSwitcher extends StatelessWidget {
  final TabController controller;

  const DuelTabSwitcher({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation!,
      builder: (context, _) {
        final progress = controller.animation!.value.clamp(0.0, 1.0);
        return Container(
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: const Color(0xFF121A2A),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  alignment: progress < 0.5
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7B2B78), Color(0xFF5D2A7E)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: const Color(0xFFFF7EB6).withOpacity(0.8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF7EB6).withOpacity(0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TabItem(
                        title: 'Create duel',
                        selected: controller.index == 0,
                        onTap: () => controller.animateTo(0),
                      ),
                    ),
                    Expanded(
                      child: TabItem(
                        title: 'Join by code',
                        selected: controller.index == 1,
                        onTap: () => controller.animateTo(1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const TabItem({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white70,
            fontSize: 15,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}