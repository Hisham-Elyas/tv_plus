// ignore_for_file: avoid_print

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
      print('Error fetching league fixtures: $e');
    }
  }

  final dummyLeagueFixturesResponse = LeagueFixturesResponse(
    timezone: 'UTC',
    data: LeagueData(
      id: 1,
      // sportId: 1,
      // countryId: 1,
      // name: 'Premier League',
      // active: true,
      // imagePath: 'https://cdn.sportmonks.com/images/soccer/leagues/8.png',
      // type: 'league',
      // subType: 'league',
      // lastPlayedAt: '2023-08-15 20:00:00',
      // category: 1,
      // hasJerseys: false,
      upcoming: List.generate(10, (index) {
        return MatchDetails(
          id: 100 + index,
          sportId: 1,
          leagueId: 1,
          seasonId: 1,
          // stageId: 1,
          // stateId: 1,
          // venueId: 1,
          // name: 'Match ${index + 1}',
          startingAt: '2023-08-20 20:00:00',
          // leg: '1',
          // length: 90,
          // placeholder: false,
          // hasOdds: true,
          // hasPremiumOdds: false,
          // startingAtTimestamp: 1678886400,
          participants: [
            Participant(
              id: 200 + index * 2,
              sportId: 1,
              countryId: 1,
              // venueId: 1,
              // gender: 'male',
              name: 'Team ${index * 2 + 1}',
              imagePath: 'https://cdn.sportmonks.com/images/soccer/teams/1.png',
              // founded: 1886,
              // type: 'team',
              // placeholder: false,
              lastPlayedAt: '2023-08-15 20:00:00',
              meta: ParticipantMeta(
                location: 'home',
                winner: null,
                position: null,
              ),
            ),
            Participant(
              id: 200 + index * 2 + 1,
              sportId: 1,
              countryId: 1,
              // venueId: 1,
              // gender: 'male',
              name: 'Team ${index * 2 + 2}',
              imagePath: 'https://cdn.sportmonks.com/images/soccer/teams/2.png',
              // founded: 1892,
              // type: 'team',
              // placeholder: false,
              lastPlayedAt: '2023-08-15 20:00:00',
              meta: ParticipantMeta(
                location: 'away',
                winner: null,
                position: null,
              ),
            ),
          ],
          scores: [],
        );
      }),
      latest: List.generate(10, (index) {
        return MatchDetails(
          id: 300 + index,
          sportId: 1,
          leagueId: 1,
          seasonId: 1,
          // stageId: 1,
          // stateId: 1,
          // venueId: 1,
          // name: 'Match ${index + 6}',
          startingAt: '2023-08-15 20:00:00',
          // leg: '1',
          // length: 90,
          // placeholder: false,
          // hasOdds: true,
          // hasPremiumOdds: false,
          // startingAtTimestamp: 1678886400,
          participants: [
            Participant(
              id: 400 + index * 2,
              sportId: 1,
              countryId: 1,
              // venueId: 1,
              // gender: 'male',
              name: 'Team ${index * 2 + 11}',
              imagePath: 'https://cdn.sportmonks.com/images/soccer/teams/3.png',
              // founded: 1886,
              // type: 'team',
              // placeholder: false,
              lastPlayedAt: '2023-08-15 20:00:00',
              meta: ParticipantMeta(
                location: 'home',
                winner: null,
                position: null,
              ),
            ),
            Participant(
              id: 400 + index * 2 + 1,
              sportId: 1,
              countryId: 1,
              // venueId: 1,
              // gender: 'male',
              name: 'Team ${index * 2 + 12}',
              imagePath: 'https://cdn.sportmonks.com/images/soccer/teams/4.png',
              // founded: 1892,
              // type: 'team',
              // placeholder: false,
              lastPlayedAt: '2023-08-15 20:00:00',
              meta: ParticipantMeta(
                location: 'away',
                winner: null,
                position: null,
              ),
            ),
          ],
          scores: [
            Score(
              id: 500 + index * 2,
              fixtureId: 300 + index,
              typeId: 1,
              participantId: 400 + index * 2,
              score: ScoreDetails(goals: 2, participant: 'home'),
              description: 'FT',
            ),
            Score(
              id: 500 + index * 2 + 1,
              fixtureId: 300 + index,
              typeId: 1,
              participantId: 400 + index * 2 + 1,
              score: ScoreDetails(goals: 1, participant: 'away'),
              description: 'FT',
            ),
          ],
        );
      }),
    ),
  );
}
