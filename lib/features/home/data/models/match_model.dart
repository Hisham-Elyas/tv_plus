import 'channel_and_commentator_model.dart';

class MatchModel {
  final String league;
  final String leagueLogo;
  final String homeTeam;
  final String awayTeam;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final String matchDate;
  final String matchTime;
  final List<ChannelAndCommentator> channelsAndCommentators;

  MatchModel({
    required this.league,
    required this.leagueLogo,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.matchDate,
    required this.matchTime,
    required this.channelsAndCommentators,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      league: json['league'] ?? '',
      leagueLogo: json['leagueLogo'] ?? '',
      homeTeam: json['homeTeam'] ?? '',
      awayTeam: json['awayTeam'] ?? '',
      homeTeamLogo: json['homeTeamLogo'] ?? '',
      awayTeamLogo: json['awayTeamLogo'] ?? '',
      matchDate: json['matchDate'] ?? '',
      matchTime: json['matchTime'] ?? '',
      channelsAndCommentators: (json['channelsAndCommentators'] as List? ?? [])
          .map((item) => ChannelAndCommentator.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'league': league,
      'leagueLogo': leagueLogo,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'homeTeamLogo': homeTeamLogo,
      'awayTeamLogo': awayTeamLogo,
      'matchDate': matchDate,
      'matchTime': matchTime,
      'channelsAndCommentators':
          channelsAndCommentators.map((item) => item.toJson()).toList(),
    };
  }
}
