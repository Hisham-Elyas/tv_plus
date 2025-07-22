import 'package:timezone/timezone.dart' as tz;

class FixtureDetailResponse {
  final FixtureDetail data;
  final String timezone;

  FixtureDetailResponse({required this.data, required this.timezone});

  factory FixtureDetailResponse.fromJson(Map<String, dynamic> json) {
    return FixtureDetailResponse(
      data: FixtureDetail.fromJson(json['data'], timezone: json['timezone']),
      timezone: json['timezone'],
    );
  }
}

class FixtureDetail {
  final int id;
  final String name;
  final String? resultInfo;
  final DateTime startingAt;
  final List<Participant> participants;
  final List<Event> events;
  final League league;
  final Venue venue;
  final State state;
  final List<Score> scores;
  final List<Sideline>? sidelined;
  final WeatherReport? weatherReport;
  final List<Statistic> statistics;

  FixtureDetail({
    required this.id,
    required this.name,
    this.resultInfo,
    required this.startingAt,
    required this.participants,
    required this.events,
    required this.league,
    required this.venue,
    required this.state,
    required this.scores,
    this.sidelined,
    this.weatherReport,
    required this.statistics,
  });

  factory FixtureDetail.fromJson(Map<String, dynamic> json,
      {required String timezone}) {
    // Parse the datetime string
    DateTime utcTime = DateTime.parse(json['starting_at']);

    // Convert to local time using the timezone
    DateTime localTime = _convertToTimeZone(utcTime, timezone);
    return FixtureDetail(
      id: json['id'],
      name: json['name'],
      resultInfo: json['result_info'],
      startingAt: DateTime.parse(json['starting_at']),
      // startingAt: localTime,
      participants: List<Participant>.from(
        (json['participants'] ?? []).map((x) => Participant.fromJson(x)),
      ),
      events: List<Event>.from(
        (json['events'] ?? []).map((x) => Event.fromJson(x)),
      ),
      league: League.fromJson(json['league']),
      venue: Venue.fromJson(json['venue']),
      state: State.fromJson(json['state']),
      statistics: json['statistics'] != null
          ? List<Statistic>.from(
              json['statistics'].map((x) => Statistic.fromJson(x)))
          : [],
      scores: List<Score>.from(
        (json['scores'] ?? []).map((x) => Score.fromJson(x)),
      ),
      sidelined: json['sidelined'] == null
          ? null
          : List<Sideline>.from(
              json['sidelined'].map((x) => Sideline.fromJson(x))),
      weatherReport: json['weatherreport'] != null
          ? WeatherReport.fromJson(json['weatherreport'])
          : null,
    );
  }
}

DateTime _convertToTimeZone(DateTime utcTime, String timeZone) {
  final location = tz.getLocation(timeZone);
  final tz.TZDateTime tzTime = tz.TZDateTime.from(utcTime.toUtc(), location);
  return tzTime;
}

class Sideline {
  final int id;
  final int fixtureId;
  final int sidelineId;
  final int participantId;
  final SidelineDetail sideline;

  Sideline({
    required this.id,
    required this.fixtureId,
    required this.sidelineId,
    required this.participantId,
    required this.sideline,
  });

  factory Sideline.fromJson(Map<String, dynamic> json) {
    return Sideline(
      id: json['id'],
      fixtureId: json['fixture_id'],
      sidelineId: json['sideline_id'],
      participantId: json['participant_id'],
      sideline: SidelineDetail.fromJson(json['sideline']),
    );
  }
}

class SidelineDetail {
  final int id;
  final String category;
  final Player player;
  final TypeInfo type;

  SidelineDetail({
    required this.id,
    required this.category,
    required this.player,
    required this.type,
  });

  factory SidelineDetail.fromJson(Map<String, dynamic> json) {
    return SidelineDetail(
      id: json['id'],
      category: json['category'],
      player: Player.fromJson(json['player']),
      type: TypeInfo.fromJson(json['type']),
    );
  }
}

class TypeInfo {
  final int id;
  final String name;

  TypeInfo({
    required this.id,
    required this.name,
  });

  factory TypeInfo.fromJson(Map<String, dynamic> json) {
    return TypeInfo(
      id: json['id'],
      name: json['name'],
    );
  }
}

class WeatherReport {
  final int id;
  final String description;
  final String icon;
  final double pressure;
  final String humidity;
  final String clouds;
  final Wind wind;
  final Temperature temperature;
  final Temperature feelsLike;

