import 'package:get/get.dart';

import '../../../../core/helpers/enums.dart';
import '../data/models/scorers_response_model.dart';
import '../data/repos/fixtures_repo.dart'; // assuming it's in same fixtures repo

class TopScorersController extends GetxController {
  final FixturesRepoImpHttp repository = Get.find();

  var statusReq = StatusRequest.none.obs;

  // Current selected type
  var selectedType = ScorerType.goals.obs;

  // Holds result for UI
  var scorers = Rxn<ScorersResponse>();

  // Internal cache to avoid refetching
  final Map<ScorerType, ScorersResponse> _cachedByType = {};

  Future<void> getTopScorers({
    required String seasonId,
    ScorerType? type,
    bool forceRefresh = false,
  }) async {
    final queryType = type ?? selectedType.value;

    // If already cached
    if (!forceRefresh && _cachedByType.containsKey(queryType)) {
      scorers.value = _cachedByType[queryType];
      statusReq.value = StatusRequest.success;
      return;
    }

    statusReq.value = StatusRequest.loading;

    final result = await repository.getTopScorers(
      seasonId: seasonId,
      type: queryType,
    );

    result.fold(
      (failure) {
        statusReq.value = failure;
      },
      (data) {
        scorers.value = data;
        _cachedByType[queryType] = data;
        statusReq.value = StatusRequest.success;
      },
    );
  }

  void changeType(ScorerType type, String seasonId) {
    selectedType.value = type;
    getTopScorers(seasonId: seasonId, type: type);
    update();
  }

  final dummyScorersResponse = ScorersResponse(
    timezone: 'UTC',
    data: List.generate(10, (index) {
      return Scorer(
        id: index,
        position: index + 1,
        total: 10 - index,
        player: Player(
          id: 100 + index,
          displayName: 'Player ${index + 1}',
          imagePath:
              'https://cdn.sportmonks.com/images/soccer/teams/22/86.png', // Use a placeholder image
          nationality: 'Country ${index + 1}',
          position: index % 2 == 0 ? 'Forward' : 'Midfielder',
        ),
        participant: Team(
          id: 200 + index,
          name: 'Team ${index + 1}',
          imagePath:
              'https://cdn.sportmonks.com/images/soccer/teams/22/86.png', // Use a placeholder image
        ),
      );
    }),
  );
}
