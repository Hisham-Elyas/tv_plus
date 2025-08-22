import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/localization/constants.dart';
import '../controllers/payment_controller.dart';
import '../controllers/profile_controller.dart';

class SimplifiedProfileScreen extends StatelessWidget {
  const SimplifiedProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header section
            GetBuilder<ProfileController>(
              builder: (profileController) => Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.dm),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.dm),
                  ),
                ),
                child: Skeletonizer(
                  enabled: profileController.statusReq == StatusRequest.loading,
                  enableSwitchAnimation: true,
                  child: profileController.statusReq ==
                          StatusRequest.serverFailure
                      // if server error
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Please_try_agein_later.tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              verticalSpace(20),
                              ElevatedButton(
                                  onPressed: () {
                                    profileController.getUserInfo();
                                  },
                                  child: Text(TryAgain.tr))
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundImage: const AssetImage(
                                ImageAssets.logo,
                              ),
                              radius: 60.r,
                            ),
                            verticalSpace(20),
                            Text(
                              profileController.userInf?.userName ??
                                  'User Name',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            verticalSpace(5),
                            Text(
                              profileController.userInf?.email ??
                                  'user@example.com',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            verticalSpace(20),
            // Profile details section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.dm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AccountDetails.tr,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  verticalSpace(15),
                  GetBuilder<ProfileController>(
                    builder: (profileController) => Skeletonizer(
                      enabled:
                          profileController.statusReq == StatusRequest.loading,
                      enableSwitchAnimation: true,
                      child: Column(
                        children: [
                          Card(
                            elevation: 2.dm,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.dm),
                            ),
                            child: ListTile(
                              leading: Container(
                                padding: EdgeInsets.all(8.dm),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.dm),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              title: Text(
                                profileController.userInf?.userName ??
                                    'User Name',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                FullName.tr,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                              trailing: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onTap: () {
                                profileController
                                    .showActionBottomSheet('userInfo');
                              },
                            ),
                          ),
                          verticalSpace(10),
                          Card(
                            elevation: 2.dm,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.dm),
                            ),
                            child: ListTile(
                              leading: Container(
                                padding: EdgeInsets.all(8.dm),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.dm),
                                ),
                                child: Icon(
                                  Icons.email,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              title: Text(
                                profileController.userInf?.email ??
                                    'user@example.com',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                EmailAddress.tr,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                              trailing: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onTap: () {
                                profileController
                                    .showActionBottomSheet('email');
                              },
                            ),
                          ),
                          verticalSpace(10),
                          // Card(
                          //   elevation: 2.dm,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(12.dm),
                          //   ),
                          //   child: ListTile(
                          //     leading: Container(
                          //       padding: EdgeInsets.all(8.dm),
                          //       decoration: BoxDecoration(
                          //         color: Theme.of(context)
                          //             .colorScheme
                          //             .primary
                          //             .withOpacity(0.1),
                          //         borderRadius: BorderRadius.circular(8.dm),
                          //       ),
                          //       child: Icon(
                          //         Icons.phone,
                          //         color: Theme.of(context).colorScheme.primary,
                          //       ),
                          //     ),
                          //     title: Text(
                          //       profileController.userInf?.phone ??
                          //           'Add phone number',
                          //       style: TextStyle(
                          //         fontSize: 16.sp,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //     subtitle: Text(
                          //       PhoneNumber.tr,
                          //       style: TextStyle(
                          //         fontSize: 14.sp,
                          //         color: Theme.of(context)
                          //             .colorScheme
                          //             .onSurface
                          //             .withOpacity(0.7),
                          //       ),
                          //     ),
                          //     trailing: Icon(
                          //       Icons.edit,
                          //       color: Theme.of(context).colorScheme.primary,
                          //     ),
                          //     onTap: () {
                          //       profileController
                          //           .showActionBottomSheet('userInfo');
                          //     },
                          //   ),
                          // ),
                          // verticalSpace(10),
                          Card(
                            elevation: 2.dm,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.dm),
                            ),
                            child: ListTile(
                              leading: Container(
                                padding: EdgeInsets.all(8.dm),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.dm),
                                ),
                                child: Icon(
                                  Icons.password_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              title: Text(
                                ChangePassword.tr,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                UpdateYourPassword.tr,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                              trailing: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onTap: () {
                                profileController
                                    .showActionBottomSheet('password');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(30),
                  // Subscription section
                  Text(
                    SubscriptionDetails.tr,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  verticalSpace(15),
                  GetBuilder<PaymentController>(
                    init: PaymentController(),
                    builder: (paymentController) => Skeletonizer(
                      enabled: paymentController.subscriptionStatus.value ==
                          StatusRequest.loading,
                      enableSwitchAnimation: true,
                      child: Column(
                        children: [
                          if (paymentController.currentSubscription.value !=
                              null)
                            Card(
                              elevation: 2.dm,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.dm),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0.dm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          paymentController.currentSubscription
                                              .value!.planName,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4.dm),
                                          decoration: BoxDecoration(
                                            color: paymentController
                                                    .currentSubscription
                                                    .value!
                                                    .isActive
                                                ? Colors.green
                                                : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(4.dm),
                                          ),
                                          child: Text(
                                            paymentController
                                                    .currentSubscription
                                                    .value!
                                                    .isActive
                                                ? Active.tr
                                                : Expired.tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpace(10),
                                    Text(
                                      paymentController.currentSubscription
                                          .value!.planDescription,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                    verticalSpace(10),
                                    Text(
                                      '${paymentController.currentSubscription.value!.price} ${paymentController.currentSubscription.value!.currency}/${paymentController.currentSubscription.value!.billingPeriod}'
                                          .tr,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    verticalSpace(10),
                                    _buildSubscriptionDetailRow(
                                      context,
                                      StartDate.tr,
                                      paymentController
                                          .currentSubscription.value!.startDate
                                          .toString()
                                          .split(' ')[0],
                                    ),
                                    verticalSpace(5),
                                    _buildSubscriptionDetailRow(
                                      context,
                                      EndDate.tr,
                                      paymentController
                                          .currentSubscription.value!.endDate
                                          .toString()
                                          .split(' ')[0],
                                    ),
                                    verticalSpace(5),
                                    if (paymentController
                                        .currentSubscription.value!.isActive)
                                      _buildSubscriptionDetailRow(
                                        context,
                                        RenewalDate.tr,
                                        paymentController
                                            .currentSubscription.value!.endDate
                                            .toString()
                                            .split(' ')[0],
                                      ),
                                    if (!paymentController.currentSubscription
                                            .value!.isActive &&
                                        !paymentController.currentSubscription
                                            .value!.isExpired)
                                      _buildSubscriptionDetailRow(
                                        context,
                                        DaysRemaining.tr,
                                        '${paymentController.currentSubscription.value!.daysRemaining} days'
                                            .tr,
                                      ),
                                    if (paymentController
                                        .currentSubscription.value!.isExpired)
                                      _buildSubscriptionDetailRow(
                                        context,
                                        Status.tr,
                                        Expired.tr,
                                      ),
                                  ],
                                ),
                              ),
                            )
                          else if (paymentController.subscriptionStatus.value ==
                              StatusRequest.loading)
                            const Center(child: CircularProgressIndicator())
                          else
                            Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.workspace_premium_outlined,
                                    size: 48.sp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.5),
                                  ),
                                  verticalSpace(10),
                                  Text(
                                    NoActiveSubscription.tr,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  verticalSpace(10),
                                  Text(
                                    'Subscribe to a plan to unlock premium features'
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                  verticalSpace(20),
                                  ElevatedButton(
                                    onPressed: () {
                                      // TODO: Implement subscription flow
                                    },
                                    child: Text(SubscribeNow.tr),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(30),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionDetailRow(
      BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
