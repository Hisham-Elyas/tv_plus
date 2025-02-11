import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/localization/constants.dart';
import '../controllers/profile_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';
import '../widgets/custom_listtile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Profile.tr,
      ),
      drawer: CustomDrawerWidget(),
      body: GetBuilder<ProfileController>(
        builder: (controller) => Skeletonizer(
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
                          title: controller.userInf.userName!,
                          icon: Icons.person,
                          trailing: const Icon(Icons.edit),
                          onTap: () {
                            controller.showActionBottomSheet('userInfo');
                          }),
                      verticalSpace(10),
                      CustomListTileWidget(
                          title: controller.userInf.email ?? '',
                          icon: Icons.email,
                          trailing: const Icon(Icons.edit),
                          onTap: () {
                            controller.showActionBottomSheet('email');
                          }),
                      verticalSpace(10),
                      CustomListTileWidget(
                          title: controller.userInf.phone ?? 'Add phone Number',
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
      ),
    );
  }
}
