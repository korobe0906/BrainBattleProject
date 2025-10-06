class Comment {
  final String id;
  final String videoId;
  final String userName;
  final String avatarUrl;
  final String? parentId; // null = comment gốc, khác null = reply
  final DateTime createdAt;

  final String text;
  int likes;
  bool liked;

  int repliesCount; // tổng số reply (nếu là comment gốc)

  Comment({
    required this.id,
    required this.videoId,
    required this.userName,
    required this.avatarUrl,
    required this.text,
    required this.createdAt,
    this.parentId,
    this.likes = 0,
    this.liked = false,
    this.repliesCount = 0,
  });

  bool get isReply => parentId != null;

  Comment copyWith({
    String? text,
    int? likes,
    bool? liked,
    int? repliesCount,
  }) {
    return Comment(
      id: id,
      videoId: videoId,
      userName: userName,
      avatarUrl: avatarUrl,
      text: text ?? this.text,
      createdAt: createdAt,
      parentId: parentId,
      likes: likes ?? this.likes,
      liked: liked ?? this.liked,
      repliesCount: repliesCount ?? this.repliesCount,
    );
  }
}
