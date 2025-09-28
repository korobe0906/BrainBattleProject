import 'package:flutter/material.dart';
import '../data/chat_repository.dart';
import '../data/chat_models.dart';
import '../widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  final MockChatRepository repo;
  final Conversation convo;

  const ChatPage({super.key, required this.repo, required this.convo});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final messages = widget.repo.listMessages(widget.convo.id);

    return Scaffold(
      appBar: AppBar(title: Text(widget.convo.title)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final m = messages[i];
                final isMe = m.senderId == widget.repo.me.id;
                return MessageBubble(isMe: isMe, text: m.text);
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    decoration: const InputDecoration(
                      hintText: 'Message…',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: () {
                    final text = ctrl.text.trim();
                    if (text.isEmpty) return;
                    widget.repo.send(widget.convo.id, text);
                    ctrl.clear();
                    setState(() {});
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
