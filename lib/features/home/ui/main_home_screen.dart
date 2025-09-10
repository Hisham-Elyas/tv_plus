import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/localization/constants.dart';
import '../controllers/fixtures_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';
import 'leagues_screen.dart';
import 'simplified_categories_screen.dart';
import 'simplified_match_list_screen.dart';
import 'simplified_profile_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    SimplifiedMatchListScreen(),
    const SimplifiedCategoriesScreen(),
    const LeaguesScreen(),
    const SimplifiedProfileScreen(),
    // const SimplifiedSettingsScreen(),
  ];

  final List<String> _titles = [
    appName,
    Categories.tr,
    Leagues.tr,
    Profile.tr,
    // Settings.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: CustomDrawerWidget(),
      appBar: CustomAppBar(
        title: _currentIndex == 0 ? appName : _titles[_currentIndex].tr,
        actions: _currentIndex == 0
            ? [
                // Only show these actions on the home screen (matches)
                Obx(() {
                  final controller = Get.find<FixturesController>();
                  return IconButton(
                    icon: Badge(
                      isLabelVisible: controller.selectedLeagues.isNotEmpty,
                      label: Text(controller.selectedLeagues.length.toString()),
                      child: Icon(Icons.filter_list_alt,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    onPressed: () {
                      showFilterBottomSheet(context);
                    },
                  );
                }),
                IconButton(
                  onPressed: () {
                    final controller = Get.find<FixturesController>();
                    controller.previousDay();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    final controller = Get.find<FixturesController>();
                    controller.pickDate(context);
                  },
                ),
                IconButton(
                  onPressed: () {
                    final controller = Get.find<FixturesController>();
                    controller.nextDay();
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ]
            : null,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor:
            Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 8,

        selectedFontSize: 12.sp,
        unselectedFontSize: 10.sp,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer, size: 24.sp),
            activeIcon: Icon(Icons.sports_soccer, size: 28.sp),
            label: Home.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, size: 24.sp),
            activeIcon: Icon(Icons.category, size: 26.sp),
            label: Categories.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events, size: 24.sp),
            activeIcon: Icon(Icons.emoji_events,
                color: Colors.yellow.shade500, size: 28.sp),
            label: Leagues.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24.sp),
            activeIcon: Icon(Icons.person, size: 26.sp),
            label: Profile.tr,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings, size: 24.sp),
          //   activeIcon: Icon(Icons.settings, size: 26.sp),
          //   label: Settings.tr,
          // ),
        ],
      ),
    );
  }
}

void showFilterBottomSheet(BuildContext context) {
  final controller = Get.find<FixturesController>();
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FilterLeagues.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<FixturesController>(
              builder: (controller) => ListView.builder(
                itemCount: controller.fixtures.length,
                itemBuilder: (context, index) {
                  final league = controller.fixtures[index];
                  return Card(
                    elevation: 5,
                    shadowColor: Colors.grey.shade300,
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.platform,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      title: Text(league.name),
                      secondary: CachedNetworkImage(
                        width: 30.w,
                        height: 30.h,
                        imageUrl: league.imagePath,
                        placeholder: (context, url) => Skeletonizer(
                          enabled: true,
                          child: Icon(Icons.sports_soccer, size: 30.dm),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.broken_image,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      value: controller.selectedLeagues.contains(league.id),
                      onChanged: (_) =>
                          controller.toggleLeagueFilter(league.id),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.dm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: controller.clearFilters,
                  child: Text(Clear.tr),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text(Apply.tr),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
