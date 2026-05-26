import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class BattleLobbyHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClose;

  const BattleLobbyHeader({
    super.key,
    required this.onClose,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BBColors.darkBg,
      elevation: 0,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      title: const Text(
        '1v1 Lobby',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      leading: IconButton(
        icon: const Icon(Icons.close_rounded, size: 20),
        onPressed: onClose,
      ),
    );
  }
}