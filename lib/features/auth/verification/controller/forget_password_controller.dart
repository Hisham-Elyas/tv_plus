import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/coustom_overlay.dart';
import '../../../../core/localization/constants.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../login/ui/login_screen.dart';
import '../../repos/auth_repo.dart';

class ForgetPasswordController extends GetxController {
  late String email;
  final GlobalKey<FormState> verificationformKey = GlobalKey();
  final AuthRepoImpFirebase authRepo = Get.find();
  sendPasswordResetLink() {
    Get.focusScope!.unfocus();
    if (!verificationformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    verificationformKey.currentState!.save();
    showOverlay(
      asyncFunction: () async {
        try {
          final isSuccess = await authRepo.forgotPassword(email: email);

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
