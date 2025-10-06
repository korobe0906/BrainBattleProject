import 'dart:math';
import 'comment_model.dart';

enum CommentSort { relevant, newest, oldest }

final Map<String, List<Comment>> _db = {}; // videoId -> comments+replies
int _idSeed = 1;

String _nextId() => (_idSeed++).toString();

String _avatar(int i) => 'https://i.pravatar.cc/150?img=${(i % 70) + 1}';

void _ensureSeed(String videoId) {
  if (_db.containsKey(videoId)) return;
  final now = DateTime.now();
  final rnd = Random(videoId.hashCode);
  final list = <Comment>[];
  for (int i = 0; i < 18; i++) {
    final id = _nextId();
    final base = Comment(
      id: id,
      videoId: videoId,
      userName: 'user_${i + 1}',
      avatarUrl: _avatar(i),
      text: 'Bài này hay phết nè! 🔥 (cmt $i)',
      createdAt: now.subtract(Duration(minutes: 2 * i + rnd.nextInt(8))),
      likes: rnd.nextInt(300),
      repliesCount: 0,
    );
    list.add(base);
    // seed vài reply
    final rc = rnd.nextInt(3);
    for (int r = 0; r < rc; r++) {
      list.add(Comment(
        id: _nextId(),
        videoId: videoId,
        parentId: id,
        userName: 'friend_${r + 1}',
        avatarUrl: _avatar(i + r + 7),
        text: 'Reply $r cho comment $i',
        createdAt: now.subtract(Duration(minutes: 2 * i + r + 1)),
        likes: rnd.nextInt(40),
      ));
    }
    if (rc > 0) {
      final idx = list.indexWhere((c) => c.id == id);
      list[idx] = list[idx].copyWith(repliesCount: rc);
    }
  }
  _db[videoId] = list;
}

class CommentPage {
  final List<Comment> items;
  final bool hasMore;
  final int total;
  CommentPage(this.items, this.hasMore, this.total);
}

class CommentService {
  Future<CommentPage> fetchComments(
    String videoId, {
    int page = 1,
    int pageSize = 12,
    CommentSort sort = CommentSort.relevant,
  }) async {
    _ensureSeed(videoId);
    await Future.delayed(const Duration(milliseconds: 250));
    final all = _db[videoId]!;
    final roots = all.where((c) => c.parentId == null).toList();

    roots.sort((a, b) {
      switch (sort) {
        case CommentSort.relevant: // tạm = likes desc
          return b.likes.compareTo(a.likes);
        case CommentSort.newest:
          return b.createdAt.compareTo(a.createdAt);
        case CommentSort.oldest:
          return a.createdAt.compareTo(b.createdAt);
      }
    });

    final start = (page - 1) * pageSize;
    final slice = roots.skip(start).take(pageSize).toList();
    final hasMore = start + pageSize < roots.length;
    return CommentPage(slice, hasMore, roots.length);
  }

  Future<List<Comment>> fetchReplies(String videoId, String parentId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final all = _db[videoId]!;
    return all.where((c) => c.parentId == parentId).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  Future<Comment> addComment({
    required String videoId,
    required String text,
    String? replyTo,
    String userName = 'you',
    String avatarUrl = 'https://i.pravatar.cc/150?img=12',
  }) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final c = Comment(
      id: _nextId(),
      videoId: videoId,
      userName: userName,
      avatarUrl: avatarUrl,
      text: text,
      createdAt: DateTime.now(),
      parentId: replyTo,
    );
    _db[videoId]!.add(c);

    // tăng counter cho parent
    if (replyTo != null) {
      final i = _db[videoId]!.indexWhere((x) => x.id == replyTo);
      if (i >= 0) _db[videoId]![i] = _db[videoId]![i].copyWith(
        repliesCount: _db[videoId]![i].repliesCount + 1,
      );
    }

    return c;
  }

  Future<void> toggleLike(String videoId, String commentId) async {
    final i = _db[videoId]!.indexWhere((x) => x.id == commentId);
    if (i < 0) return;
    final current = _db[videoId]![i];
    final liked = !current.liked;
    _db[videoId]![i] = current.copyWith(
      liked: liked,
      likes: liked ? current.likes + 1 : current.likes - 1,
    );
  }
}
