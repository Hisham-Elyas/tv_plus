import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/localization/constants.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../controllers/leagues_controller.dart';
import '../data/models/leagues_response_model.dart';
import 'league_detail_screen.dart';

class LeaguesScreen extends StatelessWidget {
  const LeaguesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaguesController>(
      init: LeaguesController(),
      builder: (controller) => RefreshIndicator(
        onRefresh: () async {
          controller.getAllLeagues();
        },
        child: Skeletonizer(
          enabled: controller.statusReq.value == StatusRequest.loading,
          enableSwitchAnimation: true,
          child: controller.statusReq.value == StatusRequest.serverFailure
              // if server error
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Please_try_agein_later.tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            controller.getAllLeagues();
                          },
                          child: Text(TryAgain.tr))
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: controller.getLeagues.length,
                    itemBuilder: (context, index) {
                      final LeagueData league = controller.getLeagues[index];
                      return _LeagueListTile(
                        league: league,
                        onTap: () {
                          // Navigate to league detail screen
                          if (league.currentSeason != null) {
                            Get.to(() => LeagueDetailScreen(
                                  leagueid: league.id,
                                  leagueName: league.name,
                                  leagueImageUrl: league.imagePath,
                                  seasonId: league.currentSeason!.id,
                                ));
                          } else {
                            // Show message to user that this league has no current season
                            showCustomSnackBar(
                              message: NoActiveSeasonMessage.tr,
                              title: NoActiveSeason.tr,
                            );
                          }
                        },
                        isFavorite: controller.isFavorite(league.id),
                        onFavoriteTap: () {
                          controller.toggleFavorite(league.id);
                        },
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}

class _LeagueListTile extends StatelessWidget {
  final LeagueData league;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const _LeagueListTile({
    required this.league,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: Card(
        shadowColor: ColorsManager.lightSecondary,
        elevation: 3,
        color: Theme.of(Get.context!).colorScheme.surface.withOpacity(0.7),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: Row(
              children: [
                CachedNetworkImage(
                  width: 50.w,
                  height: 50.w,
                  imageUrl: league.imagePath,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (_, __, ___) => Skeletonizer(
                    enabled: true,
                    child: Icon(Icons.sports_soccer, size: 30.dm),
                  ),
                  errorWidget: (_, __, ___) => Icon(
                    Icons.broken_image,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    league.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // IconButton(
                //   icon: Icon(
                //     isFavorite ? Icons.star : Icons.star_border,
                //     color: isFavorite
                //         ? Colors.amber
                //         : Theme.of(context)
                //             .colorScheme
                //             .onSurface
                //             .withOpacity(0.6),
                //   ),
                //   onPressed: onFavoriteTap,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
