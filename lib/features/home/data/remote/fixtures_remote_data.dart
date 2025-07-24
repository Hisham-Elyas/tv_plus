import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/enums.dart';
import '../../../../core/localization/language_controller.dart';
import '../../../../core/networking/api_client.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/exception.dart';
import '../models/fixture_detail_model.dart';
import '../models/fixtures_model.dart';
import '../models/scorers_response_model.dart';
import '../models/standing_model.dart';
import '../models/team_fixtures_response_model.dart';

abstract class FixturesRemoteDate {
  Future getAllTodayMatches({required String date});
  Future getFixturDetiels({required String fixturId});
  Future<StandingsResponse> getStandings({required String seasonId});
  Future<ScorersResponse> getTopScorers({
    required String seasonId,
    required ScorerType type,
  });

  Future<UpcomingFixturesResponse> getUpcomingMatchesByTeam(
      {required String teamId});
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
      /// http://172.105.81.117:3000/api/fixtures/team/2447/matches
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

    print("from getStandings: ${result.body}  ");
    if (result.statusCode == 200) {
      final StandingsResponse response = StandingsResponse.fromJson(
          result.body); // ✅ assuming `result.body` is a JSON map
      print("from getStandings: ${response.data.length} standings loaded");
      return response;
    } else {
      throw ServerException(message: "${result.statusCode}");
    }
  }

  @override
  Future<FixturesResponse> getAllTodayMatches({required String date}) async {
    final timeZone = await getDeviceTimeZone(); // ⬅️ Get timezone here
    final resalt = await apiClent.getData(
        uri:
            "${ApiConstants.apiBaseUrl + ApiConstants.fixtures + ApiConstants.calendar}?date=$date&timezone=$timeZone&locale=$locale");
    print(resalt.body);
    // print(resalt.statusCode);
    if (resalt.statusCode == 200) {
      final FixturesResponse response = FixturesResponse.fromJson(resalt.body);
      print("from getAllTodayMatches : ${response.timezone}");
      return response;
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<FixtureDetailResponse> getFixturDetiels(
      {required String fixturId}) async {
    final timeZone = await getDeviceTimeZone(); // ⬅️ Get timezone here
    final resalt = await apiClent.getData(
      uri:
          "${ApiConstants.apiBaseUrl + ApiConstants.fixtures}/$fixturId?timezone=$timeZone&locale=$locale",
    );

    if (resalt.statusCode == 200) {
      // 🔥 Fix here: decode the JSON string into a map first
      // final Map<String, dynamic> decodedJson = jsonDecode();

      print(resalt.body); // or any field to verify
      // ✅ Now safely parse it into your model
      final FixtureDetailResponse response =
          FixtureDetailResponse.fromJson(resalt.body);
      print("from getFixturDetiels : ${response.timezone}");

      return response;
    } else {
      print("❌ Error fetching fixture details: ${resalt.statusCode}");
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  Future<String> getDeviceTimeZone() async {
    try {
      final timeZone = await FlutterTimezone.getLocalTimezone();
      // print(timeZone);
      return timeZone;
    } catch (e) {
      return 'Asia/Riyadh';
    }
  }
}
