class LeaguesResponse {
  final List<LeagueData> data;
  final String timezone;

  LeaguesResponse({
    required this.data,
    required this.timezone,
  });

  factory LeaguesResponse.fromJson(Map<String, dynamic> json) {
    return LeaguesResponse(
      data: List<LeagueData>.from(
          json['data'].map((item) => LeagueData.fromJson(item))),
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
  final CurrentSeason? currentSeason;

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
    this.currentSeason,
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
      currentSeason: json['currentseason'] != null
          ? CurrentSeason.fromJson(json['currentseason'])
          : null,
    );
  }
}

class CurrentSeason {
  final int id;
  final int sportId;
  final int leagueId;
  final int? tieBreakerRuleId;
  final String name;
  final bool finished;
  final bool pending;
  final bool isCurrent;
  final String startingAt;
  final String endingAt;
  final String? standingsRecalculatedAt;
  final bool gamesInCurrentWeek;

  CurrentSeason({
    required this.id,
    required this.sportId,
    required this.leagueId,
    required this.tieBreakerRuleId,
    required this.name,
    required this.finished,
    required this.pending,
    required this.isCurrent,
    required this.startingAt,
    required this.endingAt,
    this.standingsRecalculatedAt,
    required this.gamesInCurrentWeek,
  });

  factory CurrentSeason.fromJson(Map<String, dynamic> json) {
    return CurrentSeason(
      id: json['id'],
      sportId: json['sport_id'],
      leagueId: json['league_id'],
      tieBreakerRuleId: json['tie_breaker_rule_id'],
      name: json['name'],
      finished: json['finished'],
      pending: json['pending'],
      isCurrent: json['is_current'],
      startingAt: json['starting_at'],
      endingAt: json['ending_at'],
      standingsRecalculatedAt: json['standings_recalculated_at'],
      gamesInCurrentWeek: json['games_in_current_week'],
    );
  }
}
