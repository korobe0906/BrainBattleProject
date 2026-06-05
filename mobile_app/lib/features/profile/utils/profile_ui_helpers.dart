String profileInitials(String value) {
  final words = value
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();

  if (words.isEmpty) return 'L';

  if (words.length == 1) {
    final one = words.first;
    return one.length >= 2
        ? one.substring(0, 2).toUpperCase()
        : one.toUpperCase();
  }

  return '${words.first[0]}${words.last[0]}'.toUpperCase();
}