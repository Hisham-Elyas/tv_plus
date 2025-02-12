import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/localization/constants.dart';
import '../controllers/category_controller.dart';
import '../data/models/category_model.dart';
import '../widgets/categories_card_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';
import 'categories_details_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Categories.tr,
      ),
      drawer: CustomDrawerWidget(),
      body: GetBuilder<CategoryController>(
        builder: (controller) => RefreshIndicator(
          onRefresh: () async {
            controller.getAllCategorys();
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
                              controller.getAllCategorys();
                            },
                            child: Text(TryAgain.tr))
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:
                            1 / 1.4.h, // Aspect ratio of each item
                        crossAxisCount: 3, // Number of columns
                        crossAxisSpacing: 1, // Spacing between columns
                        mainAxisSpacing: 1, // Spacing between rows
                      ),
                      itemCount: controller.getCategorysList.length,
                      itemBuilder: (context, index) {
                        final CategoryWithChannels category =
                            controller.getCategorysList[index];
                        return CategoriesCardWidget(
                          category: category,
                          onTap: () {
                            Get.to(() =>
                                CategoriesDetailsScreen(category: category));
                          },
                        );
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
