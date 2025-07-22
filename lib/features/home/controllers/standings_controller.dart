import 'package:get/get.dart';

import '../../../../core/helpers/enums.dart';
import '../data/models/standing_model.dart';
import '../data/repos/fixtures_repo.dart';

class StandingsController extends GetxController {
  final FixturesRepoImpHttp repository = Get.find();

  var standings = Rxn<StandingsResponse>();
  var statusReq = StatusRequest.none.obs;

  Future<void> getStandings(String seasonId) async {
    statusReq.value = StatusRequest.loading;

    final result = await repository.getStandings(seasonId: seasonId);

    result.fold(
      (failure) {
        statusReq.value = failure;
      },
      (data) {
        standings.value = data;
        statusReq.value = StatusRequest.success;
      },
    );
  }
}
