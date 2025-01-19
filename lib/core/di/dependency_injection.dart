import 'package:get/get.dart';

import '../../features/auth/login/controllers/login_controller.dart';
import '../../features/auth/singup/controllers/singup_controller.dart';
import '../../features/onboarding/controller/onboarding_controller.dart';
import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';

Future<void> setupGetIt() async {
  isOnBordingView = await SharedPrefHelper.getBool("isOnBordingView");
  Get.lazyPut(() => OnboardingController());
  Get.lazyPut(() => LoginController(), fenix: true);
  Get.lazyPut(() => SingupController(), fenix: true);
}
