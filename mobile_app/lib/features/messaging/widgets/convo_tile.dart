import 'package:flutter/material.dart';
import '../../messaging/data/chat_models.dart';

class ConvoTile extends StatelessWidget {
  final Conversation c;
  final VoidCallback onTap;
  const ConvoTile({super.key, required this.c, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: cs.secondaryContainer,
        child: Text(c.title.characters.first),
      ),
      title: Text(c.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(c.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_timeLabel(c.updatedAt), style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 6),
          if (c.unread > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(999)),
              child: Text('${c.unread}', style: TextStyle(color: cs.onPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
      onTap: onTap,
    );
  }

  String _timeLabel(DateTime t) {
    final now = DateTime.now();
    if (now.difference(t).inDays >= 1) return 'Yesterday';
    return '${t.hour.toString().padLeft(2,'0')}:${t.minute.toString().padLeft(2,'0')}';
  }
}
