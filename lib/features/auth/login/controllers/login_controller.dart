import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/ui/home_screen.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginformKey = GlobalKey();
  late String userName;
  late String password;
  void login() {
    Get.focusScope!.unfocus();
    if (!loginformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    loginformKey.currentState!.save();
    debugPrint('logIn =>  userName : $userName');
    Get.offAll(() => const HomeScreen());
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

  set setPassword(val) {
    password = val;
  }

  set setuserName(val) {
    userName = val;
  }
}
