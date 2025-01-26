import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/localization/constants.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../controllers/today_matches_controller.dart';
import '../controllers/video_player_conteroller.dart';
import '../data/models/league_model.dart';
import '../data/models/match_model.dart';
import 'video_player_screen.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: ColorsManager.mainBlack,
        //   centerTitle: true,
        //   title: const LogoCardWidget(width: 150, height: 53),
        //   iconTheme: const IconThemeData(
        //     color: Theme.of(context).colorScheme.surface, // Change this to your desired color
        //   ),
        //   actions: [
        //     GetBuilder<TodayMatchesController>(
        //       builder: (controller) {
        //         return IconButton(
        //           icon: Badge(
        //             isLabelVisible: controller.selectedLeagues.isNotEmpty,
        //             label: Text(controller.selectedLeagues.length.toString()),
        //             child: const Icon(Icons.filter_list_alt,
        //                 color: Theme.of(context).colorScheme.surface),
        //           ),
        //           onPressed: () => showFilterBottomSheet(context),
        //         );
        //       },
        //     ),
        //   ],
        // ),
        // drawer: CustomDrawerWidget(),
        body: GetBuilder<TodayMatchesController>(
            // init: TodayMatchesController(),
            builder: (controller) {
      return RefreshIndicator(
        onRefresh: () async {
          controller.getAllTodayMatches();
        },
        child: Skeletonizer(
          enabled: controller.statusReq == StatusRequest.loading,
          // enabled: true,
          enableSwitchAnimation: true,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
            itemCount: controller.filteredLeaguesList.length,
            itemBuilder: (context, index) {
              return LeagueSectionWidget(
                  league: controller.filteredLeaguesList[index]);
            },
          ),
        ),
      );
    }));
  }
}

class LeagueSectionWidget extends StatelessWidget {
  final LeagueModel league;
  const LeagueSectionWidget({
    super.key,
    required this.league,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 10,
          color: Theme.of(context).colorScheme.surface,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            child: Row(
              children: [
                if (league.leagueLogo.isNotEmpty)
                  CachedNetworkImage(
                    width: 15.w,
                    fit: BoxFit.contain,
                    imageUrl: league.leagueLogo,
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
                horizontalSpace(15),
                Text(
                  league.league,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                horizontalSpace(15),
                Skeleton.shade(
                  child: Icon(Icons.emoji_events,
                      color: Colors.yellow.shade500, size: 15.dm),
                ),
              ],
            ),
          ),
        ),
        ...league.matches.map((match) => MatchCardWidget2(event: match)),
      ],
    );
  }
}

class MatchCardWidget2 extends GetView<TodayMatchesController> {
  const MatchCardWidget2({
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
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.homeTeam,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                  horizontalSpace(15),
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
                  horizontalSpace(15),
                  Card(
                    elevation: 5,
                    color: Theme.of(context).colorScheme.surface,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
                      child: Text(
                        event.matchTime,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  horizontalSpace(15),
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
                  horizontalSpace(15),
                  Text(
                    event.awayTeam,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
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
                            color: Theme.of(context).colorScheme.secondary,
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
                          event.channelsAndCommentators.first.channel,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
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
                            color: Theme.of(context).colorScheme.secondary,
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
                            color: Theme.of(context).colorScheme.secondary,
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

// void showFilterBottomSheet(BuildContext context) {
//   final controllers = Get.find<TodayMatchesController>();
//   Get.bottomSheet(
//     Container(
//       decoration: const BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Filter Leagues',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     color: ColorsManager.mainBlack,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () => Get.back(),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: GetBuilder<TodayMatchesController>(
//               builder: (controller) => ListView.builder(
//                 itemCount: controller.leaguesList.length,
//                 itemBuilder: (context, index) {
//                   final league = controller.leaguesList[index];
//                   return CheckboxListTile(
//                     controlAffinity: ListTileControlAffinity.trailing,
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                     title: Text(league.league),
//                     secondary: CachedNetworkImage(
//                       width: 40,
//                       height: 40,
//                       imageUrl: league.leagueLogo,
//                       placeholder: (context, url) =>
//                           const CircularProgressIndicator(
//                         color: Theme.of(context).colorScheme.secondary,
//                         strokeWidth: 2,
//                       ),
//                       errorWidget: (context, url, error) => const Icon(
//                         Icons.sports_soccer,
//                         color: Theme.of(context).colorScheme.secondary,
//                       ),
//                     ),
//                     value: controller.selectedLeagues.contains(league.league),
//                     onChanged: (_) =>
//                         controller.toggleLeagueSelection(league.league),
//                     activeColor: Theme.of(context).colorScheme.secondary,
//                     checkboxShape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: controllers.clearFilters,
//                   child: const Text('Clear Filters'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   child: const Text('Apply Filters'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
