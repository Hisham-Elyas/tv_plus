import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../home/ui/home_screen.dart';

class SingupController extends GetxController {
  late String email;
  late String userName;
  late String password;
  late String confirmPassword;
  late String phoneNumber;
  final GlobalKey<FormState> singUpformKey = GlobalKey();

  void singUp() {
    Get.focusScope!.unfocus();
    if (!singUpformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    singUpformKey.currentState!.save();
    debugPrint('SingUp =>  userName : $userName');
    Get.offAll(() => const HomeScreen());
  }

  String? emailvalidator(val) {
    if (val.isEmpty) {
      return "Type_your_email_adress";
    } else if (!GetUtils.isEmail(val)) {
      return "Type_in_valid_email_adress";
    } else {
      return null;
    }
  }

  String? phonevalidator(val) {
    if (val.isEmpty) {
      return "Type_your_PhoneNumber";
    } else if (AppRegex.isPhoneNumberValid(val)) {
      return "Add_valid_PhoneNumber";
    } else {
      return null;
    }
  }

  String? userNamevalidator(val) {
    if (val.isEmpty) {
      return "Type_your_Name";
    } else if (val.length < 4) {
      return "Name_can_not_be_less_than_4_characters";
    } else {
      return null;
    }
  }

  String? passwordvalidator(val) {
    update();
    if (val.isEmpty) {
      return "Enter_your_password";
    } else if (val.length < 6) {
      return "Password_can_not_be_less_than_six_characters";
    } else {
      return null;
    }
  }

  String? confirmPasswordvalidator(val) {
    update();
    if (val.isEmpty) {
      return "Enter_your_password";
    } else if (password != confirmPassword) {
      return "Password_not_match";
    } else {
      return null;
    }
  }

  set setEmail(val) {
    email = val;
  }

  set setPassword(val) {
    password = val;
  }

  set setconfirmPassword(val) {
    confirmPassword = val;
  }

  set setuserName(val) {
    userName = val;
  }

  set setphoneNumber(val) {
    phoneNumber = val;
  }
}
