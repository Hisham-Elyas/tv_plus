import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String channelName;
  final String videoUrl;

  const VideoPlayerScreen({
    required this.channelName,
    required this.videoUrl,
    super.key,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channelName),
      ),
      body: Column(
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          Center(
            child: Text(
              'Now playing on ${widget.channelName}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
