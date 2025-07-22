import 'package:get/get.dart';

import '../../../../core/helpers/enums.dart';
import '../data/models/team_fixtures_response_model.dart';
import '../data/repos/fixtures_repo.dart';

class TeamUpcomingMatchesController extends GetxController {
  final FixturesRepoImpHttp repository = Get.find();

  var upcomingMatches = Rxn<UpcomingFixturesResponse>();
  var statusReq = StatusRequest.none.obs;

  Future<void> getUpcomingMatches(String teamId) async {
    statusReq.value = StatusRequest.loading;

    final result = await repository.getUpcomingMatchesByTeam(teamId: teamId);

    result.fold(
      (failure) {
        statusReq.value = failure;
      },
      (data) {
        upcomingMatches.value = data;
        statusReq.value = StatusRequest.success;
      },
    );
  }
}
