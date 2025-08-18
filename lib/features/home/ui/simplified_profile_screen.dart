import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/localization/constants.dart';
import '../controllers/profile_controller.dart';
import '../widgets/custom_listtile_widget.dart';

class SimplifiedProfileScreen extends StatelessWidget {
  const SimplifiedProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(() => ProfileController());
    return GetBuilder<ProfileController>(
      builder: (controller) => controller.statusReq == StatusRequest.loading
          ? const Center(child: CircularProgressIndicator())
          : Skeletonizer(
              enabled: controller.statusReq == StatusRequest.loading,
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
                                controller.getUserInfo();
                              },
                              child: Text(TryAgain.tr))
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(16.0.dm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                              backgroundImage: const AssetImage(
                                ImageAssets.logo,
                              ),
                              radius: 80.r,
                            ),
                          ),
                          verticalSpace(20),
                          CustomListTileWidget(
                              title:
                                  controller.userInf?.userName ?? 'User Name',
                              icon: Icons.person,
                              trailing: const Icon(Icons.edit),
                              onTap: () {
                                controller.showActionBottomSheet('userInfo');
                              }),
                          verticalSpace(10),
                          CustomListTileWidget(
                              title: controller.userInf?.email ?? '',
                              icon: Icons.email,
                              trailing: const Icon(Icons.edit),
                              onTap: () {
                                controller.showActionBottomSheet('email');
                              }),
                          verticalSpace(10),
                          CustomListTileWidget(
                              title: controller.userInf?.phone ??
                                  'Add phone Number',
                              icon: Icons.phone,
                              trailing: const Icon(Icons.edit),
                              onTap: () {
                                controller.showActionBottomSheet('userInfo');
                              }),
                          verticalSpace(10),
                          CustomListTileWidget(
                              title: ChangePassword.tr,
                              icon: Icons.password_outlined,
                              trailing: const Icon(Icons.edit),
                              onTap: () {
                                controller.showActionBottomSheet('password');
                              }),
                          verticalSpace(10),
                        ],
                      ),
                    ),
            ),
    );
  }
}
