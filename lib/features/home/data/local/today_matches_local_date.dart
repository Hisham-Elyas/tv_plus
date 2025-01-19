import 'dart:convert';
import 'dart:developer';

import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/networking/exception.dart';
import '../models/match_model.dart';

abstract class TodayMatchesLocalDate {
  Future cacheMatch({required List<MatchModel> match});
  Future<List<MatchModel>> getCachedMatch();
}

class MatchLocalDataImp implements TodayMatchesLocalDate {
  MatchLocalDataImp();

  @override
  Future cacheMatch({required List<MatchModel> match}) async {
    await SharedPrefHelper.setData('MATCH_CACHE', jsonEncode(match));
  }

  @override
  Future<List<MatchModel>> getCachedMatch() async {
    final cachedData = await SharedPrefHelper.getString('MATCH_CACHE');

    final List<MatchModel> matches = (jsonDecode(cachedData) as List)
        .map((match) => MatchModel.fromJson(match as Map<String, dynamic>))
        .toList();
    // ignore: unrelated_type_equality_checks
    if (cachedData != '') {
      return matches;
    } else {
      log("============\n Empty Cached MATCH Data  \n============");
      throw EmptyCacheException();
    }
  }
}
