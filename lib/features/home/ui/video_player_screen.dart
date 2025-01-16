import 'package:flick_video_player/flick_video_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String? videoUrl;
  const VideoPlayerScreen({super.key, this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VlcPlayerController _vlcController;
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    _vlcController = VlcPlayerController.network(
      widget.videoUrl ??
          "http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544835",
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );

    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
      Uri.parse(
        //"https://live.alarabiya.net/alarabiapublish/aswaaq.smil/playlist.m3u8?checkedby:iptvcat.com", // alarabi apublish
        widget.videoUrl ??
            "http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544835", // beIM sport 1
      ),
    ));
  }

  @override
  void dispose() {
    _vlcController.dispose();
    setAllOrientations();
    flickManager.dispose();
    super.dispose();
  }

  Future setAllOrientations() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return VlcPlayer(
      virtualDisplay: false,
      controller: _vlcController,
      aspectRatio: 16 / 9,
      placeholder: const Center(child: CircularProgressIndicator()),
    );

    //  FlickVideoPlayer(
    //   flickManager: flickManager,
    //   preferredDeviceOrientationFullscreen: const [
    //     DeviceOrientation.landscapeLeft,
    //     DeviceOrientation.landscapeRight,
    //   ],
    //   wakelockEnabledFullscreen: true,
    //   systemUIOverlay: const [SystemUiOverlay.bottom],
    //   systemUIOverlayFullscreen: const [SystemUiOverlay.bottom],
    //   preferredDeviceOrientation: const [
    //     DeviceOrientation.landscapeLeft,
    //     DeviceOrientation.landscapeRight,
    //   ],
    //   flickVideoWithControls: FlickVideoWithControls(
    //     controls: FlickPortraitControls(
    //       iconSize: 40,
    //       progressBarSettings: FlickProgressBarSettings(
    //         height: 5,
    //         handleRadius: 8,
    //         playedColor: Colors.red,
    //       ),
    //     ),
    //     iconThemeData: const IconThemeData(
    //       color: Colors.grey,
    //     ),
    //   ),
    // );
  }
}
