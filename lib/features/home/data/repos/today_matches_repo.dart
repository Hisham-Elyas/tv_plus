// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/helpers/check_internet.dart';
import '../../../../core/helpers/enums.dart';
import '../../../../core/helpers/snackbar_error_message.dart';
import '../../../../core/networking/exception.dart';
import '../local/today_matches_local_date.dart';
import '../models/match_model.dart';
import '../remote/today_matches_remote_date.dart';

abstract class TodayMatchesRepo {
  Future<Either<StatusRequest, List<MatchModel>>> getAllTodayMatches();
}

class TodayMatchesRepoImpHttp implements TodayMatchesRepo {
  final TodayMatchesRemoteDataImpHttp todayMatchesRemotData;
  final MatchLocalDataImp todayMatchesLocalData;
  TodayMatchesRepoImpHttp({
    required this.todayMatchesRemotData,
    required this.todayMatchesLocalData,
  });

  @override
  Future<Either<StatusRequest, List<MatchModel>>> getAllTodayMatches() async {
    if (await checkInternet()) {
      try {
        final remotData = await todayMatchesRemotData.getAllTodayMatches();
        todayMatchesLocalData.cacheMatch(match: remotData);

        log('from Server  ==> Today Matches Data');

        return right(remotData);
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return left(StatusRequest.serverFailure);
      }
    } else {
      try {
        final localData = await todayMatchesLocalData.getCachedMatch();
        log('from loc Cache  <== Today Matches Data');
        showNetworkError();
        return right(localData);
      } on EmptyCacheException {
        showNetworkError();

        return left(StatusRequest.emptyCache);
      }
    }
  }
}
