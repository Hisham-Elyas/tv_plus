// main_navigation_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/today_matches_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';
import 'home_2_screen.dart';
import 'home_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen2(),
    const HomeScreen(),
  ];
  @override
  void initState() {
    super.initState();
    // Ensure controller initialization
    Get.put<TodayMatchesController>(TodayMatchesController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // title: ,
        actions: [
          GetBuilder<TodayMatchesController>(
            builder: (controller) {
              return IconButton(
                icon: Badge(
                  isLabelVisible: controller.selectedLeagues.isNotEmpty,
                  label: Text(controller.selectedLeagues.length.toString()),
                  child: Icon(Icons.filter_list_alt,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                onPressed: () => showFilterBottomSheet(context),
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawerWidget(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home View 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Home View 2',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

void showFilterBottomSheet(BuildContext context) {
  final controllers = Get.find<TodayMatchesController>();
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
                  'Filter Leagues',
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
            child: GetBuilder<TodayMatchesController>(
              builder: (controller) => ListView.builder(
                itemCount: controller.leaguesList.length,
                itemBuilder: (context, index) {
                  final league = controller.leaguesList[index];
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.platform,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    title: Text(league.league),
                    secondary: CachedNetworkImage(
                      width: 25.w,
                      height: 25.h,
                      imageUrl: league.leagueLogo,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                          strokeWidth: 2,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.sports_soccer,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    value: controller.selectedLeagues.contains(league.league),
                    onChanged: (_) =>
                        controller.toggleLeagueSelection(league.league),
                    activeColor: Theme.of(context).colorScheme.secondary,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: controllers.clearFilters,
                  child: const Text('Clear Filters'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Apply Filters'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
