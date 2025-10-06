import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final bool liked;
  final int likes;
  final int comments;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const ActionButtons({
    super.key,
    required this.liked,
    required this.likes,
    required this.comments,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onLike,
          icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
          color: liked ? Colors.pinkAccent : color,
          iconSize: 32,
        ),
        Text('$likes', style: TextStyle(color: color)),
        const SizedBox(height: 16),
        IconButton(
          onPressed: onComment,
          icon: const Icon(Icons.comment),
          color: color,
          iconSize: 30,
        ),
        Text('$comments', style: TextStyle(color: color)),
        const SizedBox(height: 16),
        IconButton(
          onPressed: onShare,
          icon: const Icon(Icons.share),
          color: color,
          iconSize: 28,
        ),
      ],
    );
  }
}
