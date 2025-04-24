import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../controllers/countdown_controller.dart';
import '../data/models/match_model.dart';

void showMatchCountdownPopup(BuildContext context, MatchModel match) {
  final controller = Get.put(CountdownController());
  controller.startCountdown(match.matchDate, match.matchTime);

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  width: 40.w,
                  // height: 25.h,
                  fit: BoxFit.contain,
                  imageUrl: match.homeTeamLogo,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Skeletonizer(
                    enableSwitchAnimation: true,
                    enabled: true,
                    child: SizedBox(
                      width: 25.w,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(width: 16),
                const Text('VS', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 16),
                CachedNetworkImage(
                  width: 40.w,
                  // height: 25.h,
                  fit: BoxFit.contain,
                  imageUrl: match.awayTeamLogo,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Skeletonizer(
                    enableSwitchAnimation: true,
                    enabled: true,
                    child: SizedBox(
                      width: 25.w,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${match.homeTeam} vs ${match.awayTeam}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.statusText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.formattedTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      width: 25.w,
                      // height: 25.h,
                      fit: BoxFit.contain,
                      imageUrl: match.leagueLogo,
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
                    const SizedBox(width: 8),
                    Text(
                      match.league,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (match.channelsAndCommentators.isNotEmpty &&
                    match.channelsAndCommentators.first.channel !=
                        'Referee') ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FittedBox(
                          child: Text(
                            match.channelsAndCommentators.first.commentator,
                            style: TextStyle(
                                color: ColorsManager.lightSecondary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        horizontalSpace(5),
                        Skeleton.shade(
                            child: Icon(Icons.mic,
                                color: Colors.grey, size: 15.dm)),
                        const Spacer(),
                        FittedBox(
                          child: Text(
                            match.channelsAndCommentators.first.channel,
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
                            child: Icon(Icons.mic,
                                color: Colors.grey, size: 15.dm)),
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
            )),

        // actions: [
        //   TextButton(
        //     onPressed: () => Navigator.of(context).pop(),
        //     child: const Text('CLOSE', style: TextStyle(color: Colors.white)),
        //   ),
        // ],
      );
    },
  ).then((_) {
    // Clean up when dialog is dismissed
    Get.delete<CountdownController>();
  });
}
