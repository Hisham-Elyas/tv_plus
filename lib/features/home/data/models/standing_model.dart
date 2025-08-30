class StandingsResponse {
  final List<Standing> data;
  final String timezone;

  StandingsResponse({required this.data, required this.timezone});

  factory StandingsResponse.fromJson(Map<String, dynamic> json) {
    return StandingsResponse(
      data: (json['data'] as List)
          .map((item) => Standing.fromJson(item))
          .toList(),
      timezone: json['timezone'],
    );
  }
}

class Standing {
  final int id;
  final int participantId;
  final int sportId;
  final int leagueId;
  final int seasonId;
  // final int stageId;
  // final int? groupId;
  // final int? roundId;
  // final int standingRuleId;
  final int position;
  // final String result;
  final int points;
  final Participant participant;
  // final Rule? rule;
  final List<StandingDetail> details;
  final List<Form> form;
  final Stage stage;
  final League league;

  Standing({
    required this.id,
    required this.participantId,
    required this.sportId,
    required this.leagueId,
    required this.seasonId,
    // required this.stageId,
    // required this.groupId,
    // this.roundId,
    // required this.standingRuleId,
    required this.position,
    // required this.result,
    required this.points,
    required this.participant,
    // required this.rule,
    required this.details,
    required this.form,
    required this.stage,
    required this.league,
  });

  factory Standing.fromJson(Map<String, dynamic> json) {
    return Standing(
      id: json['id'],
      participantId: json['participant_id'],
      sportId: json['sport_id'],
      leagueId: json['league_id'],
      seasonId: json['season_id'],
      // stageId: json['stage_id'],
      // groupId: json['group_id'],
      // roundId: json['round_id'],
      // standingRuleId: json['standing_rule_id'],
      position: json['position'],
      // result: json['result'],
      points: json['points'],
      participant: Participant.fromJson(json['participant']),
      // rule: Rule.fromJson(json['rule']),
      details: (json['details'] as List)
          .map((e) => StandingDetail.fromJson(e))
          .toList(),
      form: (json['form'] as List).map((e) => Form.fromJson(e)).toList(),
      stage: Stage.fromJson(json['stage']),
      league: League.fromJson(json['league']),
    );
  }
}

class Participant {
  final int id;
  final String name;
  final String? shortCode;
  final String imagePath;

  Participant({
    required this.id,
    required this.name,
    this.shortCode,
    required this.imagePath,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      name: json['name'],
      shortCode: json['short_code'],
      imagePath: json['image_path'],
    );
  }
}

class Rule {
  final int id;
  final int position;
  final RuleType type;

  Rule({required this.id, required this.position, required this.type});

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      id: json['id'],
      position: json['position'],
      type: RuleType.fromJson(json['type']),
    );
  }
}

class RuleType {
  final String name;
  final String code;

  RuleType({required this.name, required this.code});

  factory RuleType.fromJson(Map<String, dynamic> json) {
    return RuleType(
      name: json['name'],
      code: json['code'],
    );
  }
}

class StandingDetail {
  final int id;
  final int typeId;
  final int value;
  final DetailType type;

  StandingDetail({
    required this.id,
    required this.typeId,
    required this.value,
    required this.type,
  });

  factory StandingDetail.fromJson(Map<String, dynamic> json) {
    return StandingDetail(
      id: json['id'],
      typeId: json['type_id'],
      value: json['value'],
      type: DetailType.fromJson(json['type']),
    );
  }
}

class DetailType {
  final int id;
  final String name;
  final String code;

  DetailType({
    required this.id,
    required this.name,
    required this.code,
  });

  factory DetailType.fromJson(Map<String, dynamic> json) {
    return DetailType(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }
}

class Form {
  final int fixtureId;
  final String form;

  Form({required this.fixtureId, required this.form});

  factory Form.fromJson(Map<String, dynamic> json) {
    return Form(
      fixtureId: json['fixture_id'],
      form: json['form'],
    );
  }
}

class Stage {
  final int id;
  final String name;
  final bool finished;
  final bool isCurrent;

  Stage({
    required this.id,
    required this.name,
    required this.finished,
    required this.isCurrent,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      id: json['id'],
      name: json['name'],
      finished: json['finished'],
      isCurrent: json['is_current'],
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
