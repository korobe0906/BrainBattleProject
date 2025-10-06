import 'package:flutter/material.dart';

String _abbrVi(int n) {
  if (n >= 1000000) {
    final v = (n / 1000000.0);
    return '${v.toStringAsFixed(v < 10 ? 1 : 0).replaceAll('.', ',')} Tr';
  }
  if (n >= 1000) {
    final v = (n / 1000.0);
    return '${v.toStringAsFixed(v < 10 ? 1 : 0).replaceAll('.', ',')} N';
  }
  return '$n';
}

class RightRail extends StatelessWidget {
  final String avatarUrl;
  final bool liked;
  final int likes;
  final int comments;
  final int saves;
  final int shares;
  final VoidCallback onAvatarTap;
  final VoidCallback onUploadTap;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onSave;
  final VoidCallback onShare;

  const RightRail({
    super.key,
    required this.avatarUrl,
    required this.liked,
    required this.likes,
    required this.comments,
    required this.saves,
    required this.shares,
    required this.onAvatarTap,
    required this.onUploadTap,
    required this.onLike,
    required this.onComment,
    required this.onSave,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar + dấu cộng nhỏ
        Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: onAvatarTap,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(avatarUrl),
              ),
            ),
            Positioned(
              bottom: -2,
              right: -2,
              child: InkWell(
                onTap: onUploadTap,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.pinkAccent),
                  child: const Icon(Icons.add, size: 16, color: Colors.white),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        // Like
        IconButton(
          onPressed: onLike,
          icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
          color: liked ? Colors.pinkAccent : color,
          iconSize: 32,
        ),
        Text(_abbrVi(likes), style: const TextStyle(color: color)),
        const SizedBox(height: 12),
        // Comment
        IconButton(
          onPressed: onComment,
          icon: const Icon(Icons.chat_bubble_outline),
          color: color,
          iconSize: 30,
        ),
        Text(_abbrVi(comments), style: const TextStyle(color: color)),
        const SizedBox(height: 12),
        // Save
        IconButton(
          onPressed: onSave,
          icon: const Icon(Icons.bookmark_border),
          color: color,
          iconSize: 30,
        ),
        Text(_abbrVi(saves), style: const TextStyle(color: color)),
        const SizedBox(height: 12),
        // Share
        IconButton(
          onPressed: onShare,
          icon: const Icon(Icons.reply_outlined), // mũi tên share
          color: color,
          iconSize: 30,
        ),
        Text(_abbrVi(shares), style: const TextStyle(color: color)),
      ],
    );
  }
}
