import 'package:get/get.dart';

import '../../features/auth/login/controllers/login_controller.dart';
import '../../features/auth/singup/controllers/singup_controller.dart';
import '../../features/home/controllers/today_matches_controller.dart';
import '../../features/home/controllers/video_player_conteroller.dart';
import '../../features/home/data/local/today_matches_local_date.dart';
import '../../features/home/data/remote/today_matches_remote_date.dart';
import '../../features/home/data/repos/today_matches_repo.dart';
import '../../features/onboarding/controller/onboarding_controller.dart';
import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';
import '../localization/language_controller.dart';
import '../networking/api_client.dart';
import '../theming/theme_controller.dart';

Future<void> setupGetIt() async {
  isOnBordingView = await SharedPrefHelper.getBool("isOnBordingView");
  Get.lazyPut(() => ThemeController(), fenix: true);
  Get.lazyPut(() => LanguageController(), fenix: true);
  Get.lazyPut(() => OnboardingController());
  Get.lazyPut(() => LoginController(), fenix: true);
  Get.lazyPut(() => SingupController(), fenix: true);

  ///  api client
  Get.lazyPut(() => ApiClent(), fenix: true);
  // get data from remote server
  Get.lazyPut(() => TodayMatchesRemoteDataImpHttp(apiClent: Get.find()),
      fenix: true);
  Get.lazyPut(() => MatchLocalDataImp(), fenix: true);
  Get.lazyPut(
      () => TodayMatchesRepoImpHttp(
            todayMatchesLocalData: Get.find(),
            todayMatchesRemotData: Get.find(),
          ),
      fenix: true);
  Get.lazyPut(() => TodayMatchesController(), fenix: true);
  Get.lazyPut(() => VideoPlayerConteroller(), fenix: true);
}
