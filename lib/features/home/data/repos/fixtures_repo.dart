// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:faisal_tv/features/home/data/models/fixture_detail_model.dart';
import 'package:faisal_tv/features/home/data/models/scorers_response_model.dart';
import 'package:faisal_tv/features/home/data/models/team_fixtures_response_model.dart';

import '../../../../core/helpers/check_internet.dart';
import '../../../../core/helpers/enums.dart';
import '../../../../core/helpers/snackbar_error_message.dart';
import '../../../../core/networking/exception.dart';
import '../models/fixtures_model.dart';
import '../models/standing_model.dart';
import '../remote/fixtures_remote_data.dart';

abstract class FixturesRepo {
  Future getAllTodayMatches({required String date});
  Future getFixturDetiels(
      {required String fixturId, required String channelCommmId});
  Future<Either<StatusRequest, StandingsResponse>> getStandings(
      {required String seasonId});

  Future<Either<StatusRequest, UpcomingFixturesResponse>>
      getUpcomingMatchesByTeam({required String teamId});

  Future<Either<StatusRequest, ScorersResponse>> getTopScorers({
    required String seasonId,
    required ScorerType type,
  });
}

class FixturesRepoImpHttp implements FixturesRepo {
  final FixturesRemoteDateImpHttp todayMatchesRemotData;
  // final MatchLocalDataImp todayMatchesLocalData;
  FixturesRepoImpHttp({
    required this.todayMatchesRemotData,
    // required this.todayMatchesLocalData,
  });

  @override
  Future<Either<StatusRequest, ScorersResponse>> getTopScorers({
    required String seasonId,
    required ScorerType type,
  }) async {
    if (await checkInternet()) {
      try {
        final remoteData = await todayMatchesRemotData.getTopScorers(
          seasonId: seasonId,
          type: type,
        );

        log('from Server  ==> Top Scorers ${type.name}');

        return right(remoteData);
      } on ServerException catch (e) {
        print(e.message);
        if (int.tryParse(e.message) == 204) {
          return left(StatusRequest.noData);
        } else if (int.tryParse(e.message) == 404) {
          return left(StatusRequest.noData);
        } else {
          showErrorMessage(e.message);
          return left(StatusRequest.serverFailure);
        }
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, UpcomingFixturesResponse>>
      getUpcomingMatchesByTeam({
    required String teamId,
  }) async {
    if (await checkInternet()) {
      try {
        final remoteData = await todayMatchesRemotData.getUpcomingMatchesByTeam(
            teamId: teamId);

        log('from Server  ==> Upcoming Matches Data');

        return right(remoteData);
      } on ServerException catch (e) {
        print(e.message);
        if (int.tryParse(e.message) == 204) {
          return left(StatusRequest.noData);
        } else if (int.tryParse(e.message) == 404) {
          return left(StatusRequest.noData);
        } else {
          showErrorMessage(e.message);
          return left(StatusRequest.serverFailure);
        }
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, StandingsResponse>> getStandings({
    required String seasonId,
  }) async {
    if (await checkInternet()) {
      try {
        final remoteData =
            await todayMatchesRemotData.getStandings(seasonId: seasonId);
        log('from Server  ==> Standings Data');
        return right(remoteData);
      } on ServerException catch (e) {
        print(e.message);
        if (int.tryParse(e.message) == 204) {
          return left(StatusRequest.noData);
        } else if (int.tryParse(e.message) == 404) {
          return left(StatusRequest.noData);
        } else {
          showErrorMessage(e.message);
          return left(StatusRequest.serverFailure);
        }
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, FixtureDetailResponse>> getFixturDetiels(
      {required String fixturId, required String channelCommmId}) async {
    if (await checkInternet()) {
      try {
        final remotData = await todayMatchesRemotData.getFixturDetiels(
            fixturId: fixturId, channelCommmId: channelCommmId);
        // todayMatchesLocalData.cacheMatch(match: remotData);

        log('from Server  ==> Fixture Details Data');

        return right(remotData);
      } on ServerException catch (e) {
        print(e);
        if (int.tryParse(e.message) == 204) {
          return left(StatusRequest.noData);
        } else if (int.tryParse(e.message) == 404) {
          return left(StatusRequest.noData);
        } else {
          showErrorMessage(e.message);
          return left(StatusRequest.serverFailure);
        }
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, FixturesResponse>> getAllTodayMatches(
      {required String date}) async {
    if (await checkInternet()) {
      try {
        final remotData =
            await todayMatchesRemotData.getAllTodayMatches(date: date);
        // todayMatchesLocalData.cacheMatch(match: remotData);

        log('from Server  ==> Today Matches Data');

        return right(remotData);
      } on ServerException catch (e) {
        print(e.message);
        if (int.tryParse(e.message) == 204) {
          return left(StatusRequest.noData);
        } else if (int.tryParse(e.message) == 404) {
          return left(StatusRequest.noData);
        } else {
          showErrorMessage(e.message);
          return left(StatusRequest.serverFailure);
        }
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }
}