  WeatherReport({
    required this.id,
    required this.description,
    required this.icon,
    required this.pressure,
    required this.humidity,
    required this.clouds,
    required this.wind,
    required this.temperature,
    required this.feelsLike,
  });

  factory WeatherReport.fromJson(Map<String, dynamic> json) {
    return WeatherReport(
      id: json['id'],
      description: json['description'],
      icon: json['icon'],
      pressure: (json['pressure'] as num).toDouble(),
      humidity: json['humidity'],
      clouds: json['clouds'],
      wind: Wind.fromJson(json['wind']),
      temperature: Temperature.fromJson(json['temperature']),
      feelsLike: Temperature.fromJson(json['feels_like']),
    );
  }
}

class Wind {
  final double speed;
  final int direction;

  Wind({
    required this.speed,
    required this.direction,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num).toDouble(),
      direction: json['direction'],
    );
  }
}

class Temperature {
  final double day;
  final double morning;
  final double evening;
  final double night;

  Temperature({
    required this.day,
    required this.morning,
    required this.evening,
    required this.night,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      day: (json['day'] as num).toDouble(),
      morning: (json['morning'] as num).toDouble(),
      evening: (json['evening'] as num).toDouble(),
      night: (json['night'] as num).toDouble(),
    );
  }
}

class Participant {
  final int id;
  final String name;
  final String imagePath;
  final bool winner;

  Participant({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.winner,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      name: json['name'],
      imagePath: json['image_path'],
      winner: json['meta']['winner'] ?? false,
    );
  }
}

class Event {
  final int id;
  final int fixtureId;
  final int periodId;
  final int participantId;
  final int typeId;
  final String section;
  final int? playerId;
  final int? relatedPlayerId;
  final String? playerName;
  final String? relatedPlayerName;
  final String? result;
  final String? info;
  final String? addition;
  final int minute;
  final int? extraMinute;
  final bool? injured;
  final bool onBench;
  final int? coachId;
  final int? subTypeId;
  final int? detailedPeriodId;
  final bool? rescinded;
  final int sortOrder;
  final EventType type;
  final Period period;
  final Player? player;

  Event({
    required this.id,
    required this.fixtureId,
    required this.periodId,
    required this.participantId,
    required this.typeId,
    required this.section,
    this.playerId,
    this.relatedPlayerId,
    this.playerName,
    this.relatedPlayerName,
    this.result,
    this.info,
    this.addition,
    required this.minute,
    this.extraMinute,
    this.injured,
    required this.onBench,
    this.coachId,
    this.subTypeId,
    this.detailedPeriodId,
    this.rescinded,
    required this.sortOrder,
    required this.type,
    required this.period,
    this.player,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      fixtureId: json['fixture_id'],
      periodId: json['period_id'],
      participantId: json['participant_id'],
      typeId: json['type_id'],
      section: json['section'],
      playerId: json['player_id'],
      relatedPlayerId: json['related_player_id'],
      playerName: json['player_name'],
      relatedPlayerName: json['related_player_name'],
      result: json['result'],
      info: json['info'],
      addition: json['addition'],
      minute: json['minute'],
      extraMinute: json['extra_minute'],
      injured: json['injured'],
      onBench: json['on_bench'] ?? false,
      coachId: json['coach_id'],
      subTypeId: json['sub_type_id'],
      detailedPeriodId: json['detailed_period_id'],
      rescinded: json['rescinded'],
      sortOrder: json['sort_order'],
      type: EventType.fromJson(json['type']),
      period: Period.fromJson(json['period']),
      player: json['player'] != null ? Player.fromJson(json['player']) : null,
    );
  }
}

class EventType {
  final int id;
  final String name;
  final String code;
  final String developerName;
  final String modelType;
  final dynamic statGroup;

  EventType({
    required this.id,
    required this.name,
    required this.code,
    required this.developerName,
    required this.modelType,
    this.statGroup,
  });

  factory EventType.fromJson(Map<String, dynamic> json) {
    return EventType(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      developerName: json['developer_name'],
      modelType: json['model_type'],
      statGroup: json['stat_group'],
    );
  }
}

class Period {
  final int id;
  final int fixtureId;
  final int typeId;
  final int started;
  final int? ended;
  final int countsFrom;
  final bool ticking;
  final int sortOrder;
  final String description;
  final int? timeAdded;
  final int periodLength;
  final int minutes;
  final int seconds;
  final bool hasTimer;

