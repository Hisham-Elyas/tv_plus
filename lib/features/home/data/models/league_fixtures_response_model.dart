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
      upcoming: List<MatchDetails>.from(json['upcoming'].map((item) => MatchDetails.fromJson(item))),
      latest: List<MatchDetails>.from(json['latest'].map((item) => MatchDetails.fromJson(item))),
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
    );
  }
}
