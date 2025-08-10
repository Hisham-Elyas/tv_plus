// ignore_for_file: avoid_print

import 'dart:async';

import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../core/helpers/enums.dart';
import '../data/models/fixture_detail_model.dart';
import '../data/repos/fixtures_repo.dart';

class FixtureDetailController extends GetxController {
  final FixturesRepoImpHttp repository = Get.find();

  var isLoading = false.obs;
  var selectedTabIndex = 1.obs;
  var fixture = Rxn<FixtureDetail>();
  Rx<StatusRequest> statusReq = StatusRequest.none.obs;

  /// 👇 Your variables
  var currentTime = Rxn<DateTime>();
  var fixtureTimezone = Rxn<String>();

  Timer? _refreshTimer;

  @override
  void onInit() {
    super.onInit();
    fixture.value = dummyFixtureDetail;
    _startTicker();
    _startAutoRefresh();
  }

  final Set<String> liveStates = {
    'INPLAY_1ST_HALF',
    'INPLAY_2ND_HALF',
    'INPLAY_ET',
    'INPLAY_ET_2ND_HALF',
    'INPLAY_PENALTIES',
    'HT',
    'BREAK',
    'EXTRA_TIME_BREAK',
    'PEN_BREAK',
  };

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final match = fixture.value;
      if (match == null) return;
      // Only refresh if match is in a live state
      if (liveStates.contains(match.state.developerName)) {
        // await loadFixture(match.id.toString());
        final response = await repository.getFixturDetiels(
            fixturId: match.id.toString(),
            channelCommmId: match.channelCommmId);
        response.fold(
          (error) {
            print("Error loading fixture: $error");
          },
          (data) {
            fixture.value = data.data;
            print("Fixture refreshed: ${fixture.value?.name}");

            // ✅ Set timezone string like "Asia/Riyadh"
            fixtureTimezone.value = data.timezone; // <— get from API or model

            // statusReq.value = StatusRequest.success;
          },
        );
      }
    });
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  void _startTicker() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (fixtureTimezone.value != null) {
        final location = tz.getLocation(fixtureTimezone.value!);
        currentTime.value = tz.TZDateTime.now(location);
      }
      return true;
    });
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  Future<void> loadFixture(
      {required String fixtureId, required String channelCommmId}) async {
    try {
      isLoading(true);
      statusReq.value = StatusRequest.loading;
      final response = await repository.getFixturDetiels(
          fixturId: fixtureId, channelCommmId: channelCommmId);
      response.fold(
        (error) {
          statusReq.value = error;
          print("Error loading fixture: $error");
        },
        (data) {
          fixture.value = data.data;

          // ✅ Set timezone string like "Asia/Riyadh"
          fixtureTimezone.value = data.timezone; // <— get from API or model

          statusReq.value = StatusRequest.success;
        },
      );
    } catch (e) {
      statusReq.value = StatusRequest.serverFailure;
      print(e);
      Get.snackbar("Error", "Failed to load fixture details");
    } finally {
      isLoading(false);
    }
  }

  final dummyFixtureDetail = FixtureDetail(
    channelCommmId: '1',
    channelComm: [
      ChannelCommentator(
          tvChannelLink: [],
          channel: 0,
          channelName: "Sample",
          commentator: 1,
          commentatorName: "Sample",
          sound: 1),
    ],
    id: 1,
    name: "Sample",
    resultInfo: "2-1",
    startingAt: DateTime.now(),
    participants: [
      Participant(
        id: 1,
        name: "Team A",
        imagePath: "https://cdn.sportmonks.com/images/soccer/teams/22/86.png",
        winner: true,
      ),
      Participant(
        id: 2,
        name: "Team B",
        imagePath: "https://cdn.sportmonks.com/images/soccer/teams/22/86.png",
        winner: false,
      ),
    ],
    events: [],
    league: League(
      id: 1,
      name: "Premier",
      imagePath: "https://cdn.sportmonks.com/images/soccer/teams/22/86.png",
    ),
    venue: Venue(
      id: 1,
      name: "Stadium",
      address: "123 Main St",
      cityName: "City",
      imagePath: null,
      surface: "Grass",
      capacity: 10,
    ),
    state: State(
      id: 1,
      name: "Finished",
      shortName: "FT",
      developerName: "finished",
    ),
    scores: [
      Score(
        id: 1,
        participantId: 1,
        score: ScoreDetail(goals: 2, participant: "Team"),
        description: "Final",
      ),
      Score(
        id: 2,
        participantId: 2,
        score: ScoreDetail(goals: 1, participant: "Team"),
        description: "Final",
      ),
    ],
    sidelined: [],
    weatherReport: null,
    statistics: [],
  );
}
