import 'package:faisal_tv/core/helpers/enums.dart';
import 'package:faisal_tv/features/home/data/models/league_fixtures_response_model.dart';
import 'package:faisal_tv/features/home/data/repos/fixtures_repo.dart';
import 'package:get/get.dart';

class LeaguematchController extends GetxController {
  final FixturesRepoImpHttp fixturesRepo = Get.find();

  LeaguematchController();

  final Rx<StatusRequest> statusReq = StatusRequest.none.obs;
  final Rx<LeagueFixturesResponse?> fixtures =
      Rx<LeagueFixturesResponse?>(null);

  Future<void> getLeagueFixtures(String leagueId) async {
    statusReq.value = StatusRequest.loading;
    try {
      final result = await fixturesRepo.getMatchesForLeague(leagueId: leagueId);
      result.fold(
        (failure) {
          statusReq.value = failure;
        },
        (success) {
          fixtures.value = success;
          statusReq.value = StatusRequest.success;
        },
      );
    } catch (e) {
      statusReq.value = StatusRequest.serverFailure;
    }
  }
}
