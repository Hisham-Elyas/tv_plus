// main_navigation_screen.dart
import 'package:flutter/material.dart';
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
    const HomeScreen(),
    const HomeScreen2(),
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
