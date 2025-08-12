// ignore_for_file: avoid_print

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/enums.dart';
import '../../../../core/localization/language_controller.dart';
import '../../../../core/networking/api_client.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/exception.dart';
import '../models/fixture_detail_model.dart';
import '../models/fixtures_model.dart';
import '../models/league_fixtures_response_model.dart';
import '../models/leagues_response_model.dart';
import '../models/scorers_response_model.dart';
import '../models/standing_model.dart';
import '../models/team_fixtures_response_model.dart';

abstract class FixturesRemoteDate {
  Future getAllTodayMatches({required String date});
  Future getFixturDetiels(
      {required String fixturId, required String channelCommmId});
  Future<StandingsResponse> getStandings({required String seasonId});
  Future<ScorersResponse> getTopScorers({
    required String seasonId,
    required ScorerType type,
  });
  Future<UpcomingFixturesResponse> getUpcomingMatchesByTeam(
      {required String teamId});
  Future<LeaguesResponse> getLeagues();
  Future<LeagueFixturesResponse> getMatchesByLeagueId(
      {required String leagueId});
}

class FixturesRemoteDateImpHttp implements FixturesRemoteDate {
  final ApiClent apiClent;
  final String locale = Get.find<LanguageController>().appLocale.languageCode;

  FixturesRemoteDateImpHttp({required this.apiClent});

  @override
  Future<ScorersResponse> getTopScorers({
    required String seasonId,
    required ScorerType type,
  }) async {
    final timeZone = await getDeviceTimeZone();
    final result = await apiClent.getData(
      uri:
          "${ApiConstants.apiBaseUrl + ApiConstants.fixtures + ApiConstants.topscorers}/$seasonId?type=${type.name}&timezone=$timeZone&locale=$locale",
    );

    if (result.statusCode == 200) {
      final ScorersResponse response = ScorersResponse.fromJson(result.body);
      return response;
    } else {
      throw ServerException(message: "${result.statusCode}");
    }
  }

  @override
  Future<UpcomingFixturesResponse> getUpcomingMatchesByTeam(
      {required String teamId}) async {
    final timeZone = await getDeviceTimeZone();
    final result = await apiClent.getData(
      uri:
          "${ApiConstants.apiBaseUrl + ApiConstants.fixtures + ApiConstants.team}/$teamId${ApiConstants.matches}?timezone=$timeZone&locale=$locale",
    );

    if (result.statusCode == 200) {
      final UpcomingFixturesResponse response =
          UpcomingFixturesResponse.fromJson(result.body);
      return response;
    } else {
      throw ServerException(message: "${result.statusCode}");
    }
  }

  @override
  Future<StandingsResponse> getStandings({required String seasonId}) async {
    final timeZone = await getDeviceTimeZone();
    final result = await apiClent.getData(
      uri:
          "${ApiConstants.apiBaseUrl + ApiConstants.fixtures + ApiConstants.standings}/$seasonId?locale=$locale&timezone=$timeZone",
    );

    if (result.statusCode == 200) {
      final StandingsResponse response =
          StandingsResponse.fromJson(result.body);
      return response;
    } else {
      throw ServerException(message: "${result.statusCode}");
    }
  }

  @override
  Future<FixturesResponse> getAllTodayMatches({required String date}) async {
    final timeZone = await getDeviceTimeZone();
    final resalt = await apiClent.getData(
        uri:
            "${ApiConstants.apiBaseUrl + ApiConstants.fixtures + ApiConstants.calendar}?date=$date&timezone=$timeZone&locale=$locale");
    if (resalt.statusCode == 200) {
      final FixturesResponse response = FixturesResponse.fromJson(resalt.body);
      return response;
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<FixtureDetailResponse> getFixturDetiels(
      {required String fixturId, required String channelCommmId}) async {
    final timeZone = await getDeviceTimeZone();
    final resalt = await apiClent.getData(
      uri:
          "${ApiConstants.apiBaseUrl + ApiConstants.fixtures}/$fixturId?timezone=$timeZone&locale=$locale&channel_commm_id=$channelCommmId",
    );

    if (resalt.statusCode == 200) {
      final FixtureDetailResponse response =
          FixtureDetailResponse.fromJson(resalt.body);
      return response;
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<LeaguesResponse> getLeagues() async {
    final timeZone = await getDeviceTimeZone();
    final result = await apiClent.getData(
      uri:
          "${ApiConstants.apiBaseUrl + ApiConstants.fixtures + ApiConstants.leagues}?timezone=$timeZone&locale=$locale",
    );

    if (result.statusCode == 200) {
      final LeaguesResponse response = LeaguesResponse.fromJson(result.body);
      return response;
    } else {
      throw ServerException(message: "${result.statusCode}");
    }
  }

  @override
  Future<LeagueFixturesResponse> getMatchesByLeagueId(
      {required String leagueId}) async {
    final timeZone = await getDeviceTimeZone();
    final result = await apiClent.getData(
      uri:
          "${ApiConstants.apiBaseUrl}${ApiConstants.fixtures}${ApiConstants.leagueMatches}/$leagueId${ApiConstants.matches}?locale=$locale&timezone=$timeZone",
    );

    if (result.statusCode == 200) {
      final LeagueFixturesResponse response =
          LeagueFixturesResponse.fromJson(result.body);
      return response;
    } else {
      throw ServerException(message: "${result.statusCode}");
    }
  }

  Future<String> getDeviceTimeZone() async {
    try {
      final timeZone = await FlutterTimezone.getLocalTimezone();
      return timeZone;
    } catch (e) {
      return 'Asia/Riyadh';
    }
  }
}