  Period({
    required this.id,
    required this.fixtureId,
    required this.typeId,
    required this.started,
    this.ended,
    required this.countsFrom,
    required this.ticking,
    required this.sortOrder,
    required this.description,
    this.timeAdded,
    required this.periodLength,
    required this.minutes,
    required this.seconds,
    required this.hasTimer,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      id: json['id'],
      fixtureId: json['fixture_id'],
      typeId: json['type_id'],
      started: json['started'],
      ended: json['ended'],
      countsFrom: json['counts_from'],
      ticking: json['ticking'],
      sortOrder: json['sort_order'],
      description: json['description'],
      timeAdded: json['time_added'],
      periodLength: json['period_length'],
      minutes: json['minutes'],
      seconds: json['seconds'],
      hasTimer: json['has_timer'],
    );
  }
}

class Player {
  final int id;
  // final int sportId;
  // final int countryId;
  // final int? nationalityId;
  // final int? cityId;
  // final int positionId;
  // final int? detailedPositionId;
  // final int? typeId;
  final String commonName;
  final String firstname;
  final String lastname;
  final String name;
  final String displayName;
  final String imagePath;
  // final int? height;
  // final int? weight;
  // final String? dateOfBirth;
  // final String gender;

  Player({
    required this.id,
    // required this.sportId,
    // required this.countryId,
    // this.nationalityId,
    // this.cityId,
    // required this.positionId,
    // this.detailedPositionId,
    // this.typeId,
    required this.commonName,
    required this.firstname,
    required this.lastname,
    required this.name,
    required this.displayName,
    required this.imagePath,
    // this.height,
    // this.weight,
    // this.dateOfBirth,
    // required this.gender,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      // sportId: json['sport_id'],
      // countryId: json['country_id'],
      // nationalityId: json['nationality_id'],
      // cityId: json['city_id'],
      // positionId: json['position_id'],
      // detailedPositionId: json['detailed_position_id'],
      // typeId: json['type_id'],
      commonName: json['common_name'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      name: json['name'],
      displayName: json['display_name'],
      imagePath: json['image_path'],
      // height: json['height'],
      // weight: json['weight'],
      // dateOfBirth: json['date_of_birth'],
      // gender: json['gender'],
    );
  }
}

class League {
  final int id;
  final String name;
  final String imagePath;

  League({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      imagePath: json['image_path'],
    );
  }
}

class Venue {
  final int id;
  final String name;
  final String address;
  final String cityName;
  final String? imagePath;
  final String surface;
  final int capacity;

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.cityName,
    this.imagePath,
    required this.surface,
    required this.capacity,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      cityName: json['city_name'],
      imagePath: json['image_path'],
      surface: json['surface'],
      capacity: json['capacity'],
    );
  }
}

class State {
  final int id;
  final String name;
  final String shortName;
  final String developerName;

  State({
    required this.id,
    required this.name,
    required this.shortName,
    required this.developerName,
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id'],
      name: json['name'],
      shortName: json['short_name'],
      developerName: json['developer_name'],
    );
  }
}

class Score {
  final int id;
  final int participantId;
  final ScoreDetail score;
  final String description;

  Score({
    required this.id,
    required this.participantId,
    required this.score,
    required this.description,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      id: json['id'],
      participantId: json['participant_id'],
      score: ScoreDetail.fromJson(json['score']),
      description: json['description'],
    );
  }
}

class ScoreDetail {
  final int goals;
  final String participant;

  ScoreDetail({
    required this.goals,
    required this.participant,
  });

  factory ScoreDetail.fromJson(Map<String, dynamic> json) {
    return ScoreDetail(
      goals: json['goals'],
      participant: json['participant'],
    );
  }
}

class Statistic {
  final int id;
  final int fixtureId;
  final int typeId;
  final int participantId;
  final Map<String, dynamic> data;
  final String location;
  final StatisticType type;

  Statistic({
    required this.id,
    required this.fixtureId,
    required this.typeId,
    required this.participantId,
    required this.data,
    required this.location,
    required this.type,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      id: json['id'],
      fixtureId: json['fixture_id'],
      typeId: json['type_id'],
      participantId: json['participant_id'],
      data: json['data'],
      location: json['location'],
      type: StatisticType.fromJson(json['type']),
    );
  }
}

class StatisticType {
  final int id;
  final String name;
  final String code;
  final String developerName;
  final String modelType;
  final String statGroup;

  StatisticType({
    required this.id,
    required this.name,
    required this.code,
    required this.developerName,
    required this.modelType,
    required this.statGroup,
  });

  factory StatisticType.fromJson(Map<String, dynamic> json) {
    return StatisticType(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      developerName: json['developer_name'],
      modelType: json['model_type'],
      statGroup: json['stat_group'],
    );
  }
}
