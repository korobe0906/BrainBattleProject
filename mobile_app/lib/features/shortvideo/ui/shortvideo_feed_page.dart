import 'package:flutter/material.dart';
import '../data/shortvideo_model.dart';
import '../data/shortvideo_service.dart';
import '../widgets/shortvideo_player.dart';
import '../widgets/top_tabs.dart';
import '../widgets/right_rail.dart';
import '../widgets/bottom_bar.dart';

class ShortVideoFeedPage extends StatefulWidget {
  const ShortVideoFeedPage({super.key});

  @override
  State<ShortVideoFeedPage> createState() => _ShortVideoFeedPageState();
}

class _ShortVideoFeedPageState extends State<ShortVideoFeedPage> {
  final _svc = ShortVideoService();
  final PageController _page = PageController();

  final List<ShortVideo> _items = [];
  bool _loading = true;
  int _pageNum = 1;

  // controller + duration per index (để seek/progress)
  final Map<int, Duration> _durations = {};
  final Map<int, Duration> _positions = {};
  final Map<int, dynamic> _controllers = {}; // VideoPlayerController

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({bool append = true}) async {
    final data = await _svc.fetchFeed(page: _pageNum);
    setState(() {
      if (append) {
        _items.addAll(data);
      } else {
        _items
          ..clear()
          ..addAll(data);
      }
      _loading = false;
    });
  }

  Future<void> _loadMoreIfNeeded(int index) async {
    if (index >= _items.length - 2) {
      _pageNum += 1;
      await _load(append: true);
    }
  }

  void _toggleLike(int index) {
    setState(() {
      final v = _items[index];
      _items[index] = v.copyWith(
        liked: !v.liked,
        likes: v.liked ? (v.likes - 1) : (v.likes + 1),
      );
    });
  }

  void _showCommentsSheet(ShortVideo v) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111111),
      isScrollControlled: true,
      builder: (c) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, controller) => ListView.builder(
          controller: controller,
          itemCount: 18,
          itemBuilder: (_, i) => ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text('User $i', style: const TextStyle(color: Colors.white)),
            subtitle: const Text('Very cool clip! 🔥',
                style: TextStyle(color: Colors.white70)),
          ),
        ),
      ),
    );
  }

  void _seekTo(int index, double valueSec) {
    final c = _controllers[index];
    if (c != null) c.seekTo(Duration(milliseconds: (valueSec * 1000).toInt()));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _page,
            scrollDirection: Axis.vertical,
            itemCount: _items.length,
            onPageChanged: _loadMoreIfNeeded,
            itemBuilder: (context, index) {
              final item = _items[index];
              final dur = _durations[index]?.inSeconds.toDouble() ?? 0.0;
              final pos = _positions[index]?.inSeconds.toDouble() ?? 0.0;

              return Stack(
                children: [
                  ShortVideoPlayer(
                    url: item.videoUrl,
                    thumbnail: item.thumbnailUrl,
                    onController: (c) => _controllers[index] = c,
                    onReady: (d) => setState(() => _durations[index] = d),
                    onProgress: (p) => setState(() => _positions[index] = p),
                  ),
                  // top gradient + tabs
                  const Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [Colors.black45, Colors.transparent],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: TopTabs(active: 'Đề xuất'),
                  ),
                  // Banner + bubble (demo)
                  Positioned(
                    left: 12,
                    top: 80,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text('➕ Thêm bài của bạn',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 140,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('Nhấp ngay\ncó thưởng',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  // Right rail
                  Positioned(
                    right: 8,
                    bottom: 120,
                    child: RightRail(
                      avatarUrl: 'https://i.pravatar.cc/150?img=3',
                      liked: item.liked,
                      likes: item.likes,
                      comments: item.comments,
                      saves: 1630,
                      shares: 327,
                      onAvatarTap: () {},
                      onUploadTap: () {}, // mở màn hình upload
                      onLike: () => _toggleLike(index),
                      onComment: () => _showCommentsSheet(item),
                      onSave: () {},
                      onShare: () {},
                    ),
                  ),

                  // Caption + music + pill
                  Positioned(
                    left: 16,
                    right: 96,
                    bottom: 86,
                    child: DefaultTextStyle(
                      style: const TextStyle(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CaptionPill(source: 'CapCut', label: 'Thử mẫu này'),
                          const SizedBox(height: 8),
                          Text('THÀNH TRƯỞNG',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16)),
                          const SizedBox(height: 6),
                          Text(
                            item.caption,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // progress seek bar (tap/drag)
                  if (dur > 0)
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 74,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 2.5,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                        ),
                        child: Slider(
                          min: 0,
                          max: dur,
                          value: pos.clamp(0, dur),
                          onChanged: (v) => _seekTo(index, v),
                          activeColor: Colors.white,
                          inactiveColor: Colors.white24,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          // Bottom nav bar (overlay)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomShortsBar(
              inboxBadge: 8,
              onTap: (i) {
                // TODO: điều hướng các tab dưới
              },
            ),
          ),
        ],
      ),
    );
  }
}
