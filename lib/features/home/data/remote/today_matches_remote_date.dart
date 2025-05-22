import '../../../../core/networking/api_client.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/exception.dart';
import '../models/match_model.dart';

abstract class TodayMatchesRemoteDate {
  Future getAllTodayMatches();
}

class TodayMatchesRemoteDataImpHttp implements TodayMatchesRemoteDate {
  final ApiClent apiClent;

  TodayMatchesRemoteDataImpHttp({required this.apiClent});

  @override
  Future<List<MatchModel>> getAllTodayMatches() async {
    final resalt = await apiClent.getData(
        uri: ApiConstants.apiBaseUrl + ApiConstants.todayMatches);
    if (resalt.statusCode == 200) {
      final List<MatchModel> matches = (resalt.body as List)
          .map((match) => MatchModel.fromJson(match as Map<String, dynamic>))
          .toList();
      return matches;
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
