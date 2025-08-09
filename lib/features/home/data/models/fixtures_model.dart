// ignore_for_file: public_member_api_docs, sort_constructors_first
class FixturesResponse {
  final List<League> data;
  final String timezone;

  FixturesResponse({required this.data, required this.timezone});

  factory FixturesResponse.fromJson(Map<String, dynamic> json) {
    return FixturesResponse(
      data: List<League>.from(json['data'].map((x) => League.fromJson(x))),
      timezone: json['timezone'],
    );
  }
}

class League {
  final int id;
  final String name;
  final String imagePath;
  final List<Fixture> today;

  League({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.today,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      imagePath: json['image_path'],
      today: List<Fixture>.from(json['today'].map((x) => Fixture.fromJson(x))),
    );
  }
}

class Fixture {
  final int id;
  final int channelCommmId;
  final String name;
  final int seasonId;
  final String startingAt;
  final List<Participant> participants;
  final List<Score> scores;

  Fixture({
    required this.id,
    required this.channelCommmId,
    required this.name,
    required this.startingAt,
    required this.participants,
    required this.scores,
    required this.seasonId,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'],
      channelCommmId: json['channel_commm_id'],
      seasonId: json["season_id"],
      name: json['name'],
      startingAt: json['starting_at'],
      participants: List<Participant>.from(
        json['participants'].map((x) => Participant.fromJson(x)),
      ),
      scores: json['scores'] != null
          ? List<Score>.from(json['scores'].map((x) => Score.fromJson(x)))
          : [],
    );
  }
}

class Participant {
  final String name;
  final String imagePath;
  final String location;

  Participant({
    required this.name,
    required this.imagePath,
    required this.location,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    final meta = json['meta'];
    String location = '';

    if (meta != null && meta is Map<String, dynamic>) {
      final loc = meta['location'];
      if (loc != null && loc is String) {
        location = loc;
      }
    }

    return Participant(
      name: json['name'] ?? '',
      imagePath: json['image_path'] ?? '',
      location: location,
    );
  }
}

class Score {
  final int id;
  final int fixtureId;
  final int typeId;
  final int participantId;
  final ScoreValue score;
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
      score: ScoreValue.fromJson(json['score']),
      description: json['description'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Score(id: $id, fixtureId: $fixtureId, typeId: $typeId, participantId: $participantId, score: $score, description: $description)';
  }

  @override
  bool operator ==(covariant Score other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fixtureId == fixtureId &&
        other.typeId == typeId &&
        other.participantId == participantId &&
        other.score == score &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fixtureId.hashCode ^
        typeId.hashCode ^
        participantId.hashCode ^
        score.hashCode ^
        description.hashCode;
  }
}

class ScoreValue {
  final int goals;
  final String participant;

  ScoreValue({
    required this.goals,
    required this.participant,
  });

  factory ScoreValue.fromJson(Map<String, dynamic> json) {
    return ScoreValue(
      goals: json['goals'],
      participant: json['participant'],
    );
  }

  @override
  String toString() => 'ScoreValue(goals: $goals, participant: $participant)';

  @override
  bool operator ==(covariant ScoreValue other) {
    if (identical(this, other)) return true;

    return other.goals == goals && other.participant == participant;
  }

  @override
  int get hashCode => goals.hashCode ^ participant.hashCode;
}
