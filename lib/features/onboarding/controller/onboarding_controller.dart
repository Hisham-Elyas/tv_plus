import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helpers/shared_pref_helper.dart';

import '../../../core/helpers/constants.dart';
import '../../auth/login/ui/login_screen.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  int currentPage = 0;
  void nextPage() {
    currentPage++;
    if (currentPage > onBoardingListDescription.length - 1) {
      SharedPrefHelper.setData("isOnBordingView", true);
      Get.to(() => const LoginScreen());
    } else {
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
    }
  }
}
