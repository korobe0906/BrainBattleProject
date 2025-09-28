import 'chat_models.dart';

class MockChatRepository {
  // giả lập “current user”
  final me = const Participant(id: 'me', displayName: 'You', avatarText: 'Y');

  final participants = const [
    Participant(id: 'u1', displayName: 'TOEIC 500+ Warriors', avatarText: 'T'),
    Participant(id: 'u2', displayName: 'JLPT N4 Clan', avatarText: 'J'),
    Participant(id: 'u3', displayName: 'IELTS Speaking', avatarText: 'I'),
  ];

  late final List<Conversation> _convos = [
    Conversation(
      id: 'c1',
      title: 'TOEIC 500+ Warriors',
      memberIds: const ['me','u1'],
      lastMessage: 'Mai 8PM battle set 3 nha!',
      updatedAt: DateTime.now().subtract(const Duration(minutes: 12)),
      unread: 3,
    ),
    Conversation(
      id: 'c2',
      title: 'JLPT N4 Clan',
      memberIds: const ['me','u2'],
      lastMessage: 'Tổng hợp Kanji tuần này',
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
      unread: 0,
    ),
    Conversation(
      id: 'c3',
      title: 'IELTS Speaking',
      memberIds: const ['me','u3'],
      lastMessage: 'Cue card: Describe a person…',
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      unread: 5,
    ),
  ];

  late final List<Message> _messages = [
    Message(id: 'm1', convoId: 'c1', senderId: 'u1', text: 'Mai 8PM battle set 3 nha!', sentAt: DateTime.now().subtract(const Duration(minutes: 13))),
    Message(id: 'm2', convoId: 'c1', senderId: 'me', text: 'Ok team!', sentAt: DateTime.now().subtract(const Duration(minutes: 12))),
    Message(id: 'm3', convoId: 'c2', senderId: 'u2', text: 'Tổng hợp Kanji tuần này', sentAt: DateTime.now().subtract(const Duration(hours: 3))),
    Message(id: 'm4', convoId: 'c3', senderId: 'u3', text: 'Cue card: Describe a person…', sentAt: DateTime.now().subtract(const Duration(days: 1, minutes: 10))),
  ];

  List<Conversation> listConversations() => _convos..sort((a,b)=>b.updatedAt.compareTo(a.updatedAt));

  List<Message> listMessages(String convoId) =>
      _messages.where((m) => m.convoId == convoId).toList()..sort((a,b)=>a.sentAt.compareTo(b.sentAt));

  Conversation createClan(String title) {
    final c = Conversation(
      id: 'c${_convos.length+1}',
      title: title,
      memberIds: const ['me'],
      lastMessage: 'Clan created',
      updatedAt: DateTime.now(),
      unread: 0,
    );
    _convos.add(c);
    _messages.add(Message(id: 'm${_messages.length+1}', convoId: c.id, senderId: 'me', text: 'Clan created', sentAt: DateTime.now()));
    return c;
  }

  Message send(String convoId, String text) {
    final msg = Message(
      id: 'm${_messages.length+1}',
      convoId: convoId,
      senderId: 'me',
      text: text,
      sentAt: DateTime.now(),
    );
    _messages.add(msg);
    final idx = _convos.indexWhere((c)=>c.id==convoId);
    if (idx!=-1) {
      final c = _convos[idx];
      _convos[idx] = Conversation(
        id: c.id,
        title: c.title,
        memberIds: c.memberIds,
        lastMessage: text,
        updatedAt: msg.sentAt,
        unread: c.unread,
      );
    }
    return msg;
  }
}
