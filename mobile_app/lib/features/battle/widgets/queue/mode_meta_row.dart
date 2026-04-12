import 'package:flutter/material.dart';

class ModeMetaRow extends StatelessWidget {
  const ModeMetaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text('Mode: ', style: TextStyle(color: Colors.white54, fontSize: 13)),
        Text(
          'Mixed',
          style: TextStyle(
            color: Color(0xFF2BE8F0),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 8),
        Text('•', style: TextStyle(color: Colors.white38, fontSize: 13)),
        SizedBox(width: 8),
        Text('Wait:', style: TextStyle(color: Colors.white54, fontSize: 13)),
        SizedBox(width: 4),
        Text(
          '~10s',
          style: TextStyle(
            color: Color(0xFF41FF8D),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
