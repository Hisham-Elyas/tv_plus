class UpcomingFixturesResponse {
  final Team data;
  final String timezone;

  UpcomingFixturesResponse({required this.data, required this.timezone});

  factory UpcomingFixturesResponse.fromJson(Map<String, dynamic> json) {
    return UpcomingFixturesResponse(
      data: Team.fromJson(json['data']),
      timezone: json['timezone'],
    );
  }
}

class Team {
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
  final List<Match> upcoming;
  final List<Match> latest;
  final String lastPlayedAt;

  Team({
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
    required this.upcoming,
    required this.latest,
    required this.lastPlayedAt,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
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
      upcoming:
          List<Match>.from(json['upcoming'].map((x) => Match.fromJson(x))),
      latest: List<Match>.from(json['latest'].map((x) => Match.fromJson(x))),
      lastPlayedAt: json['last_played_at'],
    );
  }
}

class Match {
  final int id;
  final String name;
  final String startingAt;
  final int leagueId;
  final League league;
  final List<Participant> participants;

  Match({
    required this.id,
    required this.name,
    required this.startingAt,
    required this.leagueId,
    required this.league,
    required this.participants,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      name: json['name'],
      startingAt: json['starting_at'],
      leagueId: json['league_id'],
      league: League.fromJson(json['league']),
      participants: List<Participant>.from(
          json['participants'].map((x) => Participant.fromJson(x))),
    );
  }
}

class League {
  final int id;
  final String name;
  final String shortCode;
  final String imagePath;

  League({
    required this.id,
    required this.name,
    required this.shortCode,
    required this.imagePath,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      shortCode: json['short_code'],
      imagePath: json['image_path'],
    );
  }
}

class Participant {
  final int id;
  final String name;
  final String imagePath;
  final Meta meta;

  Participant({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.meta,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      name: json['name'],
      imagePath: json['image_path'],
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Meta {
  final String location;

  Meta({required this.location});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(location: json['location']);
  }
}
