import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/localization/constants.dart';
import '../../../core/theming/colors.dart';
import '../controllers/today_matches_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';
import '../widgets/leagues_ection_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodayMatchesController>(
      builder: (controller) => Scaffold(
          appBar: CustomAppBar(
            actions: [
              // /// previous day button
              // IconButton(
              //   onPressed: controller.previousDay,
              //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
              // ),
              // // horizontalSpace(20),

              // // horizontalSpace(20),
              // /// next day button
              // IconButton(
              //   onPressed: controller.nextDay,
              //   icon: const Icon(Icons.arrow_forward_ios_rounded),
              // ),
              IconButton(
                icon: Badge(
                  isLabelVisible: controller.selectedLeagues.isNotEmpty,
                  label: Text(controller.selectedLeagues.length.toString()),
                  child: Icon(Icons.filter_list_alt,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                onPressed: () => showFilterBottomSheet(context),
              ),
            ],
          ),
          drawer: CustomDrawerWidget(),
          body: RefreshIndicator(
            onRefresh: () async {
              controller.getAllTodayMatches();
            },
            child: Skeletonizer(
              enabled: controller.statusReq == StatusRequest.loading,
              // enabled: false,
              enableSwitchAnimation: true,
              child: controller.statusReq == StatusRequest.serverFailure
                  // if server error
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Please_try_agein_later.tr,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                controller.getAllTodayMatches();
                              },
                              child: Text(TryAgain.tr))
                        ],
                      ),
                    )
                  :
                  // controller.getFilteredMatchesByDate.isEmpty
                  //     // if no matches found for this day
                  //     ? Center(child: Text("No_Matches_Found_For_This_Day".tr))
                  //     :
                  Column(
                      children: [
                        // date section
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              controller.selectedDateformat,
                              style: TextStyle(
                                  color: ColorsManager.lightSecondary,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // League section
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 15.h),
                            itemCount: controller.filteredLeaguesList.length,
                            itemBuilder: (context, index) {
                              return LeagueSectionWidget(
                                  league:
                                      controller.filteredLeaguesList[index]);
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          )),
    );
  }
}
