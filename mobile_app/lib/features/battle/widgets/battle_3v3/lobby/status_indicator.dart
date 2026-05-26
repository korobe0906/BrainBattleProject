import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final bool ready;
  final bool empty;

  const StatusIndicator({
    super.key,
    required this.ready,
    required this.empty,
  });

  @override
  Widget build(BuildContext context) {
    if (empty) {
      return const Icon(Icons.circle, size: 8, color: Colors.white30);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Icons.circle,
          size: 9,
          color: ready ? const Color(0xFF16F4A6) : Colors.white38,
        ),
        const SizedBox(height: 2),
        Text(
          ready ? 'Ready' : 'Waiting',
          style: TextStyle(
            color: ready ? const Color(0xFF16F4A6) : Colors.white54,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}