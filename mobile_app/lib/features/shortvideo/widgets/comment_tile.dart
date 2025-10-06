import 'package:flutter/material.dart';
import '../data/comment_model.dart';

String _timeAgo(DateTime t) {
  final d = DateTime.now().difference(t);
  if (d.inMinutes < 1) return 'vừa xong';
  if (d.inMinutes < 60) return '${d.inMinutes} phút';
  if (d.inHours < 24) return '${d.inHours} giờ';
  return '${d.inDays} ngày';
}

String _abbr(int n) {
  if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)} Tr';
  if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)} N';
  return '$n';
}

class CommentTile extends StatelessWidget {
  final Comment cmt;
  final VoidCallback onLike;
  final VoidCallback onReply;
  final VoidCallback? onMore;
  final VoidCallback? onToggleReplies;
  final bool showRepliesButton;
  final bool expanded;
  final List<Widget>? replies; // khi expanded

  const CommentTile({
    super.key,
    required this.cmt,
    required this.onLike,
    required this.onReply,
    this.onMore,
    this.onToggleReplies,
    this.showRepliesButton = false,
    this.expanded = false,
    this.replies,
  });

  @override
  Widget build(BuildContext context) {
    final colorText = Colors.white;
    final colorSub = Colors.white70;

    return Padding(
      padding: EdgeInsets.only(
        left: cmt.isReply ? 52 : 16,
        right: 12,
        top: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!cmt.isReply)
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(cmt.avatarUrl),
                )
              else
                const SizedBox(width: 0, height: 0),
              if (!cmt.isReply) const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cmt.userName,
                        style: TextStyle(
                            color: colorText, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(cmt.text,
                        style: TextStyle(color: colorText, height: 1.25)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(_timeAgo(cmt.createdAt),
                            style: TextStyle(color: colorSub, fontSize: 12)),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: onReply,
                          child: Text('Trả lời',
                              style: TextStyle(
                                  color: colorSub,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      cmt.liked ? Icons.favorite : Icons.favorite_border,
                      color: cmt.liked ? Colors.pinkAccent : Colors.white,
                      size: 20,
                    ),
                    onPressed: onLike,
                  ),
                  const SizedBox(height: 2),
                  Text(_abbr(cmt.likes),
                      style: const TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              const SizedBox(width: 6),
              if (onMore != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.more_vert, color: Colors.white70, size: 20),
                  onPressed: onMore,
                ),
            ],
          ),
          // Nút xem/ẩn trả lời
          if (showRepliesButton && cmt.repliesCount > 0)
            Padding(
              padding: const EdgeInsets.only(left: 52, top: 8),
              child: GestureDetector(
                onTap: onToggleReplies,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(expanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.white70, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      expanded
                          ? 'Ẩn trả lời'
                          : 'Xem thêm ${cmt.repliesCount} phản hồi',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          if (expanded && (replies?.isNotEmpty ?? false))
            Padding(
              padding: const EdgeInsets.only(left: 34, top: 6),
              child: Column(children: replies!),
            ),
        ],
      ),
    );
  }
}
