// ignore_for_file: strict_top_level_inference

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/coustom_overlay.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../login/ui/login_screen.dart';
import '../../repos/auth_repo.dart';

class VerificationController extends GetxController {
  late String otp;
  late String newPassword;
  final GlobalKey<FormState> verificationOtpformKey = GlobalKey();
  final AuthRepoImpHttp authRepo = Get.find();

  void verifyOTP({required String email}) {
    Get.focusScope!.unfocus();
    if (!verificationOtpformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    verificationOtpformKey.currentState!.save();
    showOverlay(
      asyncFunction: () async {
        try {
          final isSuccess = await authRepo.resetPasswordWOtp(
              email: email, newPassword: newPassword, otp: otp);

          if (isSuccess) {
            Get.offAll(() => const LoginScreen());
          }
        } catch (e) {
          showCustomSnackBar(
            message: e.toString(),
            title: "",
            isError: true,
          );
        }
      },
    );
  }

  String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }

    return null;
  }

  set setOtp(val) {
    otp = val;
  }

  set setnewPassword(val) {
    newPassword = val;
  }
}
