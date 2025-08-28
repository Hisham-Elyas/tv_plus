// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../core/helpers/enums.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/localization/constants.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../controllers/fixture_detail_controller.dart';
import '../controllers/video_player_conteroller.dart';
import '../data/models/fixture_detail_model.dart';
import 'video_player2_for_math_screen.dart';

class MatchDetailScreen extends StatelessWidget {
  final String fixtureId;
  final String channelCommmId;

  const MatchDetailScreen(
      {super.key, required this.fixtureId, required this.channelCommmId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FixtureDetailController());
    controller.loadFixture(
        fixtureId: fixtureId, channelCommmId: channelCommmId);

    return Scaffold(
      // backgroundColor: Colors.white,
      body: Obx(() {
        final status = controller.statusReq.value;
        // 🔴 Server failure screen
        final FixtureDetail fixture = controller.fixture.value!;

        if (status == StatusRequest.serverFailure) {
          return Center(
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
                  onPressed: () => controller.loadFixture(
                      fixtureId: fixtureId, channelCommmId: channelCommmId),
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
            onRefresh: () => controller.loadFixture(
                fixtureId: fixtureId, channelCommmId: channelCommmId),
            child: Column(
              children: [
                /// Header + Tabs
                MatchHeader(
                  fixture: fixture,
                  selectedIndex: controller.selectedTabIndex.value,
                  onTabSelected: controller.changeTab,
                ),

                /// Tab content
                Expanded(
                  child: Obx(() {
                    final index = controller.selectedTabIndex.value;
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      child: IndexedStack(
                        key: ValueKey(index),
                        index: index,
                        children: [
                          _eventsTab(fixture),
                          MatchPreviewWidget(fixture: fixture),
                          _statisticsTab(fixture),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _eventsTab(FixtureDetail fixture) {
    final events = fixture.events;

    if (events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("📅", style: TextStyle(fontSize: 48)),
            SizedBox(height: 12),
            Text(NoEventsAvailable.tr),
            Text(MatchEventsContentHere.tr),
          ],
        ),
      );
    }

    final teamA = fixture.participants[0];
    // ignore: unused_local_variable
    final teamB = fixture.participants[1];

    // Group events by period description (e.g., '2nd Half', '1st Half')
    Map<String, List<Event>> eventsByPeriod = {};
    for (var e in events) {
      final period = e.period.description.toUpperCase();
      if (!eventsByPeriod.containsKey(period)) {
        eventsByPeriod[period] = [];
      }
      eventsByPeriod[period]!.add(e);
    }

    // Define the order of periods to display (2ND HALF first, then 1ST HALF)
    final periodOrder = ["2ND HALF", "1ST HALF"];
    // Sort otherPeriods in reverse order to show latest periods first
    final otherPeriods = eventsByPeriod.keys
        .where((k) => !periodOrder.contains(k))
        .toList()
      ..sort((a, b) => b.compareTo(a));
    // Keep only periods that exist in eventsByPeriod
    final displayPeriods = [
      ...periodOrder.where((p) => eventsByPeriod.containsKey(p)),
      ...otherPeriods
    ];

    IconData getEventIcon(String type) {
      switch (type.toLowerCase()) {
        case 'goal':
          return Icons.sports_soccer;
        case 'yellowcard':
        case 'yellow card':
          return Icons.crop_square;
        case 'redcard':
        case 'red card':
          return Icons.stop;
        case 'substitution':
          return Icons.sync_alt;
        default:
          return Icons.info_outline;
      }
    }

    Color getEventColor(String type) {
      switch (type.toLowerCase()) {
        case 'goal':
          return Colors.green;
        case 'yellowcard':
        case 'yellow card':
          return Colors.amber;
        case 'redcard':
        case 'red card':
          return Colors.red;
        case 'substitution':
        case 'Substitution':
          return Colors.blue;
        default:
          return Colors.grey;
      }
    }

    Widget buildEventItem(Event e, bool isLeft) {
      final icon = getEventIcon(e.type.name);
      final color = getEventColor(e.type.name);
      final text = e.relatedPlayerName != null
          ? '${e.playerName} ➜ ${e.relatedPlayerName}'
          : e.playerName ?? e.type.name;

      final note =
          e.addition != null && e.addition!.isNotEmpty ? e.addition : e.info;

      final imageUrl = e.player?.imagePath;

      final sideWidget = Flexible(
        child: Align(
          alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: Column(
            crossAxisAlignment:
                isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isLeft) ...[
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: color,
                      backgroundImage:
                          imageUrl != null ? NetworkImage(imageUrl) : null,
                      child: imageUrl == null
                          ? Icon(icon, color: Colors.white, size: 14)
                          : null,
                    ),
                    const SizedBox(width: 4),
                    Flexible(child: Text(text)),
                  ] else ...[
                    Flexible(child: Text(text)),
                    const SizedBox(width: 4),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: color,
                      backgroundImage:
                          imageUrl != null ? NetworkImage(imageUrl) : null,
                      child: imageUrl == null
                          ? Icon(icon, color: Colors.white, size: 14)
                          : null,
                    ),
                  ],
                ],
              ),
              if (note != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    note,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                )
            ],
          ),
        ),
      );

      final middleTime = Text(
        e.extraMinute != null
            ? '${e.minute}+${e.extraMinute}\''
            : '${e.minute}\'',
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: isLeft
              ? [
                  sideWidget,
                  const SizedBox(width: 8),
                  middleTime,
                  const SizedBox(width: 8),
                  const Spacer()
                ]
              : [
                  const Spacer(),
                  const SizedBox(width: 8),
                  middleTime,
                  const SizedBox(width: 8),
                  sideWidget
                ],
        ),
      );
    }

    // Build the list of widgets with section headers
    List<Widget> eventWidgets = [];
    for (final period in displayPeriods) {
      final periodEvents = eventsByPeriod[period];
      if (periodEvents == null || periodEvents.isEmpty) continue;

      // Sort events in this period by total time descending (latest event first)
      final sorted = [...periodEvents]..sort((a, b) {
          final aTotal = a.minute + (a.extraMinute ?? 0);
          final bTotal = b.minute + (b.extraMinute ?? 0);
          return bTotal.compareTo(aTotal);
        });

      // Section header
      eventWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(thickness: 1),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  period,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Divider(thickness: 1),
              ),
            ],
          ),
        ),
      );

