import 'package:flutter/material.dart';

import '../../theme/theme_extensions.dart';

class NeonTextField extends StatelessWidget {
  const NeonTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int maxLines;
  final IconData? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      style: TextStyle(
        color: app.textPrimary,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon:
            prefixIcon == null ? null : Icon(prefixIcon, color: auth.accent),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: auth.inputBackground.withOpacity(0.74),
      ),
    );
  }
}