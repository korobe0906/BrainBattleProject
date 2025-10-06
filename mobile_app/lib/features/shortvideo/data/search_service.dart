import 'dart:math';

class ShortsSearchService {
  ShortsSearchService._();
  static final instance = ShortsSearchService._();

  final List<String> _history = [
    'Khó dỗ dành',
    'tôi ở đỉnh cao đợi cậu',
  ];

  final List<String> _dictionary = [
    'Lee Kwang Soo',
    'Rhymastic',
    'Hãy để tôi tỏa sáng',
    'She Share Story (for Vlog)',
    'Học phát âm /th/ CEFR A2',
    'IELTS Listening practice',
    'Grammar – Present Perfect',
    'CapCut template',
    'Lofi study music',
    'Shadowing technique',
    'Topic: Daily routine',
    'Phrasal verbs with get',
    'Past simple exercises',
  ];

  List<String> _recommend = ['Lee Kwang Soo', 'Rhymastic', 'hãy để tôi tỏa sáng'];

  List<String> getHistory() => List.unmodifiable(_history);

  void addHistory(String term) {
    _history.remove(term);
    _history.insert(0, term);
    if (_history.length > 20) _history.removeLast();
  }

  void removeHistory(String term) {
    _history.remove(term);
  }

  List<String> getRecommend() => List.unmodifiable(_recommend);

  List<String> refreshRecommend() {
    _recommend.shuffle(Random());
    return getRecommend();
  }

  Future<List<String>> getSuggestions(String query) async {
    if (query.trim().isEmpty) return [];
    await Future.delayed(const Duration(milliseconds: 60));
    final q = query.toLowerCase();
    return _dictionary
        .where((s) => s.toLowerCase().contains(q))
        .take(10)
        .toList();
  }
}
