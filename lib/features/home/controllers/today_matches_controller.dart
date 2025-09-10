import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/localization/constants.dart';
import '../../../core/theming/colors.dart';
// import '../data/models/channel_category_model.dart';
import '../data/models/league_model.dart';
import '../data/models/match_model.dart';
import '../data/repos/today_matches_repo.dart';
import 'category_controller.dart';

class TodayMatchesController extends GetxController {
  late StatusRequest statusReq;
  List<MatchModel> matches = [];
  List<LeagueModel> leaguesList = [];
  List<LeagueModel> leaguesListdummyData = dummyleaguesList;
  final TodayMatchesRepoImpHttp todayMatchesRepo = Get.find();
  final CategoryController categoryController = Get.find();

  List<String> selectedLeagues = [];

  void toggleLeagueSelection(String league) {
    if (selectedLeagues.contains(league)) {
      selectedLeagues.remove(league);
    } else {
      selectedLeagues.add(league);
    }
    update(); // Add unique tag for targeted update
  }

  void clearFilters() {
    selectedLeagues.clear();
    update();
  }

  List<LeagueModel> get filteredLeaguesList {
    if (statusReq == StatusRequest.loading) {
      return leaguesListdummyData;
    } else {
      if (selectedLeagues.isEmpty) return leaguesList;
      return leaguesList
          .where((league) => selectedLeagues.contains(league.league))
          .toList();
    }
  }

  // The currently selected date (initialize with today)
  DateTime selectedDate = DateTime.now();
  String get selectedDateformat {
    return DateFormat("EEEE, dd/MM/yyyy").format(selectedDate);
  }

  // Function to parse a match's date string into DateTime
  DateTime parseMatchDate(String dateString) {
    final DateFormat formatter = DateFormat("EEEE dd-MM-yyyy");
    try {
      return formatter.parse(dateString);
    } catch (e) {
      debugPrint("Error parsing date: $e");
      return DateTime.now();
    }
  }

  void nextDay() {
    selectedDate = selectedDate.add(const Duration(days: 1));
    update();
  }

  void previousDay() {
    selectedDate = selectedDate.subtract(const Duration(days: 1));
    update();
  }

  // Filter matches by the selected date
  List<LeagueModel> get getFilteredMatchesByDate {
    // Flatten all matches from all leagues into a single list.
    final allMatches =
        filteredLeaguesList.expand((league) => league.matches).toList();
    debugPrint(allMatches.length.toString());
    // Filter matches whose parsed matchDate is equal to the selected date.
    final List<MatchModel> filteredMatchesByDate = allMatches.where((match) {
      final DateTime matchDateTime = parseMatchDate(match.matchDate);
      return matchDateTime.year == selectedDate.year &&
          matchDateTime.month == selectedDate.month &&
          matchDateTime.day == selectedDate.day;
    }).toList();
    return convorToLeagueModel(matches: filteredMatchesByDate);
  }

  List<MatchModel> get filteredMatches {
    if (selectedLeagues.isEmpty) return matches;
    return matches
        .where((match) => selectedLeagues.contains(match.league))
        .toList();
  }

  List<LeagueModel> convorToLeagueModel({required List<MatchModel> matches}) {
    leaguesList = matches
        .fold<Map<String, LeagueModel>>({},
            (Map<String, LeagueModel> map, match) {
          if (!map.containsKey(match.league)) {
            map[match.league] = LeagueModel(
              league: match.league,
              leagueLogo: match.leagueLogo,
              matches: [],
            );
          }
          map[match.league]!.matches.add(match);
          return map;
        })
        .values
        .toList();
    return leaguesList;
  }

  @override
  void onInit() async {
    super.onInit();
    await getAllTodayMatches();
  }

  Future<void> getAllTodayMatches() async {
    statusReq = StatusRequest.loading;
    update();
    final data = await todayMatchesRepo.getAllTodayMatches();
    data.fold((l) {
      statusReq = l;

      update();
    }, (r) {
      /////
      matches.clear();
      List<MatchModel> matchesWithChannel = r
          .where((match) =>
              match.channelsAndCommentators.isNotEmpty &&
              match.channelsAndCommentators.first.channel != 'Referee')
          .toList();

      matches.addAll(matchesWithChannel);
      convorToLeagueModel(matches: matches);
      statusReq = StatusRequest.success;

      update();
    });
  }

  // MatchStatus getMatchStatusWithColor(MatchModel event) {
  //   String status;
  //   Color color;
  //   try {
  //     DateTime matchDateTime = DateFormat('EEEE dd-MM-yyyy hh:mm a')
  //         .parse('${event.matchDate} ${event.matchTime}');
  //     DateTime matchEndTime = matchDateTime.add(const Duration(hours: 2));

  //     if (DateTime.now().isBefore(matchDateTime)) {
  //       status = event.matchTime;
  //       color = Theme.of(Get.context!).colorScheme.secondary;
  //     } else if (DateTime.now().isAfter(matchEndTime)) {
  //       status = 'Ended';
  //       color = ColorsManager.mainRed;
  //     } else {
  //       status = 'Running';
  //       color = ColorsManager.green;
  //     }

  //     return MatchStatus(status: status, color: color);
  //   } catch (e) {
  //     status = event.matchTime;
  //     color = Theme.of(Get.context!).colorScheme.secondary;
  //     return MatchStatus(status: status, color: color);
  //   }
  // }

