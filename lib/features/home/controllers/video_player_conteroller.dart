import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';

import '../../../core/helpers/enums.dart';

class VideoPlayerConteroller extends GetxController {
  late StatusRequest statusReq;
  late VlcPlayerController vlcController;
  late String videoUrls;

  Future disposevlcController() async {
    await setAllOrientationsTopPrtrait();
    Get.back();
    vlcController.dispose();
  }

  Future initVlcControlle({required String videoUrl}) async {
    videoUrls = videoUrl;
    await setAllOrientationsToLandscape();
    statusReq = StatusRequest.loading;
    update();
    vlcController = VlcPlayerController.network(
      videoUrl,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );

    statusReq = StatusRequest.success;
    update();
  }

  Future setAllOrientationsToLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.bottom
      ], // Show only the bottom (navigation bar)
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future setAllOrientationsTopPrtrait() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
}
