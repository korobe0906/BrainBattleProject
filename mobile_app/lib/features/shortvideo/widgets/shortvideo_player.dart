import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ShortVideoPlayer extends StatefulWidget {
  final String url;
  final String thumbnail;

  // báo cho parent biết tổng thời lượng & controller để seek/volume
  final ValueChanged<Duration>? onReady;
  final ValueChanged<VideoPlayerController>? onController;
  final ValueChanged<Duration>? onProgress;

  const ShortVideoPlayer({
    super.key,
    required this.url,
    required this.thumbnail,
    this.onReady,
    this.onController,
    this.onProgress,
  });

  @override
  State<ShortVideoPlayer> createState() => _ShortVideoPlayerState();
}

class _ShortVideoPlayerState extends State<ShortVideoPlayer> {
  late VideoPlayerController _controller;
  bool _showHeart = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..setLooping(true)
      ..initialize().then((_) {
        if (!mounted) return;
        widget.onController?.call(_controller);
        widget.onReady?.call(_controller.value.duration);
        setState(() {});
        _controller.play();
      });

    _controller.addListener(() {
      if (widget.onProgress != null && _controller.value.isInitialized) {
        widget.onProgress!.call(_controller.value.position);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (!_controller.value.isInitialized) return;
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
  }

  void _doubleTapLike() {
    setState(() => _showHeart = true);
    Future.delayed(const Duration(milliseconds: 700),
        () => mounted ? setState(() => _showHeart = false) : null);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('vp-${widget.url}-${Random().nextInt(99999)}'),
      onVisibilityChanged: (info) {
        if (!_controller.value.isInitialized) return;
        final visible = info.visibleFraction > 0.6;
        if (visible && !_controller.value.isPlaying) {
          _controller.play();
        } else if (!visible && _controller.value.isPlaying) {
          _controller.pause();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(imageUrl: widget.thumbnail, fit: BoxFit.cover),
          if (_controller.value.isInitialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _togglePlayPause,
            onDoubleTap: _doubleTapLike,
          ),
          if (!_controller.value.isPlaying)
            const Center(
              child: Icon(Icons.play_arrow, size: 72, color: Colors.white70),
            ),
          IgnorePointer(
            child: AnimatedOpacity(
              opacity: _showHeart ? 1 : 0,
              duration: const Duration(milliseconds: 150),
              child: const Center(
                child: Icon(Icons.favorite,
                    color: Colors.pinkAccent, size: 120),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
