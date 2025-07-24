// league_detail_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:faisal_tv/core/theming/colors.dart';
import 'package:faisal_tv/features/home/controllers/team_upcoming_matches_controller.dart';
import 'package:faisal_tv/features/home/controllers/tops_corers_controller.dart';
import 'package:faisal_tv/features/home/data/models/scorers_response_model.dart';
import 'package:faisal_tv/features/home/data/models/standing_model.dart';
import 'package:flutter/material.dart' hide Form;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/localization/constants.dart';
import '../controllers/league_detail_controller.dart';
import '../controllers/standings_controller.dart' show StandingsController;

/// --- Main Screen ---
class LeagueDetailScreen extends StatelessWidget {
  final String leagueName;
  final String leagueImageUrl;
  final int seasonId;

  LeagueDetailScreen({
    super.key,
    required this.leagueName,
    required this.leagueImageUrl,
    required this.seasonId,
  });

  final LeagueDetailController controller = Get.put(LeagueDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Column(
        children: [
          /// Header
          Obx(() => LeagueHeader(
                leagueName: leagueName,
                leagueImageUrl: leagueImageUrl,
                selectedIndex: controller.selectedTabIndex.value,
                onTabSelected: controller.changeTab,
              )),

          /// Tab Content
          Expanded(
            child: Obx(() {
              final index = controller.selectedTabIndex.value;
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: IndexedStack(
                  key: ValueKey(index),
                  index: index,
                  children: [
                    ScorersTab(seasonId: seasonId),
                    Standings(seasonId: seasonId),
                    // UpcomingMatchesTab(teamId: '2447'),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// --- Header Widget ---
class LeagueHeader extends StatelessWidget {
  final String leagueName;
  final String leagueImageUrl;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const LeagueHeader({
    super.key,
    required this.leagueName,
    required this.leagueImageUrl,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D1F3C), Color(0xFF5791FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                width: 100.w,
                height: 100.w,
                imageUrl: leagueImageUrl,
                fit: BoxFit.contain,
                progressIndicatorBuilder: (_, __, ___) =>
                    Skeletonizer(enabled: true, child: SizedBox(width: 25.w)),
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.error, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                leagueName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          /// Tabs
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 36,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _tab(Scorers.tr, 0),
                _tab(Standingss.tr, 1),
                // _tab("Upcoming", 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(String title, int index) {
    final isActive = index == selectedIndex;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onTabSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: isActive ? Colors.blue.shade900 : Colors.white70,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: isActive ? 16 : 15,
          ),
          child: Text(title),
        ),
      ),
    );
  }
}

/// --- Placeholder Widgets ---

class Standings extends StatelessWidget {
  final int seasonId;
  const Standings({super.key, required this.seasonId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StandingsController());

    Future.microtask(() {
      if (controller.standings.value == null) {
        controller.getStandings(seasonId.toString());
      }
    });

    return Obx(() {
      final status = controller.statusReq.value;

      if (status == StatusRequest.serverFailure) {
        return _errorView(ServerError.tr, () {
          controller.getStandings(seasonId.toString());
        });
      } else if (status == StatusRequest.emptyCache ||
          status == StatusRequest.noData) {
        return _errorView(NoStandingsDataAvailable.tr, () {
          controller.getStandings(seasonId.toString());
        });
      }

      final isLoading = status == StatusRequest.loading;
      final standingsList = controller.standings.value?.data ?? [];

      if (!isLoading && standingsList.isEmpty) {
        return _errorView(NoStandingsFound.tr, () {
          controller.getStandings(seasonId.toString());
        });
      }

      return Skeletonizer(
        enabled: isLoading,
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.getStandings(seasonId.toString());
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 40,
                dataRowHeight: 50,
                columnSpacing: 16,
                columns: [
                  DataColumn(label: Text(Pos.tr)),
                  DataColumn(label: Text(Teams.tr)),
                  DataColumn(label: Text(P.tr)),
                  DataColumn(label: Text(W.tr)),
                  DataColumn(label: Text(D.tr)),
                  DataColumn(label: Text(L.tr)),
                  DataColumn(label: Text(GF.tr)),
                  DataColumn(label: Text(GA.tr)),
                  DataColumn(label: Text(GD.tr)),
                  DataColumn(label: Text(Pts.tr)),
                  DataColumn(label: Text(Forms.tr)),
                ],
                rows: List<DataRow>.generate(
                  isLoading ? 8 : standingsList.length,
                  (index) {
                    final standing = isLoading ? null : standingsList[index];

                    final p = _getStat(standing, "M");
                    final w = _getStat(standing, "W");
                    final d = _getStat(standing, "D");
                    final l = _getStat(standing, "L");
                    final gf = _getStat(standing, "GF");
                    final ga = _getStat(standing, "GA");
                    final gd = gf - ga;
                    final pts = standing?.points ?? 0;

                    return DataRow(
                      cells: [
                        DataCell(Text("${standing?.position ?? index + 1}")),
                        DataCell(Text(standing?.participant.name ?? "—")),
                        DataCell(Text("$p")),
                        DataCell(Text("$w")),
                        DataCell(Text("$d")),
                        DataCell(Text("$l")),
                        DataCell(Text("$gf")),
                        DataCell(Text("$ga")),
                        DataCell(Text("$gd")),
                        DataCell(Text("$pts")),
                        DataCell(_buildForm(standing?.form ?? [])),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  int _getStat(Standing? standing, String code) {
    if (standing == null) return 0;
    try {
      return standing.details.firstWhere((d) => d.type.code == code).value;
    } catch (_) {
      return 0;
    }
  }

  Widget _buildForm(List<Form> forms) {
    if (forms.isEmpty) return const Text("—");

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: forms.take(5).map((f) {
        Color color;
        switch (f.form.toUpperCase()) {
          case 'W':
            color = Colors.green;
            break;
          case 'D':
            color = Colors.amber;
            break;
          case 'L':
            color = Colors.red;
            break;
          default:
            color = Colors.grey;
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            f.form.toUpperCase(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        );
      }).toList(),
    );
  }
}

Widget _errorView(String message, VoidCallback onRetry) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: onRetry, child: Text(TryAgain.tr)),
      ],
    ),
  );
}

class UpcomingMatchesTab extends StatelessWidget {
  final String teamId;

  const UpcomingMatchesTab({super.key, required this.teamId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeamUpcomingMatchesController());

    // Trigger fetch

    Future.microtask(() {
      if (controller.upcomingMatches.value == null) {
        controller.getUpcomingMatches(teamId);
      }
    });

    return Obx(() {
      if (controller.statusReq.value == StatusRequest.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.statusReq.value == StatusRequest.noData) {
        return const Center(child: Text('No upcoming matches'));
      }

      final upcoming = controller.upcomingMatches.value?.data.upcoming ?? [];

      return ListView.builder(
        itemCount: upcoming.length,
        itemBuilder: (context, index) {
          final match = upcoming[index];
          final teamA =
              match.participants.firstWhere((p) => p.meta.location == 'home');
          final teamB =
              match.participants.firstWhere((p) => p.meta.location == 'away');

          return ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.Hm()
                      .format(DateTime.parse(match.startingAt).toLocal()),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            title: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.network(teamA.imagePath, width: 25, height: 25),
                      const SizedBox(width: 6),
                      Text(teamA.name, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const Text('vs'),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(teamB.name, overflow: TextOverflow.ellipsis),
                      const SizedBox(width: 6),
                      Image.network(teamB.imagePath, width: 25, height: 25),
                    ],
                  ),
                ),
              ],
            ),
            subtitle: Text(match.league.name),
          );
        },
      );
    });
  }
}

//// ScorersTab
class ScorersTab extends StatelessWidget {
  final int seasonId;

  const ScorersTab({super.key, required this.seasonId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TopScorersController());

    Future.microtask(() {
      if (controller.scorers.value == null) {
        controller.getTopScorers(seasonId: seasonId.toString());
      }
    });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(
            () => Theme(
              data: Theme.of(context).copyWith(
                dropdownMenuTheme: DropdownMenuThemeData(
                  menuStyle: MenuStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                  ),
                ),
              ),
              child: DropdownButtonFormField<ScorerType>(
                isDense: true,
                value: controller.selectedType.value,
                onChanged: (type) {
                  if (type != null) {
                    controller.changeType(type, seasonId.toString());
                  }
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.lightBlueAccent[50],
                ),
                items: ScorerType.values.map((type) {
                  return DropdownMenuItem<ScorerType>(
                    value: type,
                    child: Text(type.labelWithIcon),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        // Table header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6),
          child: Row(
            children: [
              SizedBox(
                  width: 15.w,
                  child: Text('#',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp))),
              SizedBox(width: 8.w),
              Expanded(
                  flex: 3,
                  child: Text(Players.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(
                  flex: 2,
                  child: Text(Teams.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(
                child: Obx(() => Text(
                      controller.selectedType.value.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                    )),
              ),
            ],
          ),
        ),

        const Divider(thickness: 1.2),

        Expanded(
          child: Obx(() {
            final status = controller.statusReq.value;
            final data = controller.scorers.value?.data ?? [];

            if (status == StatusRequest.serverFailure) {
              return _errorView(ServerError.tr, () {
                controller.getTopScorers(
                    seasonId: seasonId.toString(),
                    forceRefresh: true,
                    type: controller.selectedType.value);
              });
            } else if (status == StatusRequest.emptyCache ||
                status == StatusRequest.noData) {
              return _errorView(NoScorersDataAvailable.tr, () {
                controller.getTopScorers(
                    seasonId: seasonId.toString(),
                    forceRefresh: true,
                    type: controller.selectedType.value);
              });
            }

            if (status == StatusRequest.loading) {
              // Show skeleton loader
              return Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: controller.dummyScorersResponse.data.length,
                  itemBuilder: (_, i) => TopScorerTile(
                    index: i,
                    scorer: controller.dummyScorersResponse.data[i],
                  ),
                ),
              );
            }

            // if (status != StatusRequest.success || data.isEmpty) {
            //   return const Center(child: Text("No data found."));
            // }

            return RefreshIndicator(
              onRefresh: () => controller.getTopScorers(
                  seasonId: seasonId.toString(),
                  forceRefresh: true,
                  type: controller.selectedType.value),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: data.length,
                separatorBuilder: (_, __) => const SizedBox(height: 5),
                itemBuilder: (context, index) {
                  final item = data[index];
                  return TopScorerTile(index: index, scorer: item);
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}

class TopScorerTile extends StatelessWidget {
  final int index;
  final Scorer scorer;

  const TopScorerTile({super.key, required this.index, required this.scorer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: ColorsManager.lightSecondary,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 8.w),
        child: Row(
          children: [
            SizedBox(
              width: 20.w,
              child: Text('${index + 1}',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 8.w),

            // Player Info
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      width: 30.w,
                      height: 30.w,
                      imageUrl: scorer.player.imagePath,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (_, __, ___) => Skeletonizer(
                        enabled: true,
                        child: Container(
                          width: 30.w,
                          height: 30.w,
                          color: Colors.grey[300],
                        ),
                      ),
                      errorWidget: (_, __, ___) =>
                          const Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scorer.player.displayName,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          scorer.player.position,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Team Info
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  CachedNetworkImage(
                    width: 22.w,
                    height: 22.w,
                    imageUrl: scorer.participant.imagePath,
                    fit: BoxFit.contain,
                    progressIndicatorBuilder: (_, __, ___) => Skeletonizer(
                        enabled: true, child: SizedBox(width: 22.w)),
                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.sports_soccer, color: Colors.grey),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      scorer.participant.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),

            // Goals
            Expanded(
              child: Text(
                '${scorer.total}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.deepOrange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
