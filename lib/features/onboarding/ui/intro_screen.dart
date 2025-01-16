import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:h_tv/core/helpers/spacing.dart';
import 'package:h_tv/core/theming/colors.dart';

import '../../../core/widgets/app_text_button.dart';
import '../controller/onboarding_controller.dart';
import '../widgets/logo_card_widget.dart';
import 'onboarding_screen.dart';

class IntroScreen extends GetView<OnboardingController> {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LogoCardWidget(
              width: 340.w,
              height: 263.h,
            ),
            verticalSpace(99),
            AppTextButton(
              backgroundColor: ColorsManager.mainRed,
              buttonHeight: 50,
              buttonWidth: 317,
              borderRadius: 152,
              buttonText: "إبدء",
              onPressed: () => Get.to(() => const OnboardingScreen()),
              textStyle: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.white),
            )
          ],
        ),
      ),
    );
  }
}
