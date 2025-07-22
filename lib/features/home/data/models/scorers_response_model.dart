class ScorersResponse {
  final List<Scorer> data;
  final String timezone;

  ScorersResponse({required this.data, required this.timezone});

  factory ScorersResponse.fromJson(Map<String, dynamic> json) {
    return ScorersResponse(
      data: List<Scorer>.from(json['data'].map((x) => Scorer.fromJson(x))),
      timezone: json['timezone'],
    );
  }
}

class Scorer {
  final int id;
  final int position;
  final int total;
  final Player player;
  final Team participant;

  Scorer({
    required this.id,
    required this.position,
    required this.total,
    required this.player,
    required this.participant,
  });

  factory Scorer.fromJson(Map<String, dynamic> json) {
    return Scorer(
      id: json['id'],
      position: json['position'],
      total: json['total'],
      player: Player.fromJson(json['player']),
      participant: Team.fromJson(json['participant']),
    );
  }
}

class Player {
  final int id;
  final String displayName;
  final String imagePath;
  final String nationality;
  final String position;

  Player({
    required this.id,
    required this.displayName,
    required this.imagePath,
    required this.nationality,
    required this.position,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      displayName: json['display_name'] ?? json['name'] ?? 'Unknown',
      imagePath: json['image_path'] ?? '',
      nationality:
          (json['nationality'] != null && json['nationality']['name'] != null)
              ? json['nationality']['name']
              : 'Unknown',
      position: (json['position'] != null && json['position']['name'] != null)
          ? json['position']['name']
          : 'Unknown',
    );
  }
}

class Team {
  final int id;
  final String name;
  final String imagePath;

  Team({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      imagePath: json['image_path'],
    );
  }
}
