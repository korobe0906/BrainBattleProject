import 'package:flutter/material.dart';
import '../data/chat_repository.dart';
import 'chat_page.dart';

class NewClanPage extends StatefulWidget {
  final MockChatRepository repo;
  const NewClanPage({super.key, required this.repo});

  @override
  State<NewClanPage> createState() => _NewClanPageState();
}

class _NewClanPageState extends State<NewClanPage> {
  final ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Clan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: ctrl,
              decoration: const InputDecoration(
                labelText: 'Clan name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                final name = ctrl.text.trim();
                if (name.isEmpty) return;
                final c = widget.repo.createClan(name);
                Navigator.pop(context, true);
                Navigator.push(context, MaterialPageRoute(
                  builder: (_)=> ChatPage(repo: widget.repo, convo: c),
                ));
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
