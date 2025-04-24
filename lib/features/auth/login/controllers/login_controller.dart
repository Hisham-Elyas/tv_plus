import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/coustom_overlay.dart';
import '../../../../core/localization/constants.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../home/controllers/today_matches_controller.dart';
import '../../../home/ui/home_screen.dart';
import '../../models/login_model.dart';
import '../../repos/auth_repo.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  late String email;
  late String password;
  final AuthRepoImpHttp authRepo = Get.find();

  void login() {
    Get.focusScope!.unfocus();
    if (!loginformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    loginformKey.currentState!.save();

    showOverlay(
      asyncFunction: () async {
        try {
          final isSuccess = await authRepo.logIn(
              loginModel: LoginModel(
            email: email.trim(),
            password: password.trim(),
          ));

          if (isSuccess) {
            /// save  user

            Get.offAll(() => const HomeScreen());
            Get.find<TodayMatchesController>();
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

  String? passwordvalidator(val) {
    update();
    if (val.isEmpty) {
      return Enter_your_password.tr;
    } else if (val.length < 6) {
      return Password_can_not_be_less_than_six_characters.tr;
    } else {
      return null;
    }
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

  set setPassword(val) {
    password = val;
  }

  set setuEmail(val) {
    email = val;
  }
}
