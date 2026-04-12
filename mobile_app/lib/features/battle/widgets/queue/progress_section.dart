import 'package:flutter/material.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    const done = 3;
    const total = 10;
    const progress = done / total;
    final pct = (progress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$done / $total battles',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: const Color(0xFF5A4BFF).withOpacity(0.22),
                border: Border.all(
                  color: const Color(0xFF5A4BFF).withOpacity(0.5),
                ),
              ),
              child: Text(
                '$pct%',
                style: const TextStyle(
                  color: Color(0xFF9B8FFF),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.white12,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5A4BFF)),
          ),
        ),
      ],
    );
  }
}
