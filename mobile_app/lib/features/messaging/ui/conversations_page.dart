import 'package:flutter/material.dart';
import '../data/chat_repository.dart';
import '../data/chat_models.dart';
import '../widgets/convo_tile.dart';
import 'chat_page.dart';
import 'new_clan_page.dart';

class ConversationsPage extends StatefulWidget {
  static const routeName = '/messaging';
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  final repo = MockChatRepository();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final convos = repo.listConversations()
      .where((c)=>c.title.toLowerCase().contains(_query.toLowerCase()))
      .toList();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search clans',
              prefixIcon: const Icon(Icons.search),
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              fillColor: cs.surface,
              filled: true,
            ),
            onChanged: (v)=>setState(()=>_query=v),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'New clan',
            icon: const Icon(Icons.group_add_outlined),
            onPressed: () async {
              final created = await Navigator.push(context,
                MaterialPageRoute(builder: (_)=> NewClanPage(repo: repo)));
              if (created == true) setState(() {});
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        itemBuilder: (_, i) {
          final c = convos[i];
          return ConvoTile(
            c: c,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_)=> ChatPage(repo: repo, convo: c),
              )).then((_) => setState((){}));
            },
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemCount: convos.length,
      ),
    );
  }
}
