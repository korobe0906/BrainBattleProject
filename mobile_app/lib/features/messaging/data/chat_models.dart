class Participant {
  final String id;
  final String displayName;
  final String avatarText; // dùng ký tự đầu nếu chưa có ảnh

  const Participant({required this.id, required this.displayName, required this.avatarText});
}

class Message {
  final String id;
  final String convoId;
  final String senderId;
  final String text;
  final DateTime sentAt;

  const Message({required this.id, required this.convoId, required this.senderId, required this.text, required this.sentAt});
}

class Conversation {
  final String id;
  final String title;        // tên clan / group
  final List<String> memberIds;
  final String lastMessage;
  final DateTime updatedAt;
  final int unread;

  const Conversation({
    required this.id,
    required this.title,
    required this.memberIds,
    required this.lastMessage,
    required this.updatedAt,
    this.unread = 0,
  });
}
