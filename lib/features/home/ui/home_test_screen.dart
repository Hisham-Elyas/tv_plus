import 'package:flutter/material.dart';

List<Match> sampleMatches = [
  Match(
    homeTeam: 'إيفرتون',
    awayTeam: 'توتنهام',
    time: '04:00 PM',
    league: 'الدوري الإنجليزي',
    homeTeamLogo: 'https://imgs.ysscores.com/teams/64/8461690118694.png',
    awayTeamLogo: 'https://imgs.ysscores.com/teams/64/2501692467226.png',
  ),
  Match(
    homeTeam: 'مانشستر يونايتد',
    awayTeam: 'برايتون',
    time: '04:00 PM',
    league: 'الدوري الإنجليزي',
    homeTeamLogo: 'https://imgs.ysscores.com/teams/64/8461690118694.png',
    awayTeamLogo: 'https://imgs.ysscores.com/teams/64/2501692467226.png',
  ),
  Match(
    homeTeam: 'الرجاء الرياضي',
    awayTeam: 'ماينما',
    time: '06:00 PM',
    league: 'دوري أبطال إفريقيا',
    homeTeamLogo: 'https://imgs.ysscores.com/teams/64/8461690118694.png',
    awayTeamLogo: 'https://imgs.ysscores.com/teams/64/2501692467226.png',
  ),
  Match(
    homeTeam: 'كالياري',
    awayTeam: 'ليتشي',
    time: '04:00 PM',
    league: 'الدوري الإيطالي',
    homeTeamLogo: 'https://imgs.ysscores.com/teams/64/8461690118694.png',
    awayTeamLogo: 'https://imgs.ysscores.com/teams/64/2501692467226.png',
  ),
];

class Match {
  final String homeTeam;
  final String awayTeam;
  final String time;
  final String league;
  final String homeTeamLogo;
  final String awayTeamLogo;

  Match({
    required this.homeTeam,
    required this.awayTeam,
    required this.time,
    required this.league,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
  });
}

class MatchScreen extends StatelessWidget {
  final List<Match> matches;

  const MatchScreen({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    Map<String, List<Match>> matchesByLeague = {
      // League name maps to matches
      'الدوري الإنجليزي':
          matches.where((m) => m.league == 'الدوري الإنجليزي').toList(),
      'دوري أبطال إفريقيا':
          matches.where((m) => m.league == 'دوري أبطال إفريقيا').toList(),
      'الدوري الإيطالي':
          matches.where((m) => m.league == 'الدوري الإيطالي').toList(),
    };

    Map<String, String> leagueLogos = {
      'الدوري الإنجليزي':
          'https://imgs.ysscores.com/championship/150/3411694791422.png',
      'دوري أبطال إفريقيا':
          'https://imgs.ysscores.com/championship/150/3411694791422.png',
      'الدوري الإيطالي':
          'https://imgs.ysscores.com/championship/150/3411694791422.png',
    };

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Matches'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: matchesByLeague.entries.map((entry) {
          String leagueName = entry.key;
          List<Match> leagueMatches = entry.value;

          return LeagueSection(
            leagueName: leagueName,
            leagueLogo: leagueLogos[leagueName]!,
            matches: leagueMatches.map((match) {
              return MatchCard(
                homeTeam: match.homeTeam,
                awayTeam: match.awayTeam,
                time: match.time,
                homeTeamLogo: match.homeTeamLogo,
                awayTeamLogo: match.awayTeamLogo,
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

class LeagueSection extends StatelessWidget {
  final String leagueName;
  final String leagueLogo;
  final List<Widget> matches;

  const LeagueSection({
    super.key,
    required this.leagueName,
    required this.leagueLogo,
    required this.matches,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: [
              Image.network(leagueLogo, width: 24, height: 24),
              const SizedBox(width: 8.0),
              Text(
                leagueName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Column(children: matches),
      ],
    );
  }
}

class MatchCard extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final String time;
  final String homeTeamLogo;
  final String awayTeamLogo;

  const MatchCard({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.time,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(homeTeamLogo, width: 40, height: 40),
                const SizedBox(width: 8.0),
                Text(
                  homeTeam,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  awayTeam,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                Image.network(awayTeamLogo, width: 40, height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