      // Events in this period
      for (final event in sorted) {
        final isLeft = event.participantId == teamA.id;
        eventWidgets.add(buildEventItem(event, isLeft));
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: eventWidgets,
    );
  }

  Widget _statisticsTab(FixtureDetail fixture) {
    final homeTeam = fixture.participants.first;
    final awayTeam = fixture.participants.last;
    if (fixture.statistics.isEmpty || fixture.participants.length < 2) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("📊", style: TextStyle(fontSize: 48)),
            SizedBox(height: 12),
            Text(NoStatisticsAvailable.tr),
            Text(MatchStatisticsContentHere.tr),
          ],
        ),
      );
    }

    final Map<String, Map<String, int>> statsByType = {};

    // Organize stats by type and team
    for (var stat in fixture.statistics) {
      final type = stat.type.name;
      final value = stat.data['value'] is int
          ? stat.data['value']
          : int.tryParse(stat.data['value'].toString()) ?? 0;

      statsByType.putIfAbsent(type, () => {});
      if (stat.participantId == homeTeam.id) {
        statsByType[type]!['home'] = value;
      } else if (stat.participantId == awayTeam.id) {
        statsByType[type]!['away'] = value;
      }
    }

    return Column(
      children: [
        SizedBox(height: 15.h),
        HeaderTitle(
          home: homeTeam,
          away: awayTeam,
          title: StatisticsInfo.tr,
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: statsByType.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final statName = statsByType.keys.elementAt(index);
              final homeValue = statsByType[statName]!['home'] ?? 0;
              final awayValue = statsByType[statName]!['away'] ?? 0;
              final total =
                  (homeValue + awayValue == 0) ? 1 : homeValue + awayValue;

              final homeRatio = homeValue / total;
              final awayRatio = awayValue / total;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    statName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '$homeValue',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Stack(
                            children: [
                              Container(
                                height: 10.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: (homeRatio * 100).round(),
                                    child: Container(
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(6),
                                            right: Radius.circular(
                                                awayRatio == 0 ? 6 : 0)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: (awayRatio * 100).round(),
                                    child: Container(
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(6),
                                            left: Radius.circular(
                                                homeValue == 0 ? 6 : 0)),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '$awayValue',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class MatchHeader extends StatelessWidget {
  final FixtureDetail fixture;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const MatchHeader({
    super.key,
    required this.fixture,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final home = fixture.participants[0];
    final away = fixture.participants[1];

    // Scores
    final homeScore = _goalsFor(home.id);
    final awayScore = _goalsFor(away.id);

    // Scorers lists elided for brevity...

    return Container(
      decoration: _headerDecoration(),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: 10),
            _dateAndVenueRow(),
            const SizedBox(height: 16),

            /// League + State
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  width: 20.w,
                  imageUrl: fixture.league.imagePath,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (_, __, ___) =>
                      Skeletonizer(enabled: true, child: SizedBox(width: 25.w)),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                ),
                const SizedBox(width: 6),
                Text(fixture.league.name,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(width: 12),
                _stateBadge(fixture.state.shortName),
              ],
            ),
            const SizedBox(height: 16),

            /// Teams + Score/Countdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _teamBlock(home)),
                Expanded(child: _buildScoreOrCountdown(homeScore, awayScore)),
                Expanded(flex: 2, child: _teamBlock(away)),
              ],
            ),
            const SizedBox(height: 16),

            /// Tabs
            AnimatedContainer(
              duration: Duration(milliseconds: 3000),
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _tab(Events.tr, 0),
                  _tab(MatchPreview.tr, 1),
                  _tab(Statistics.tr, 2),
                ],
              ),
            ),
            // ... scorers & tabs unchanged ...
          ],
        ),
      ),
    );
  }

  Widget _tab(String title, int index) {
    final isActive = index == selectedIndex;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onTabSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(Get.context!).colorScheme.surface
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: isActive ? ColorsManager.lightPrimary : Colors.white70,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: isActive ? 16 : 15,
          ),
          child: Text(title),
        ),
      ),
    );
  }

  Widget _stateBadge(String shortName) {
    // You can customize colors per state if you like
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        shortName,
        style:
            const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
      ),
    );
  }

  int _goalsFor(int participantId) {
    return fixture.scores
        .firstWhere((s) => s.participantId == participantId,
            orElse: () => Score(
                id: 0,
                participantId: 0,
                score: ScoreDetail(goals: 0, participant: ''),
                description: ''))
        .score
        .goals;
  }

  Decoration _headerDecoration() => BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        gradient: const LinearGradient(
          colors: [Color(0xFF0D1F3C), Color(0xFF5791FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );

  Widget _dateAndVenueRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(children: [
              // Back button
              Align(
                alignment:
                    AlignmentDirectional.topStart, // Left in LTR, Right in RTL
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(Get.context!).maybePop(),
                ),
              ),
              const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Text(DateFormat('yyyy-MM-dd').format(fixture.startingAt),
                  style: const TextStyle(color: Colors.white70)),
            ]),
          ),
          Expanded(
            child: Row(children: [
              const Icon(Icons.location_on, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Flexible(
                child: Text(fixture.venue.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70)),
              ),
            ]),
          ),
        ],
      );

  Widget _teamBlock(Participant team) => Column(
        children: [
          CachedNetworkImage(
            width: 60.w,
            imageUrl: team.imagePath,
            fit: BoxFit.contain,
            progressIndicatorBuilder: (_, __, ___) =>
                Skeletonizer(enabled: true, child: SizedBox(width: 25.w)),
            errorWidget: (_, __, ___) => const Icon(Icons.error),
          ),
          const SizedBox(height: 4),
          FittedBox(
            child: Text(team.name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      );

  Widget _buildScoreOrCountdown(int homeScore, int awayScore) {
    final controller = Get.find<FixtureDetailController>();

    return Obx(() {
      final now = controller.currentTime.value;
      if (now == null) return const SizedBox();

      final loc = tz.getLocation(controller.fixtureTimezone.value!);
      final start = fixture.startingAt.isUtc
          ? tz.TZDateTime.from(fixture.startingAt, loc)
          : tz.TZDateTime(
              loc,
              fixture.startingAt.year,
              fixture.startingAt.month,
              fixture.startingAt.day,
              fixture.startingAt.hour,
              fixture.startingAt.minute,
              fixture.startingAt.second);
      final nowInTz = now.isUtc
          ? tz.TZDateTime.from(now, loc)
          : tz.TZDateTime(loc, now.year, now.month, now.day, now.hour,
              now.minute, now.second);

      final diff = start.difference(nowInTz);
      if (fixture.state.shortName != 'NS') {
        return Column(
          children: [
            Text(
              '$homeScore - $awayScore',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(fixture.state.name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white60)),
          ],
        );
      }
      // // 1) Match ended
      // if (diff.isNegative) {
      //   return _centerColumn(
      //     label: 'Ended',
      //     mainText: '$homeScore - $awayScore',
      //     subText: fixture.state.shortName,
      //   );
      // }

      // 2) Tomorrow
      if (_isTomorrow(start, nowInTz)) {
        return _centerColumn(
          label: DateFormat('hh:mm a').format(start),
          mainText: Tomorrow.tr,
          isBoldMain: true,
        );
      }

      // 3) After X days
      if (diff.inDays >= 1) {
        final days = diff.inDays;
        return _centerColumn(
          label: DateFormat('hh:mm a').format(start),
          mainText: '${After.tr} $days ${Day.tr}${days > 1 ? '' : ''}',
          isBoldMain: true,
        );
      }

      // 4) Countdown
      final countdown = [
        diff.inHours.remainder(24).toString().padLeft(2, '0'),
        diff.inMinutes.remainder(60).toString().padLeft(2, '0'),
        diff.inSeconds.remainder(60).toString().padLeft(2, '0'),
      ].join(':');

      return _centerColumn(
        label: DateFormat('hh:mm a').format(start),
        subtitle: StartsIn.tr,
        mainText: countdown,
      );
    });
  }

  Widget _centerColumn({
    required String label,
    String? subtitle,
    String? mainText,
    String? subText,
    bool isBoldMain = false,
  }) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.orangeAccent)),
          // const SizedBox(height: 4),
          // Text(fixture.state.name,
          //     style: const TextStyle(color: Colors.white60)),
        ],
        if (mainText != null) ...[
          const SizedBox(height: 6),
          Text(mainText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isBoldMain ? 24 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          // const SizedBox(height: 4),
          // Text(fixture.state.name,
          //     style: const TextStyle(color: Colors.white60)),
        ],
        if (subText != null) ...[
          const SizedBox(height: 4),
          Text(subText,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 4),
          // Text(fixture.state.name,
          //     style: const TextStyle(color: Colors.white60)),
        ],
        const SizedBox(height: 4),
        Text(fixture.state.name,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white60)),
      ],
    );
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isTomorrow(DateTime start, DateTime now) =>
      _isSameDate(start, now.add(const Duration(days: 1)));
}

