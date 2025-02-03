import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/localization/constants.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../controllers/today_matches_controller.dart';
import '../controllers/video_player_conteroller.dart';
import '../data/models/match_model.dart';
import '../ui/video_player_screen.dart';

class MatchCardWidget extends GetView<TodayMatchesController> {
  const MatchCardWidget({
    super.key,
    required this.event,
  });

  final MatchModel event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (event.channelsAndCommentators.isEmpty) {
          showCustomSnackBar(
              message: ChannelUnknown.tr,
              title: Channel_not_found.tr,
              isError: true);
          return;
        }
        try {
          final channel = controller
              .findChannelByName(event.channelsAndCommentators.first.channel);

          Get.to(() => VideoPlayerScreen(
                videoUrl: channel.videoUrl,
              ));

          // Future.delayed(
          //   const Duration(seconds: 1),
          //   () async {
          await Get.find<VideoPlayerConteroller>()
              .setAllOrientationsToLandscape();
          // },
          // );
          log('Found: ${channel.name}, Video URL: ${channel.videoUrl}');
        } catch (e) {
          log(e.toString()); // Handle exception
        }

        // Get.to(() => const VideoPlayerScreen());
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const VideoPlayerScreen()),
        // );
      },
      child: Card(
        // margin: const EdgeInsets.all(10),
        elevation: 3,
        shadowColor: ColorsManager.lightSecondary,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 85.w,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        event.homeTeam,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  horizontalSpace(5),
                  CachedNetworkImage(
                    width: 25.w,
                    // height: 25.h,
                    fit: BoxFit.contain,
                    imageUrl: event.homeTeamLogo,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Skeletonizer(
                      enableSwitchAnimation: true,
                      enabled: true,
                      child: SizedBox(
                        width: 25.w,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  horizontalSpace(5),
                  Card(
                    elevation: 3,
                    shadowColor: ColorsManager.lightSecondary,
                    color: Theme.of(context).colorScheme.surface,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
                      child: Text(
                        controller.getMatchStatusWithColor(event).status,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color:
                                controller.getMatchStatusWithColor(event).color,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  horizontalSpace(5),
                  CachedNetworkImage(
                    width: 25.w,
                    // height: 80.h,
                    fit: BoxFit.contain,
                    imageUrl: event.awayTeamLogo,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Skeletonizer(
                      enableSwitchAnimation: true,
                      enabled: true,
                      child: SizedBox(
                        width: 25.w,
                      ),
                    ),

                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  horizontalSpace(5),
                  SizedBox(
                    width: 85.w,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        event.awayTeam,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        // softWrap: true,
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(2.h),
              if (event.channelsAndCommentators.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        child: Text(
                          event.channelsAndCommentators.first.commentator,
                          style: TextStyle(
                              color: ColorsManager.lightSecondary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      horizontalSpace(5),
                      Skeleton.shade(
                          child:
                              Icon(Icons.mic, color: Colors.grey, size: 15.dm)),
                      const Spacer(),
                      FittedBox(
                        child: Text(
                          event.channelsAndCommentators.first.channel,
                          style: TextStyle(
                              color: ColorsManager.lightSecondary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      horizontalSpace(5),
                      Skeleton.shade(
                        child: Icon(Icons.live_tv_outlined,
                            color: Colors.grey, size: 15.dm),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        child: Text(
                          'Unknown',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      horizontalSpace(5),
                      Skeleton.shade(
                          child:
                              Icon(Icons.mic, color: Colors.grey, size: 15.dm)),
                      const Spacer(),
                      FittedBox(
                        child: Text(
                          'Unknown',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      horizontalSpace(5),
                      Skeleton.shade(
                        child: Icon(Icons.live_tv_outlined,
                            color: Colors.grey, size: 15.dm),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
