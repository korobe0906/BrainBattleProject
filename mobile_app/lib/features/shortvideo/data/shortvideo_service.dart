import 'shortvideo_model.dart';

class ShortVideoService {
  // Demo data – sau này đổi thành API/pagination
  Future<List<ShortVideo>> fetchFeed({int page = 1}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.generate(10, (i) {
      final idx = '${page}_$i';
      return ShortVideo(
        id: idx,
        videoUrl:
            // Dùng sample HLS/MP4 public; thay bằng CDN của bạn
            'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4',
        thumbnailUrl:
            'https://picsum.photos/seed/short$idx/600/900',
        author: 'Teacher ${i + 1}',
        caption: 'Bí kíp phát âm /th/ chuẩn CEFR A2 — part $idx',
        music: 'BrainBattle Mix – Lo-fi Study',
        likes: 100 + i * 7,
        comments: 12 + i,
        liked: false,
      );
    });
  }
}
