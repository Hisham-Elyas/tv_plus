class LeagueFixturesResponse {
  final LeagueData data;
  final String timezone;

  LeagueFixturesResponse({
    required this.data,
    required this.timezone,
  });

  factory LeagueFixturesResponse.fromJson(Map<String, dynamic> json) {
    return LeagueFixturesResponse(
      data: LeagueData.fromJson(json['data']),
      timezone: json['timezone'],
    );
  }
}

class LeagueData {
  final int id;
  final int sportId;
  final int countryId;
  final String name;
  final bool active;
  final String? shortCode;
  final String imagePath;
  final String type;
  final String subType;
  final String lastPlayedAt;
  final int category;
  final bool hasJerseys;
  final List<MatchDetails> upcoming;
  final List<MatchDetails> latest;

  LeagueData({
    required this.id,
    required this.sportId,
    required this.countryId,
    required this.name,
    required this.active,
    this.shortCode,
    required this.imagePath,
    required this.type,
    required this.subType,
    required this.lastPlayedAt,
    required this.category,
    required this.hasJerseys,
    required this.upcoming,
    required this.latest,
  });

  factory LeagueData.fromJson(Map<String, dynamic> json) {
    return LeagueData(
      id: json['id'],
      sportId: json['sport_id'],
      countryId: json['country_id'],
      name: json['name'],
      active: json['active'],
      shortCode: json['short_code'],
      imagePath: json['image_path'],
      type: json['type'],
      subType: json['sub_type'],
      lastPlayedAt: json['last_played_at'],
      category: json['category'],
      hasJerseys: json['has_jerseys'],
      upcoming: List<MatchDetails>.from(
          json['upcoming'].map((item) => MatchDetails.fromJson(item))),
      latest: List<MatchDetails>.from(
          json['latest'].map((item) => MatchDetails.fromJson(item))),
    );
  }
}

class MatchDetails {
  final int id;
  final int sportId;
  final int leagueId;
  final int seasonId;
  final int stageId;
  final int? groupId;
  final int? aggregateId;
  final int? roundId;
  final int stateId;
  final int venueId;
  final String name;
  final String startingAt;
  final String? resultInfo;
  final String leg;
  final String? details;
  final int length;
  final bool placeholder;
  final bool hasOdds;
  final bool hasPremiumOdds;
  final int startingAtTimestamp;
  final List<Participant> participants;
  final List<Score> scores;

  MatchDetails({
    required this.id,
    required this.sportId,
    required this.leagueId,
    required this.seasonId,
    required this.stageId,
    this.groupId,
    this.aggregateId,
    this.roundId,
    required this.stateId,
    required this.venueId,
    required this.name,
    required this.startingAt,
    this.resultInfo,
    required this.leg,
    this.details,
    required this.length,
    required this.placeholder,
    required this.hasOdds,
    required this.hasPremiumOdds,
    required this.startingAtTimestamp,
    required this.participants,
    required this.scores,
  });

  factory MatchDetails.fromJson(Map<String, dynamic> json) {
    return MatchDetails(
      id: json['id'],
      sportId: json['sport_id'],
      leagueId: json['league_id'],
      seasonId: json['season_id'],
      stageId: json['stage_id'],
      groupId: json['group_id'],
      aggregateId: json['aggregate_id'],
      roundId: json['round_id'],
      stateId: json['state_id'],
      venueId: json['venue_id'],
      name: json['name'],
      startingAt: json['starting_at'],
      resultInfo: json['result_info'],
      leg: json['leg'],
      details: json['details'],
      length: json['length'],
      placeholder: json['placeholder'],
      hasOdds: json['has_odds'],
      hasPremiumOdds: json['has_premium_odds'],
      startingAtTimestamp: json['starting_at_timestamp'],
      participants: json['participants'] != null
          ? List<Participant>.from(
              json['participants'].map((x) => Participant.fromJson(x)))
          : [],
      scores: json['scores'] != null
          ? List<Score>.from(json['scores'].map((x) => Score.fromJson(x)))
          : [],
    );
  }
}

class Participant {
  final int id;
  final int sportId;
  final int countryId;
  final int venueId;
  final String gender;
  final String name;
  final String? shortCode;
  final String imagePath;
  final int founded;
  final String type;
  final bool placeholder;
  final String lastPlayedAt;
  final ParticipantMeta meta;

  Participant({
    required this.id,
    required this.sportId,
    required this.countryId,
    required this.venueId,
    required this.gender,
    required this.name,
    this.shortCode,
    required this.imagePath,
    required this.founded,
    required this.type,
    required this.placeholder,
    required this.lastPlayedAt,
    required this.meta,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      sportId: json['sport_id'],
      countryId: json['country_id'],
      venueId: json['venue_id'],
      gender: json['gender'],
      name: json['name'],
      shortCode: json['short_code'],
      imagePath: json['image_path'],
      founded: json['founded'],
      type: json['type'],
      placeholder: json['placeholder'],
      lastPlayedAt: json['last_played_at'],
      meta: ParticipantMeta.fromJson(json['meta']),
    );
  }
}

class ParticipantMeta {
  final String location;
  final bool? winner;
  final int? position;

  ParticipantMeta({
    required this.location,
    this.winner,
    this.position,
  });

  factory ParticipantMeta.fromJson(Map<String, dynamic> json) {
    return ParticipantMeta(
      location: json['location'],
      winner: json['winner'],
      position: json['position'],
    );
  }
}

class Score {
  final int id;
  final int fixtureId;
  final int typeId;
  final int participantId;
  final ScoreDetails score;
  final String description;

  Score({
    required this.id,
    required this.fixtureId,
    required this.typeId,
    required this.participantId,
    required this.score,
    required this.description,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      id: json['id'],
      fixtureId: json['fixture_id'],
      typeId: json['type_id'],
      participantId: json['participant_id'],
      score: ScoreDetails.fromJson(json['score']),
      description: json['description'],
    );
  }
}

class ScoreDetails {
  final int goals;
  final String participant;

  ScoreDetails({
    required this.goals,
    required this.participant,
  });

  factory ScoreDetails.fromJson(Map<String, dynamic> json) {
    return ScoreDetails(
      goals: json['goals'],
      participant: json['participant'],
    );
  }
}
