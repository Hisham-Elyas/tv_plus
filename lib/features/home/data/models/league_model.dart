// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'match_model.dart';

class LeagueModel {
  final String league;
  final String leagueLogo;
  final List<MatchModel> matches;

  LeagueModel({
    required this.league,
    required this.leagueLogo,
    required this.matches,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      league: json['league'],
      leagueLogo: json['leagueLogo'],
      matches: (json['matches'] as List)
          .map((item) => MatchModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'league': league,
      'leagueLogo': leagueLogo,
      'matches': matches.map((item) => item.toJson()).toList(),
    };
  }

  @override
  bool operator ==(covariant LeagueModel other) {
    if (identical(this, other)) return true;

    return other.league == league &&
        other.leagueLogo == leagueLogo &&
        listEquals(other.matches, matches);
  }

  @override
  int get hashCode => league.hashCode ^ leagueLogo.hashCode ^ matches.hashCode;
}
