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
}
