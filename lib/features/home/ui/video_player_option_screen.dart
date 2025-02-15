import 'package:faisal_tv/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';

import '../controllers/video_player_conteroller.dart';
import '../data/models/category_model.dart';
import '../widgets/custom_app_bar.dart';
import 'video_player_screen.dart';

class VideoPlayerOptionScreen extends StatefulWidget {
  final Channel channel;
  const VideoPlayerOptionScreen({
    super.key,
    required this.channel,
  });

  @override
  State<VideoPlayerOptionScreen> createState() =>
      _VideoPlayerOptionScreenState();
}

class _VideoPlayerOptionScreenState extends State<VideoPlayerOptionScreen> {
  @override
  void initState() {
    Get.find<VideoPlayerConteroller>().vlcController =
        VlcPlayerController.network(
      widget.channel.urlList[0].url,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    Get.find<VideoPlayerConteroller>().isPlaying == true;
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await Get.find<VideoPlayerConteroller>().setAllOrientationsTopPrtrait();
    await Get.find<VideoPlayerConteroller>().vlcController.dispose();
    Get.find<VideoPlayerConteroller>().urlIndex = 0;
    Get.find<VideoPlayerConteroller>().isPlaying == false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.channel.customName,
      ),
      body: GetBuilder<VideoPlayerConteroller>(
        builder: (controller) => Column(
          children: [
            verticalSpace(45),
            Container(
              margin: EdgeInsetsDirectional.symmetric(
                  horizontal: 10.w, vertical: 30.h),
              height: 45.h,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                itemCount: widget.channel.urlList.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsetsDirectional.only(start: 10.w),
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () {
                      controller.setUrlInVlcController(
                          index: index, url: widget.channel.urlList[index].url);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 700),
                      // margin: EdgeInsetsDirectional.only(start: 10.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: controller.urlIndex == index
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.surface,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Text(
                          // "${server.tr} ${index + 1}",
                          widget.channel.urlList[index].name,
                          style: TextStyle(
                            fontSize: 12.sp,
                          )),
                    ),
                  );
                },
              ),
            ),
            Stack(
              children: [
                VlcPlayer(
                  // virtualDisplay: false,
                  controller: controller.vlcController,
                  aspectRatio: 16 / 9,
                  placeholder: const Center(child: CircularProgressIndicator()),
                ),
                Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: IconButton(
                      onPressed: () async {
                        Get.to(() => VideoPlayerScreen(
                              channel: widget.channel,
                            ));

                        await Get.find<VideoPlayerConteroller>()
                            .setAllOrientationsToLandscape();
                        controller.vlcController.pause();
                        controller.isPlaying == false;
                      },
                      icon: const Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                      ),
                      color: Theme.of(context).colorScheme.onSurface,
                      iconSize: 30.sp,
                    )),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: controller.togglePlayPause,
                    child: Icon(
                        controller.isPlaying ? Icons.pause : Icons.play_arrow),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
