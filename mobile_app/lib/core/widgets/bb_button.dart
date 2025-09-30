import 'package:flutter/material.dart';

// Theme & tokens
import '../../core/theme/palette.dart';
import '../../core/theme/tokens.dart';


class BBButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool ghost;
  final IconData? icon;
  const BBButton.primary(this.label, {super.key, this.onPressed, this.icon}) : ghost = false;
  const BBButton.ghost(this.label, {super.key, this.onPressed, this.icon}) : ghost = true;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: BBPalette.text),
          const SizedBox(width: 8),
        ],
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      decoration: BoxDecoration(
        gradient: ghost
            ? null
            : const LinearGradient(colors: [BBPalette.pink, BBPalette.purple]),
        color: ghost ? BBPalette.surface : null,
        borderRadius: BorderRadius.circular(BBRadii.xl),
        boxShadow: ghost ? [] : BBShadows.neon,
        border: ghost
            ? Border.all(color: BBPalette.purple.withOpacity(0.35), width: 1)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(BBRadii.xl),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: child,
          ),
        ),
      ),
    );
  }
}