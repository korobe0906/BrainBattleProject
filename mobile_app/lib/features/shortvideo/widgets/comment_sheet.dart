import 'package:flutter/material.dart';
import '../data/comment_model.dart';
import '../data/comment_service.dart';
import 'comment_tile.dart';

class CommentSheet extends StatefulWidget {
  final String videoId;
  final int initialCount;
  final ValueChanged<int>? onCountChanged; // để update số comment ngoài feed

  const CommentSheet({
    super.key,
    required this.videoId,
    this.initialCount = 0,
    this.onCountChanged,
  });

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final _svc = CommentService();
  final _scroll = ScrollController();
  final _text = TextEditingController();

  CommentSort _sort = CommentSort.relevant;
  int _page = 1;
  bool _loading = true;
  bool _hasMore = false;
  int _total = 0;

  final List<Comment> _comments = [];
  final Map<String, List<Comment>> _replies = {}; // parentId -> replies
  final Set<String> _expanded = <String>{};

  String? _replyTo; // commentId đang trả lời
  String? _replyToName;

  @override
  void initState() {
    super.initState();
    _load();
    _scroll.addListener(() {
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 200 &&
          !_loading &&
          _hasMore) {
        _page += 1;
        _load(append: true);
      }
    });
  }

  Future<void> _load({bool append = false}) async {
    setState(() => _loading = true);
    final res = await _svc.fetchComments(
      widget.videoId,
      page: _page,
      sort: _sort,
    );
    setState(() {
      _total = res.total;
      _hasMore = res.hasMore;
      if (append) {
        _comments.addAll(res.items);
      } else {
        _comments
          ..clear()
          ..addAll(res.items);
      }
      _loading = false;
    });
  }

  Future<void> _loadReplies(String parentId) async {
    if (_replies.containsKey(parentId)) return;
    final data = await _svc.fetchReplies(widget.videoId, parentId);
    setState(() => _replies[parentId] = data);
  }

  void _toggleLike(Comment c) async {
    await _svc.toggleLike(widget.videoId, c.id);
    setState(() {
      final i = _comments.indexWhere((x) => x.id == c.id);
      if (i >= 0) _comments[i] = _comments[i].copyWith(
        liked: !_comments[i].liked,
        likes: _comments[i].liked
            ? _comments[i].likes - 1
            : _comments[i].likes + 1,
      );
      // nếu là reply
      _replies.forEach((pid, list) {
        final j = list.indexWhere((x) => x.id == c.id);
        if (j >= 0) list[j] = list[j].copyWith(
          liked: !list[j].liked,
          likes: list[j].liked ? list[j].likes - 1 : list[j].likes + 1,
        );
      });
    });
  }

  Future<void> _send() async {
    final txt = _text.text.trim();
    if (txt.isEmpty) return;
    _text.clear();

    final newC = await _svc.addComment(
      videoId: widget.videoId,
      text: txt,
      replyTo: _replyTo,
      userName: 'you',
    );

    setState(() {
      if (_replyTo == null) {
        if (_sort == CommentSort.oldest) {
          _comments.add(newC);
        } else {
          _comments.insert(0, newC);
        }
        _total += 1;
        widget.onCountChanged?.call(_total);
      } else {
        final list = _replies[_replyTo!] ?? [];
        list.add(newC);
        _replies[_replyTo!] = list;
        // tăng counter hiển thị
        final idx = _comments.indexWhere((x) => x.id == _replyTo);
        if (idx >= 0) {
          _comments[idx] =
              _comments[idx].copyWith(repliesCount: _comments[idx].repliesCount + 1);
        }
      }
      _replyTo = null;
      _replyToName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF111111),
        appBar: AppBar(
          backgroundColor: const Color(0xFF111111),
          elevation: 0,
          shape: radius,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              Text('Bình luận ($_total)',
                  style: const TextStyle(color: Colors.white)),
              const Spacer(),
              PopupMenuButton<CommentSort>(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onSelected: (v) {
                  setState(() {
                    _sort = v;
                    _page = 1;
                  });
                  _load();
                },
                itemBuilder: (c) => const [
                  PopupMenuItem(value: CommentSort.relevant, child: Text('Liên quan nhất')),
                  PopupMenuItem(value: CommentSort.newest, child: Text('Mới nhất')),
                  PopupMenuItem(value: CommentSort.oldest, child: Text('Cũ nhất')),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Expanded(
              child: _loading && _comments.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scroll,
                      itemCount: _comments.length + (_hasMore ? 1 : 0),
                      itemBuilder: (ctx, i) {
                        if (i >= _comments.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        final c = _comments[i];
                        final expanded = _expanded.contains(c.id);
                        final replies = _replies[c.id];

                        return CommentTile(
                          cmt: c,
                          onLike: () => _toggleLike(c),
                          onReply: () => setState(() {
                            _replyTo = c.id;
                            _replyToName = c.userName;
                          }),
                          onMore: () {},
                          showRepliesButton: true,
                          expanded: expanded,
                          onToggleReplies: () async {
                            setState(() {
                              if (expanded) {
                                _expanded.remove(c.id);
                              } else {
                                _expanded.add(c.id);
                              }
                            });
                            if (!expanded) await _loadReplies(c.id);
                          },
                          replies: expanded && (replies != null)
                              ? replies
                                  .map((r) => CommentTile(
                                        cmt: r,
                                        onLike: () => _toggleLike(r),
                                        onReply: () => setState(() {
                                          _replyTo = c.id; // trả lời parent
                                          _replyToName = r.userName;
                                        }),
                                      ))
                                  .toList()
                              : const [],
                        );
                      },
                    ),
            ),
            // Input bar
            _InputBar(
              replyingTo: _replyToName,
              controller: _text,
              onCancelReply: () => setState(() {
                _replyTo = null;
                _replyToName = null;
              }),
              onSend: _send,
            ),
          ],
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onCancelReply;
  final String? replyingTo;

  const _InputBar({
    required this.controller,
    required this.onSend,
    required this.onCancelReply,
    this.replyingTo,
  });

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: insets),
      child: Container(
        color: const Color(0xFF111111),
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.white70),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (replyingTo != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Text('Đang trả lời @$replyingTo',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12)),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: onCancelReply,
                            child: const Text('Hủy',
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1C),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: 'Thêm bình luận...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onSend,
              icon: const Icon(Icons.send_rounded, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
