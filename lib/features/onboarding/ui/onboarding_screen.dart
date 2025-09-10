// ignore_for_file: deprecated_member_use

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/localization/constants.dart';
import '../controller/onboarding_controller.dart';
import '../widgets/logo_card_widget.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              verticalSpace(26),
              LogoCardWidget(
                width: 340.w,
                height: 263.h,
              ),
              verticalSpace(73),
              Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 26.h).copyWith(top: 30.h),
                  height: 347.h,
                  width: 333.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                        .withValues(alpha:0.52)),
                  child: Column(
                    children: [
                      SmoothPageIndicator(
                        controller: controller.pageController, // PageController
                        count: onBoardingListDescription.length,
                        effect: ScaleEffect(
                          dotColor: Theme.of(context).colorScheme.surface,
                          dotHeight: 12,
                          dotWidth: 12,
                          activeDotColor: Theme.of(context).colorScheme.primary,
                        ), // your preferred effect
                      ),
                      verticalSpace(40),
                      Expanded(
                        child: PageView.builder(
                            controller: controller.pageController,
                            itemCount: onBoardingListDescription.length,
                            itemBuilder: (context, index) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: Text(
                                    onBoardingListDescription[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                )),
                      ),
                      verticalSpace(32),
                      GestureDetector(
                        onTap: controller.nextPage,
                        child: AvatarGlow(
                          glowCount: 2,
                          glowColor: Theme.of(context).colorScheme.surface,
                          glowRadiusFactor: 0.5,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          curve: Curves.easeOutQuad,
                          child: Container(
                            height: 68.h,
                            width: 68.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.surface),
                            alignment: Alignment.center,
                            child: Text(Go.tr,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
