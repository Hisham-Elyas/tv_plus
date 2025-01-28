import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/helpers/shared_pref_helper.dart';
import '../../auth/login/ui/login_screen.dart';
import '../../auth/models/user_model.dart';
import 'settings_controller.dart';

class ProfileController extends GetxController {
  late UserModel userInf;

  @override
  void onInit() async {
    final userdata = await SharedPrefHelper.getString('user_info');
    if (userdata != null) {
      userInf = UserModel.fromMap(jsonDecode(userdata));
    } else {
      userInf = UserModel(email: '', userName: '');
      Get.find<SettingsController>().authRepo.logeOut();
      Get.offAll(() => const LoginScreen());
    }
    super.onInit();
  }
}
