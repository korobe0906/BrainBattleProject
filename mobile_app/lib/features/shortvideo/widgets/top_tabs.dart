import 'package:flutter/material.dart';

class TopTabs extends StatelessWidget {
  final String active; // 'De xuat', 'Live', ...
final VoidCallback? onSearchTap;
  const TopTabs({super.key, this.active = 'Đề xuất', this.onSearchTap});


  @override
  Widget build(BuildContext context) {
    final items = const ['LIVE', 'Khám phá', 'Bạn bè', 'Đã follow', 'Đề xuất'];
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: items.map((t) {
                    final sel = t == active;
                    return Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t,
                            style: TextStyle(
                              color: Colors.white.withOpacity(sel ? 1 : .7),
                              fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (sel)
                            Container(
                              width: 28,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
                onPressed: onSearchTap,      
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
