import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/enums.dart';
import '../../../core/helpers/shared_pref_helper.dart';
import '../../auth/login/ui/login_screen.dart';
import '../../auth/models/user_model.dart';
import '../../auth/repos/auth_repo.dart';
import 'settings_controller.dart';

class ProfileController extends GetxController {
  late UserModel userInf;
  late StatusRequest statusReq = StatusRequest.loading;
  final AuthRepoImpFirebase authRepo = Get.find();

  @override
  void onInit() async {
    await getUserInfo();
    super.onInit();
  }

  getUserInfo() async {
    final userdata = await SharedPrefHelper.getString('user_info');
    debugPrint("userdata ==>  $userdata");
    if (userdata.isEmpty) {
      statusReq = StatusRequest.loading;
      update();
      final result = await authRepo.getUserInfo();
      result.fold(
        (l) {
          statusReq = l;
          statusReq = StatusRequest.success;
          update();
        },
        (r) {
          userInf = r;
          statusReq = StatusRequest.success;
          update();
        },
      );
    } else if (userdata.isNotEmpty) {
      userInf = UserModel.fromMap(jsonDecode(userdata));
      statusReq = StatusRequest.success;
      update();
    } else {
      Get.find<SettingsController>().authRepo.logeOut();
      Get.offAll(() => const LoginScreen());
    }
  }
}
