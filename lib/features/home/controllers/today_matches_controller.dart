import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/theming/colors.dart';
import '../data/models/match_model.dart';
import '../data/repos/today_matches_repo.dart';

class TodayMatchesController extends GetxController {
  final TodayMatchesRepoImpHttp todayMatchesRepo = Get.find();
  late StatusRequest statusReq;
  List<MatchModel> matches = [];
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
}

class MatchStatus {
  final String status;
  final Color color;

  MatchStatus({required this.status, required this.color});
}
