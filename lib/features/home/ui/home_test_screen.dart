import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../onboarding/widgets/logo_card_widget.dart';
import '../controllers/today_matches_controller.dart';
import '../data/models/league_model.dart';
import '../widgets/custom_drawer_widget.dart';
import '../widgets/match_card_widget.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.mainBlack,
          centerTitle: true,
          title: const LogoCardWidget(width: 150, height: 53),
          iconTheme: const IconThemeData(
            color: ColorsManager.white, // Change this to your desired color
          ),
        ),
        drawer: CustomDrawerWidget(),
        body: GetBuilder<TodayMatchesController>(
          builder: (controller) => controller.statusReq == StatusRequest.loading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () async {
                    controller.getAllTodayMatches();
                  },
                  child: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                    itemCount: controller.leaguesList.length,
                    itemBuilder: (context, index) {
                      return _buildLeagueSection(controller.leaguesList[index]);
                    },
                  ),
                ),
        ));
  }

  Widget _buildLeagueSection(LeagueModel league) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 20.h),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                if (league.leagueLogo.isNotEmpty)
                  CachedNetworkImage(
                    width: 30.w,
                    fit: BoxFit.contain,
                    imageUrl: league.leagueLogo,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          color: ColorsManager.lightBlue,
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                horizontalSpace(15),
                Text(
                  league.league,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            ...league.matches.map((match) => MatchCardWidget(event: match)),
          ],
        ),
      ),
    );
  }
}
