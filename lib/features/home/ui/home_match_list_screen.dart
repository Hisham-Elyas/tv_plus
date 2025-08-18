import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/localization/constants.dart';
import '../../../core/theming/colors.dart';
import '../controllers/fixtures_controller.dart';
import '../data/models/fixtures_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';
import 'fixture_detail_screen.dart';
import 'league_detail_screen.dart';

class MatchListScreen extends StatelessWidget {
  MatchListScreen({super.key});

  final FixturesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerWidget(),
      appBar: CustomAppBar(
        title: appName,
        actions: [
          Obx(() => IconButton(
                icon: Badge(
                  isLabelVisible: controller.selectedLeagues.isNotEmpty,
                  label: Text(controller.selectedLeagues.length.toString()),
                  child: Icon(Icons.filter_list_alt,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                onPressed: () {
                  showFilterBottomSheet(context);
                },
              )),
          IconButton(
            onPressed: controller.previousDay,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => controller.pickDate(context),
          ),
          IconButton(
            onPressed: controller.nextDay,
            icon: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
      body: Obx(() {
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
                  ))
                else
                  ...controller.filteredFixtures
                      .map((league) => matchGroup(league, league.today)),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// Match Group Title + Cards
  Widget matchGroup(League league, List<Fixture> fixtures) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => LeagueDetailScreen(
                  leagueImageUrl: league.imagePath,
                  leagueName: league.name,
                  seasonId: fixtures.first.seasonId,
                  leagueid: league.id,
                ));
          },
          child: Card(
            shadowColor: ColorsManager.lightSecondary,
            // surfaceTintColor: Theme.of(context).colorScheme.secondary,
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
    // print(fixture.scores.toString());

    // final now = DateTime.now();
    final now = controller.currentTime.value;
    if (now == null) {
      return const SizedBox(); // or a loading spinner
    }
    final matchStart = DateTime.tryParse(fixture.startingAt);
    final loc = tz.getLocation(controller.fixtureTimezone.value!);
    final start = matchStart!.isUtc
        ? tz.TZDateTime.from(matchStart, loc)
        : tz.TZDateTime(loc, matchStart.year, matchStart.month, matchStart.day,
            matchStart.hour, matchStart.minute, matchStart.second);

    final hasStarted = now.isAfter(start);

    return InkWell(
      // onTap: () => Get.to(() => const MatchDetailsScreen()),
      onTap: () => Get.to(() => MatchDetailScreen(
            fixtureId: fixture.id.toString(),
            channelCommmId: fixture.channelCommmId.toString(),
          )),
      child: Card(
        // margin: const EdgeInsets.all(10),
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
                          // ignore: unnecessary_null_comparison
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
          // Image.network(logoUrl, width: 24, height: 24,
          //     errorBuilder: (context, error, stackTrace) {
          //   return const Icon(Icons.error, size: 20);
          // }),
          CachedNetworkImage(
            width: 24.w,
            // height: 25.h,
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
            // overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 12.sp),
          ),
        ),
        SizedBox(width: 15.w),
        if (align == TextAlign.right)
          // Image.network(logoUrl, width: 24, height: 24,
          //     errorBuilder: (context, error, stackTrace) {
          //   return const Icon(Icons.error, size: 20);
          // }),
          CachedNetworkImage(
            width: 24.w,
            // height: 25.h,
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

void showFilterBottomSheet(BuildContext context) {
  final controller = Get.find<FixturesController>();
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FilterLeagues.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<FixturesController>(
              builder: (controller) => ListView.builder(
                itemCount: controller.fixtures.length,
                itemBuilder: (context, index) {
                  final league = controller.fixtures[index];
                  return Card(
                    elevation: 5,
                    shadowColor: Colors.grey.shade300,
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.platform,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      title: Text(league.name),
                      secondary: CachedNetworkImage(
                        width: 30.w,
                        height: 30.h,
                        imageUrl: league.imagePath,
                        placeholder: (context, url) => Skeletonizer(
                          enabled: true,
                          child: Icon(Icons.sports_soccer, size: 30.dm),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.broken_image,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      value: controller.selectedLeagues.contains(league.id),
                      onChanged: (_) =>
                          controller.toggleLeagueFilter(league.id),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.dm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: controller.clearFilters,
                  child: Text(Clear.tr), // or Clear.tr
                ),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text(Apply.tr), // or Apply.tr
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
