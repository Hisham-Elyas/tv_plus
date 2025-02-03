import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/localization/constants.dart';
import '../controllers/profile_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Profile.tr,
        actions: const [
          // IconButton(
          //   icon: const Icon(Icons.search),
          //   onPressed: () {},
          // ),
        ],
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
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            child: const Icon(Icons.person),
                          ),
                          horizontalSpace(16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.userInf.userName!,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                controller.userInf.email,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      // ListTile(
                      //   contentPadding: EdgeInsets.zero,
                      //   title: const Text(
                      //     'My orders',
                      //     style: TextStyle(
                      //         fontSize: 18, fontWeight: FontWeight.bold),
                      //   ),
                      //   // subtitle: const Text('Already have 12 orders'),
                      //   trailing: const Icon(Icons.chevron_right),
                      //   onTap: () {},
                      // ),
                      const Divider(),
                      // ListTile(
                      //   contentPadding: EdgeInsets.zero,
                      //   title: const Text(
                      //     'Shipping addresses',
                      //     style: TextStyle(
                      //         fontSize: 18, fontWeight: FontWeight.bold),
                      //   ),
                      //   // subtitle: const Text('3 addresses'),
                      //   trailing: const Icon(Icons.chevron_right),
                      //   onTap: () {},
                      // ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
