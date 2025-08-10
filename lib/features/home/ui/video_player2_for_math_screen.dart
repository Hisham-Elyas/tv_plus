import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_player/modern_player.dart';

import '../../../core/localization/constants.dart';
import '../controllers/video_player_conteroller.dart';
import '../data/models/fixture_detail_model.dart' show TvChannelLink;

class VideoPlayer2ForMathScreen extends StatefulWidget {
  final List<TvChannelLink> channel;
  const VideoPlayer2ForMathScreen({
    super.key,
    required this.channel,
  });

  @override
  State<VideoPlayer2ForMathScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayer2ForMathScreen> {
  @override
  void dispose() async {
    super.dispose();
    await Get.find<VideoPlayerConteroller>().setAllOrientationsTopPrtrait();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<VideoPlayerConteroller>(
          builder: (controller) => ModernPlayer.createPlayer(
              video: ModernPlayerVideo.multiple([
                ModernPlayerVideoData.network(
                  label: "Default",
                  url: controller.videoUrls ?? widget.channel.first.url,
                ),
                ...widget.channel.map((e) => ModernPlayerVideoData.network(
                      label: "${server.tr} : ${e.name}",
                      url: e.url,
                    ))
              ]),
              callbackOptions: ModernPlayerCallbackOptions(
                onBackPressed: () async {
                  await controller.disposevlcController();
                },
                onMenuPressed: () {},
              ),
              controlsOptions: ModernPlayerControlsOptions(
                showBackbutton: true,
                // showControls: false,
                showBottomBar: false,
                doubleTapToSeek: false,
                showMenu: true,
              ),
              subtitles: [],
              audioTracks: [],
              themeOptions: ModernPlayerThemeOptions(),
              translationOptions:
                  ModernPlayerTranslationOptions.menu(qualityHeaderText: ''),
              options: ModernPlayerOptions(
                allowScreenSleep: false,
                autoVisibilityPause: false,
                // videoStartAt: 5000 // in milliseconds
              ))
          // VlcPlayer(
          //   // virtualDisplay: false,
          //   controller: controller.vlcController,
          //   aspectRatio: 16 / 9,
          //   placeholder: const Center(child: CircularProgressIndicator()),
          // ),
          ),
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