  // void goToMatch(MatchModel event) async {
  //   MatchStatus matchStatus = getMatchStatusWithColor(event);

  //   if (matchStatus.statustitel == 'Running') {
  //     if (event.channelsAndCommentators.isEmpty) {
  //       showCustomSnackBar(
  //           message: ChannelUnknown.tr,
  //           title: Channel_not_found.tr,
  //           isError: true);
  //       return;
  //     }
  //     try {
  //       final channel = await findChannelByName(
  //           event.channelsAndCommentators.first.channel);

  //       // Get.to(() => VideoPlayerOptionScreen(
  //       //       channel: channel,
  //       //     ));
  //       Get.to(() => VideoPlayerScreen(
  //             channel: channel,
  //           ));
  //       await Get.find<VideoPlayerConteroller>()
  //           .setAllOrientationsToLandscape();

  //       log('Found: ${channel.name}, Video URL: ${channel.url}');
  //     } catch (e) {
  //       log(e.toString()); // Handle exception
  //     }
  //   } else if (matchStatus.statustitel != 'Ended') {
  //     showCustomSnackBar(
  //       message: The_match_hasn_t_started_yet.tr,
  //       isError: false,
  //       title: Match_Status.tr,
  //     );
  //   }
  // }

  MatchStatus getMatchStatusWithColor(MatchModel event) {
    String status;
    String statustitel;
    Color color;

    try {
      // Define the time zone (UTC+3 for Riyadh)
      DateTime matchDateTime = DateFormat('EEEE dd-MM-yyyy hh:mm a').parse(
          '${event.matchDate} ${event.matchTime}',
          true); // Use 'true' for UTC parsing

      // Manually set the time as UTC+3 (Riyadh)
      matchDateTime = matchDateTime.subtract(const Duration(hours: 4));

      // Convert UTC to the device's local time
      DateTime localMatchDateTime = matchDateTime.toLocal();
      DateTime matchEndTime = localMatchDateTime.add(const Duration(hours: 2));

      DateTime now = DateTime.now();

      if (now.isBefore(localMatchDateTime)) {
        // Display match time in device's local format
        statustitel = 'not start';
        status = DateFormat('hh:mm a').format(localMatchDateTime);
        color = Theme.of(Get.context!).colorScheme.secondary;
      } else if (now.isAfter(matchEndTime)) {
        status = DateFormat('hh:mm a').format(localMatchDateTime);
        statustitel = 'Ended';
        color = ColorsManager.mainRed;
      } else {
        status = DateFormat('hh:mm a').format(localMatchDateTime);
        statustitel = 'Running';
        color = ColorsManager.green;
      }

      return MatchStatus(
        status: status,
        color: color,
        statustitel: statustitel,
      );
    } catch (e) {
      // If parsing fails, fallback to original match time
      status = event.matchTime;
      statustitel = event.matchTime;
      color = Theme.of(Get.context!).colorScheme.secondary;
      return MatchStatus(
          status: status, color: color, statustitel: statustitel);
    }
  }

  // **Helper function to normalize names**
  String normalizeChannelName(String name) {
    return name
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ') // Remove extra spaces
        .replaceAll(RegExp(r'[^\w\s]'), '') // Remove special characters
        .replaceAll(RegExp(r's\b'), '') // Handle plural vs. singular
        .replaceAll(RegExp(r'[^a-z0-9 ]'), '') // Remove special characters
        .replaceAll(RegExp(r'hd'), '') // Remove "HD"
        .replaceAll(RegExp(r'sports'), 'sport') // Normalize "Sports" -> "Sport"
        .replaceAll(RegExp(r'[^a-z0-9 ]', caseSensitive: false),
            '') // Remove emojis & special chars
        .trim();
  }

// **Helper function to extract channel number**
  String extractChannelNumber(String name) {
    RegExp numberRegex = RegExp(r'\d+'); // Find numbers in the string
    Match? match = numberRegex.firstMatch(name);
    return match?.group(0) ?? ''; // Return the found number or empty string
  }
}

void showFilterBottomSheet(BuildContext context) {
  final controllers = Get.find<TodayMatchesController>();
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
            child: GetBuilder<TodayMatchesController>(
              builder: (controller) => ListView.builder(
                itemCount: controller.leaguesList.length,
                itemBuilder: (context, index) {
                  final league = controller.leaguesList[index];
                  return Card(
                    elevation: 5,
                    shadowColor: ColorsManager.lightSecondary,
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.platform,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      title: Text(league.league),
                      secondary: CachedNetworkImage(
                        width: 25.w,
                        height: 25.h,
                        imageUrl: league.leagueLogo,
                        placeholder: (context, url) => Skeletonizer(
                          enableSwitchAnimation: true,
                          enabled: true,
                          child: Icon(Icons.ac_unit, size: 25.dm),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.sports_soccer,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      value: controller.selectedLeagues.contains(league.league),
                      onChanged: (_) =>
                          controller.toggleLeagueSelection(league.league),
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
            padding: EdgeInsets.all(1.0.dm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: controllers.clearFilters,
                  child: Text(Clear.tr),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(Apply.tr),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class MatchStatus {
  final String status;
  final String statustitel;
  final Color color;

  MatchStatus(
      {required this.status, required this.statustitel, required this.color});
}

class ChannelNotFoundException implements Exception {
  final String message;
  ChannelNotFoundException(this.message);

  @override
  String toString() => 'ChannelNotFoundException: $message';
}
