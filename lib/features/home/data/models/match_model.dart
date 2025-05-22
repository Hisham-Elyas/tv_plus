// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

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

  @override
  bool operator ==(covariant MatchModel other) {
    if (identical(this, other)) return true;

    return other.league == league &&
        other.leagueLogo == leagueLogo &&
        other.homeTeam == homeTeam &&
        other.awayTeam == awayTeam &&
        other.homeTeamLogo == homeTeamLogo &&
        other.awayTeamLogo == awayTeamLogo &&
        other.matchDate == matchDate &&
        other.matchTime == matchTime &&
        listEquals(other.channelsAndCommentators, channelsAndCommentators);
  }

  @override
  int get hashCode {
    return league.hashCode ^
        leagueLogo.hashCode ^
        homeTeam.hashCode ^
        awayTeam.hashCode ^
        homeTeamLogo.hashCode ^
        awayTeamLogo.hashCode ^
        matchDate.hashCode ^
        matchTime.hashCode ^
        channelsAndCommentators.hashCode;
  }
}
