import 'package:flutter/material.dart';

class LobbyActions extends StatelessWidget {
  final String startLabel;
  final VoidCallback onShare;
  final VoidCallback onStart;
  final bool isStartEnabled;

  const LobbyActions({
    super.key,
    required this.startLabel,
    required this.onShare,
    required this.onStart,
    this.isStartEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: Colors.white.withOpacity(0.22)),
              backgroundColor: const Color(0xFF151E2F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: onShare,
            child: const Text(
              'Share code',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: isStartEnabled
                  ? const LinearGradient(
                      colors: [Color(0xFFF57AA7), Color(0xFFF76095)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [
                        const Color(0xFFF57AA7).withOpacity(0.5),
                        const Color(0xFFF76095).withOpacity(0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              boxShadow: isStartEnabled
                  ? [
                      BoxShadow(
                        color: const Color(0xFFFF7EB6).withOpacity(0.45),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: isStartEnabled ? onStart : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      startLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: isStartEnabled
                            ? const Color(0xFF1A0B1B)
                            : Colors.white.withOpacity(0.5),
                        fontSize: 15.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}