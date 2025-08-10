// ignore_for_file: strict_top_level_inference

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/coustom_overlay.dart';
import '../../../../core/localization/constants.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../repos/auth_repo.dart';
import '../ui/verification_otp_screen.dart';

class ForgetPasswordController extends GetxController {
  late String email;
  final GlobalKey<FormState> verificationformKey = GlobalKey();
  final AuthRepoImpHttp authRepo = Get.find();
  sendResetOtp() {
    Get.focusScope!.unfocus();
    if (!verificationformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    verificationformKey.currentState!.save();
    showOverlay(
      asyncFunction: () async {
        try {
          final isSuccess = await authRepo.sendResetOtp(email: email);

          if (isSuccess) {
            Get.to(() => const OTPScreen());
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

  String? emailvalidator(val) {
    if (val.isEmpty) {
      return Type_your_email_adress.tr;
    } else if (!GetUtils.isEmail(val)) {
      return Type_in_valid_email_adress.tr;
    } else {
      return null;
    }
  }

  set setEmail(val) {
    email = val;
  }
}
