import 'package:get/get.dart';

import '../../../core/helpers/enums.dart';
import '../data/models/leagues_response_model.dart';
import '../data/repos/fixtures_repo.dart';

class LeaguesController extends GetxController {
  final FixturesRepoImpHttp repo = Get.find();

  Rx<StatusRequest> statusReq = StatusRequest.loading.obs;
  final _leagues = <LeagueData>[].obs;
  final List<LeagueData> dummyLeagues = List.generate(
    12,
    (index) => LeagueData(
      id: index,
      sportId: 1,
      countryId: 1,
      name: 'League $index',
      active: true,
      shortCode: 'L$index',
      imagePath: '',
      type: 'Type',
      subType: 'SubType',
      lastPlayedAt: '',
      category: 1,
      hasJerseys: false,
      currentSeason: null,
    ),
  );

  @override
  void onInit() {
    getAllLeagues();
    super.onInit();
  }

  Future<void> getAllLeagues() async {
    statusReq.value = StatusRequest.loading;
    update();
    final result = await repo.getLeagues();
    result.fold((l) {
      statusReq.value = l;
      update();
    }, (r) {
      _leagues.value = r.data;
      statusReq.value = StatusRequest.success;
      update();
    });
  }

  List<LeagueData> get getLeaguesList {
    return _leagues;
  }

  List<LeagueData> get getLeagues {
    if (statusReq.value == StatusRequest.loading) {
      return dummyLeagues;
    } else if (_leagues.isEmpty) {
      getAllLeagues();
      return dummyLeagues; // Return dummy data while loading
    } else {
      return _leagues;
    }
  }
}
