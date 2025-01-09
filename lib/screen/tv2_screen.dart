// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoPlayerScreen2 extends StatefulWidget {
  final String url;
  const VideoPlayerScreen2({
    super.key,
    required this.url,
  });

  @override
  _VideoPlayerScreen2State createState() => _VideoPlayerScreen2State();
}

class _VideoPlayerScreen2State extends State<VideoPlayerScreen2> {
  late VlcPlayerController _videoPlayerController;

  Future<void> initializePlayer() async {}

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VlcPlayerController.network(
      widget.url,
      // "http://7b30f9aa.tvclub.xyz/iptv/SGME6W4L2A6MNZ/6131/index.m3u8?checkedby:iptvcat.com",
      // "https://live.alarabiya.net/alarabiapublish/aswaaq.smil/playlist.m3u8?checkedby:iptvcat.com",
      hwAcc: HwAcc.full,
      // autoPlay: false,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: VlcPlayer(
            virtualDisplay: false,
            controller: _videoPlayerController,
            aspectRatio: 16 / 9,
            placeholder: const Center(child: CircularProgressIndicator()),
          ),
        ));
  }
}
