import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:h_tv/features/home/controllers/today_matches_controller.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/theming/colors.dart';
import '../../onboarding/widgets/logo_card_widget.dart';
import '../widgets/custom_drawer_widget.dart';
import '../widgets/match_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  padding: EdgeInsets.only(top: 10.h),
                  itemCount: controller.matches.length,
                  itemBuilder: (context, index) {
                    final event = controller.matches[index];
                    return MatchCardWidget(event: event);
                  },
                ),
              ),
      ),
    );
  }
}
