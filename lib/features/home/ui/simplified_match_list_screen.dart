import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../core/helpers/enums.dart';
import '../../../core/localization/constants.dart';
import '../../../core/theming/colors.dart';
import '../controllers/fixtures_controller.dart';
import '../data/models/fixtures_model.dart';
import 'fixture_detail_screen.dart';
import 'league_detail_screen.dart';

class SimplifiedMatchListScreen extends StatelessWidget {
  SimplifiedMatchListScreen({super.key});

  final FixturesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final status = controller.statusReq.value;

      // 🔴 Server failure screen
      if (status == StatusRequest.serverFailure) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ServerError.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              ElevatedButton(
                onPressed: controller.getAllTodayMatches,
                child: Text(TryAgain.tr),
              ),
            ],
          ),
        );
      }

      // 🦴 Skeletonizer Wrap
      return Skeletonizer(
        enabled: status == StatusRequest.loading,
        enableSwitchAnimation: true,
        child: RefreshIndicator(
          onRefresh: () => controller.getAllTodayMatches(isRefresh: true),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// 🗓 Date
              Obx(() => Text(
                    controller.formattedDisplayDate,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )),
              const SizedBox(height: 12),

              /// 🔍 No data
              if (status == StatusRequest.noData)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text(NoMatchesFoundForDate.tr),
                  ),
                )
              else if (controller.filteredFixtures.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text(NoMatchesFoundForSelectedFilters.tr),
                  ),
                )
              else
                ...controller.filteredFixtures
                    .map((league) => matchGroup(league, league.today)),
            ],
          ),
        ),
      );
    });
  }

  /// Match Group Title + Cards
  Widget matchGroup(League league, List<Fixture> fixtures) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => LeagueDetailScreen(
                  leagueid: league.id,
                  leagueImageUrl: league.imagePath,
                  leagueName: league.name,
                  seasonId: fixtures.first.seasonId,
                ));
          },
          child: Card(
            shadowColor: ColorsManager.lightSecondary,
            elevation: 10,
            color: Theme.of(Get.context!).colorScheme.surface,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// 🏆 League Image + Name
                  Row(
                    children: [
                      /// League Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          width: 24.w,
                          fit: BoxFit.contain,
                          imageUrl: league.imagePath,
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
                      ),
                      const SizedBox(width: 8),

                      /// League Name
                      Text(
                        league.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const Icon(Icons.more_horiz),
                ],
              ),
            ),
          ),
        ),

        /// 🏟 Match Cards
        ...fixtures.map((fixture) => matchCard(fixture)),
      ],
    );
  }

  /// Single Match Card
  Widget matchCard(Fixture fixture) {
    final home =
        fixture.participants.firstWhereOrNull((e) => e.location == 'home');
    final away =
        fixture.participants.firstWhereOrNull((e) => e.location == 'away');

    if (home == null || away == null) return const SizedBox();

    final homeScore = fixture.scores
        .firstWhereOrNull(
            (s) => s.typeId == 1525 && s.score.participant == 'home')
        ?.score
        .goals;
    final awayScore = fixture.scores
        .firstWhereOrNull(
            (s) => s.typeId == 1525 && s.score.participant == 'away')
        ?.score
        .goals;

    final now = controller.currentTime.value;
    if (now == null) {
      return const SizedBox();
    }
    final matchStart = DateTime.tryParse(fixture.startingAt);
    final loc = tz.getLocation(controller.fixtureTimezone.value!);
    final start = matchStart!.isUtc
        ? tz.TZDateTime.from(matchStart, loc)
        : tz.TZDateTime(loc, matchStart.year, matchStart.month, matchStart.day,
            matchStart.hour, matchStart.minute, matchStart.second);

    final hasStarted = now.isAfter(start);

    return InkWell(
      onTap: () => Get.to(() => MatchDetailScreen(
            fixtureId: fixture.id.toString(),
            channelCommmId: fixture.channelCommmId.toString(),
          )),
      child: Card(
        elevation: 2,
        borderOnForeground: false,
        shadowColor: ColorsManager.lightSecondary,
        color: Theme.of(Get.context!).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            children: [
              Expanded(
                  child: teamInfo(home.name, home.imagePath, TextAlign.right)),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasStarted && homeScore != null && awayScore != null)
                    Card(
                        elevation: 3,
                        shadowColor: ColorsManager.lightSecondary,
                        color: Theme.of(Get.context!).colorScheme.surface,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            "$homeScore - $awayScore",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        ))
                  else
                    Card(
                      elevation: 3,
                      shadowColor: ColorsManager.lightSecondary,
                      color: Theme.of(Get.context!).colorScheme.surface,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 1.h),
                        child: Text(
                          matchStart != null
                              ? DateFormat('hh:mm a').format(matchStart)
                              : "--:--",
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                  child: teamInfo(away.name, away.imagePath, TextAlign.left)),
            ],
          ),
        ),
      ),
    );
  }

  // Team Info (Logo + Name)
  Widget teamInfo(String name, String logoUrl, TextAlign align) {
    return Row(
      mainAxisAlignment: align == TextAlign.left
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        SizedBox(width: 8.w),
        if (align == TextAlign.left)
          CachedNetworkImage(
            width: 24.w,
            fit: BoxFit.contain,
            imageUrl: logoUrl,
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
        SizedBox(width: 15.w),
        Flexible(
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp),
          ),
        ),
        SizedBox(width: 15.w),
        if (align == TextAlign.right)
          CachedNetworkImage(
            width: 24.w,
            fit: BoxFit.contain,
            imageUrl: logoUrl,
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
        SizedBox(width: 8.w),
      ],
    );
  }
}
