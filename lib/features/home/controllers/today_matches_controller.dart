import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:string_similarity/string_similarity.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../data/models/channel_category_model.dart';
import '../data/models/league_model.dart';
import '../data/models/match_model.dart';
import '../data/repos/today_matches_repo.dart';

class TodayMatchesController extends GetxController {
  late StatusRequest statusReq;
  List<MatchModel> matches = [];
  List<LeagueModel> leaguesList = [];
  final TodayMatchesRepoImpHttp todayMatchesRepo = Get.find();
  List<LeagueModel> convorToLeagueModel() {
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
      matches.addAll(r);
      convorToLeagueModel();
      statusReq = StatusRequest.success;

      update();
    });
  }

  MatchStatus getMatchStatusWithColor(MatchModel event) {
    DateTime matchDateTime = DateFormat('EEEE dd-MM-yyyy hh:mm a')
        .parse('${event.matchDate} ${event.matchTime}');
    DateTime matchEndTime = matchDateTime.add(const Duration(hours: 2));
    String status;
    Color color;

    if (DateTime.now().isBefore(matchDateTime)) {
      status = event.matchTime;
      color = ColorsManager.lightBlue;
    } else if (DateTime.now().isAfter(matchEndTime)) {
      status = 'Match Ended';
      color = ColorsManager.mainRed;
    } else {
      status = 'Match Running';
      color = ColorsManager.green;
    }

    return MatchStatus(status: status, color: color);
  }

  Channel findChannelByName(String channelName) {
    // Set a similarity threshold (e.g., 0.9 means 90% similarity)

    const double threshold = 0.9;
    final List<Channel> channels =
        channelCategories[0].channels + channelCategories[1].channels;
    // Find the best match based on similarity
    Channel? bestMatch;
    double highestSimilarity = 0.0;

    for (var channel in channels) {
      double similarity = StringSimilarity.compareTwoStrings(
          channel.name.trim().toLowerCase().toString(),
          channelName.trim().toLowerCase().toString());
      if (similarity > highestSimilarity) {
        highestSimilarity = similarity;
        bestMatch = channel;
      }
    }

    // Check if the highest similarity is above the threshold
    if (bestMatch != null && highestSimilarity >= threshold) {
      return bestMatch; // Return the best match if similarity is above threshold
    } else {
      showCustomSnackBar(
          message: " No channel found for name: $channelName",
          title: "Channel not found",
          isError: true);
      throw ChannelNotFoundException(
          'No sufficiently similar channel found for: $channelName');
    }
  }
}

class MatchStatus {
  final String status;
  final Color color;

  MatchStatus({required this.status, required this.color});
}

class ChannelNotFoundException implements Exception {
  final String message;
  ChannelNotFoundException(this.message);

  @override
  String toString() => 'ChannelNotFoundException: $message';
}
