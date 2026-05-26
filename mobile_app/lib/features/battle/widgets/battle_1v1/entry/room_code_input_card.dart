import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoomCodeInputCard extends StatelessWidget {
  final TextEditingController controller;

  const RoomCodeInputCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF201E49), Color(0xFF1A1A3D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFF7C3CDB).withOpacity(0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF36435A).withOpacity(0.75),
            ),
            child: const Icon(
              Icons.key_rounded,
              color: Color(0xFF00D9FF),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w700,
              ),
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'AB37X',
                hintStyle: TextStyle(
                  color: Colors.white30,
                  fontSize: 18,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}