class MatchPreviewWidget extends StatelessWidget {
  final FixtureDetail fixture;

  const MatchPreviewWidget({super.key, required this.fixture});

  @override
  Widget build(BuildContext context) {
    final List<ChannelCommentator> channelCommentator = fixture.channelComm;
    // final List<ChannelCommentator> channelCommentator =
    //     dummyChannelCommentators;
    if (channelCommentator.isEmpty) {
      print("No channel commentators found, adding dummy data");
      channelCommentator.add(ChannelCommentator(
          tvChannelLink: [],
          channel: 1,
          channelName: Unknown.tr,
          commentator: 1,
          commentatorName: Unknown.tr,
          sound: 1));
    }

    final sidelined = fixture.sidelined ?? [];
    final homeSidelined = sidelined
        .where((s) => s.participantId == fixture.participants.first.id)
        .toList();
    final awaySidelined = sidelined
        .where((s) => s.participantId == fixture.participants.last.id)
        .toList();

    final home = fixture.participants[0];
    final away = fixture.participants[1];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10.h),
          // Channel & Commentators Section
          HeaderTitle(
              home: home, away: away, title: ChannelsAndCommentators.tr),
          SizedBox(height: 12.h),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            itemCount: channelCommentator.length,
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              final commentator = channelCommentator[index];
              return GestureDetector(
                onTap: () {
                  if (commentator.channelName != Unknown.tr) {
                    // showFootballChannelPopup(channel);

                    if (commentator.tvChannelLink.isNotEmpty) {
                      showFootballChannelPopup(commentator);
                    } else {
                      showCustomSnackBar(
                          message: ChannelUnknown.tr,
                          title: Channel_not_found.tr,
                          isError: true);
                    }
                  }
                },
                child: Card(
                  elevation: 5,
                  shadowColor: ColorsManager.lightSecondary,
                  color: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0.h),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Skeleton.shade(
                              child: Icon(Icons.live_tv_outlined,
                                  color: Colors.grey, size: 15.dm),
                            ),
                            horizontalSpace(5),
                            Text(
                              commentator.channelName,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Skeleton.shade(
                                child: Icon(Icons.mic,
                                    color: Colors.grey, size: 15.dm)),
                            horizontalSpace(5),
                            Text(
                              commentator.commentatorName,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 10.h),
          HeaderTitle(home: home, away: away, title: Sidelined.tr),

          // Statistics Section
          Card(
            elevation: 3,
            shadowColor: ColorsManager.lightSecondary,
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sidelined Players
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _sidelinedList(homeSidelined,
                            '${homeSidelined.length} ${Players.tr} ${homeSidelined.length != 1 ? '' : ''}'),
                      ),
                      // Spacer(),
                      Expanded(
                        child: _sidelinedList(awaySidelined,
                            '${awaySidelined.length} ${Players.tr} ${awaySidelined.length != 1 ? '' : ''}'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h),
          // Location Info Section
          HeaderTitle(
            home: home,
            away: away,
            title: LocationInfo.tr,
          ),
          SizedBox(height: 10.h),
          Center(
              child: Text(
            Venues.tr,
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          )),
          Card(
            elevation: 3,
            shadowColor: ColorsManager.lightSecondary,
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: fixture.venue.imagePath ?? '',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Skeletonizer(
                        enableSwitchAnimation: true,
                        enabled: true,
                        child: SizedBox(
                          width: 150,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _infoRow(Venues.tr, fixture.venue.name),
                  _infoRow(Capacity.tr, fixture.venue.capacity.toString()),
                  _infoRow(Surface.tr, fixture.venue.surface),
                  _infoRow(City.tr, fixture.venue.cityName),
                  _infoRow(Address.tr, fixture.venue.address),
                ],
              ),
            ),
          ),

          // Weather Report Section
          if (fixture.weatherReport != null)
            Card(
              elevation: 3,
              shadowColor: ColorsManager.lightSecondary,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        WeatherReports.tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: fixture.weatherReport!.icon,
                        height: 50,
                      ),
                    ),
                    _infoRow(Weather.tr, fixture.weatherReport!.description),
                    _infoRow(Temperatures.tr,
                        '${fixture.weatherReport!.temperature.day}°C'),
                    _infoRow(Clouds.tr, fixture.weatherReport!.clouds),
                    _infoRow(WindSpeed.tr,
                        '${fixture.weatherReport!.wind.speed} km/h'),
                    _infoRow(Humidity.tr, fixture.weatherReport!.humidity),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _sidelinedList(List<Sideline> sidelined, String defaultText) {
    if (sidelined.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            defaultText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   defaultText,
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        // ),
        // const SizedBox(height: 8),
        ...sidelined.map((s) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0.w),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: s.sideline.player.imagePath,
                  height: 35.h,
                  placeholder: (context, url) => Skeletonizer(
                    enabled: true,
                    child: Icon(Icons.sports_soccer, size: 30.h),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.broken_image,
                    size: 30.h,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(width: 5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // width: 110.w,
                      child: Text(
                        s.sideline.player.displayName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(
                      // width: 110.w,
                      child: Text(
                        s.sideline.type.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    super.key,
    required this.home,
    required this.away,
    required this.title,
  });

  final Participant home;
  final String title;
  final Participant away;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.isDarkMode ? Colors.grey : Colors.grey.shade200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: CachedNetworkImage(
              width: 30.w,
              height: 30.h,
              imageUrl: home.imagePath,
              placeholder: (context, url) => Skeletonizer(
                enabled: true,
                child: Icon(Icons.sports_soccer, size: 30.dm),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.broken_image,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: CachedNetworkImage(
              width: 30.w,
              height: 30.h,
              imageUrl: away.imagePath,
              placeholder: (context, url) => Skeletonizer(
                enabled: true,
                child: Icon(Icons.sports_soccer, size: 30.dm),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.broken_image,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showFootballChannelPopup(ChannelCommentator commentator) {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400,
            minWidth: 280,
            maxWidth: 400,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  commentator.channelName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  QualityOptions.tr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: commentator.tvChannelLink.length,
                    itemBuilder: (context, index) {
                      final link = commentator.tvChannelLink[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            shadowColor: ColorsManager.lightSecondary,
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.r), // assuming you use flutter_screenutil
                            ),
                          ),
                          onPressed: () => _openVideoUrl(
                              link.url, commentator.tvChannelLink),
                          icon: const Icon(Icons.play_arrow),
                          label: Text(link.name),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shadowColor: ColorsManager.lightSecondary,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.r), // assuming you use flutter_screenutil
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(Close.tr),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _openVideoUrl(String url, List<TvChannelLink> channel) async {
  final controller = Get.find<VideoPlayerConteroller>();
  controller.videoUrls = url;
  Get.to(() => VideoPlayer2ForMathScreen(
        channel: channel,
      ));

  controller.setAllOrientationsToLandscape();
}
