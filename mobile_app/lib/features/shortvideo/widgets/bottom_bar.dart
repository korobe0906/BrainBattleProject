import 'package:flutter/material.dart';

class BottomShortsBar extends StatelessWidget {
  final int inboxBadge;
  final void Function(int index)? onTap; // 0=home,1=shop,2=upload,3=inbox,4=profile

  const BottomShortsBar({super.key, this.inboxBadge = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
        ),
        child: Row(
          children: [
            _item(Icons.home, 'Trang chủ', 0, onTap, color),
            _item(Icons.storefront_outlined, 'Cửa hàng', 1, onTap, color),
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: () => onTap?.call(2),
                  child: Container(
                    width: 54,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                _item(Icons.mail_outline, 'Hộp thư', 3, onTap, color),
                if (inboxBadge > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(18)),
                      child: Text('$inboxBadge',
                          style: const TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                  ),
              ],
            ),
            _item(Icons.person_outline, 'Hồ sơ', 4, onTap, color),
          ],
        ),
      ),
    );
  }

  Widget _item(IconData icon, String label, int idx,
      void Function(int)? onTap, Color color) {
    return InkWell(
      onTap: () => onTap?.call(idx),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class CaptionPill extends StatelessWidget {
  final String source;
  final String label;
  const CaptionPill({super.key, required this.source, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.content_cut, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text('$source · $label',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
