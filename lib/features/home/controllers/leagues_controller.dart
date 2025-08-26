import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/helpers/shared_pref_helper.dart';
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

  static const String favoriteLeaguesKey = 'favorite_leagues';
  final RxList<int> favoriteLeagues = <int>[].obs;

  Future<void> saveFavoriteLeagues() async {
    await SharedPrefHelper.setData(
      favoriteLeaguesKey,
      jsonEncode(favoriteLeagues),
    );
  }

  Future<void> loadFavoriteLeagues() async {
    final leaguesString = await SharedPrefHelper.getString(favoriteLeaguesKey);
    if (leaguesString.isNotEmpty) {
      final List<dynamic> ids = jsonDecode(leaguesString);
      favoriteLeagues.assignAll(ids.cast<int>());
    }
  }

  void toggleFavorite(int leagueId) {
    if (favoriteLeagues.contains(leagueId)) {
      favoriteLeagues.remove(leagueId);
    } else {
      favoriteLeagues.add(leagueId);
    }
    saveFavoriteLeagues();
    update();
  }

  bool isFavorite(int leagueId) {
    return favoriteLeagues.contains(leagueId);
  }

  @override
  void onInit() {
    loadFavoriteLeagues();
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
