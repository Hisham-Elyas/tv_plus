import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helpers/enums.dart';
import '../controllers/today_matches_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';
import '../widgets/match_card_widget.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

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
      body: GetBuilder<TodayMatchesController>(
        // init: TodayMatchesController(),
        builder: (controller) => controller.statusReq == StatusRequest.loading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  controller.getAllTodayMatches();
                },
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.h),
                  itemCount: controller.filteredMatches.length,
                  itemBuilder: (context, index) {
                    final event = controller.filteredMatches[index];
                    return MatchCardWidget(event: event);
                  },
                ),
              ),
      ),
    );
  }
}

// void showFilterBottomSheet(BuildContext context) {
//   final controllers = Get.find<TodayMatchesController>();
//   Get.bottomSheet(
//     Container(
//       decoration: const BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Filter Leagues',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     color: ColorsManager.mainBlack,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () => Get.back(),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: GetBuilder<TodayMatchesController>(
//               builder: (controller) => ListView.builder(
//                 itemCount: controller.leaguesList.length,
//                 itemBuilder: (context, index) {
//                   final league = controller.leaguesList[index];
//                   return CheckboxListTile(
//                     controlAffinity: ListTileControlAffinity.trailing,
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                     title: Text(league.league),
//                     secondary: CachedNetworkImage(
//                       width: 40,
//                       height: 40,
//                       imageUrl: league.leagueLogo,
//                       placeholder: (context, url) =>
//                           const CircularProgressIndicator(
//                         color: Theme.of(context).colorScheme.secondary,
//                         strokeWidth: 2,
//                       ),
//                       errorWidget: (context, url, error) => const Icon(
//                         Icons.sports_soccer,
//                         color: Theme.of(context).colorScheme.secondary,
//                       ),
//                     ),
//                     value: controller.selectedLeagues.contains(league.league),
//                     onChanged: (_) =>
//                         controller.toggleLeagueSelection(league.league),
//                     activeColor: Theme.of(context).colorScheme.secondary,
//                     checkboxShape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: controllers.clearFilters,
//                   child: const Text('Clear Filters'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   child: const Text('Apply Filters'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
