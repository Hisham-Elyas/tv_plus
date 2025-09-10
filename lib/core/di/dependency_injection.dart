import 'package:faisal_tv/features/home/controllers/fixtures_controller.dart'
    show FixturesController;
import 'package:faisal_tv/features/home/data/remote/fixtures_remote_data.dart';
import 'package:faisal_tv/features/home/data/repos/fixtures_repo.dart';
import 'package:get/get.dart';

import '../../features/auth/login/controllers/login_controller.dart';
import '../../features/auth/remote/auth_remotdata.dart';
import '../../features/auth/repos/auth_repo.dart';
import '../../features/auth/singup/controllers/singup_controller.dart';
import '../../features/auth/verification/controller/forget_password_controller.dart';
import '../../features/auth/verification/controller/verification_controller.dart';
import '../../features/home/controllers/category_controller.dart';
import '../../features/home/controllers/contact_us_controller.dart';
import '../../features/home/controllers/leaguematch_controller.dart';
import '../../features/home/controllers/leagues_controller.dart';
import '../../features/home/controllers/payment_controller.dart';
import '../../features/home/controllers/profile_controller.dart';
import '../../features/home/controllers/settings_controller.dart';
import '../../features/home/controllers/today_matches_controller.dart';
import '../../features/home/controllers/video_player_conteroller.dart';
import '../../features/home/data/local/today_matches_local_date.dart';
import '../../features/home/data/remote/category_channel_remote_data.dart';
import '../../features/home/data/remote/today_matches_remote_date.dart';
import '../../features/home/data/repos/category_repo.dart';
import '../../features/home/data/repos/today_matches_repo.dart';
import '../../features/onboarding/controller/onboarding_controller.dart';
import '../helpers/constants.dart';
import '../helpers/network_manager.dart';
import '../helpers/shared_pref_helper.dart';
import '../localization/language_controller.dart';
import '../networking/api_client.dart';
import '../theming/theme_controller.dart';

Future init() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // firebaseAuth.authStateChanges().listen((User? user) {
  //   if (user != null) {
  //     log(" User is login by ${user.uid}");
  //     log(" User is login by ${user.email}");
  //     Get.find<CategoryController>();
  //   } else {
  //     log("............... not User is login ");
  //   }
  // });
}

Future<void> setupGetIt() async {
  isOnBordingView = await SharedPrefHelper.getBool("isOnBordingView");

  Get.lazyPut(() => NetworkManager(), fenix: true);
  Get.put(() => NetworkManager());

  Get.lazyPut(() => ThemeController(), fenix: true);
  Get.lazyPut(() => LanguageController(), fenix: true);
  Get.lazyPut(() => OnboardingController(), fenix: true);
  Get.lazyPut(() => LoginController(), fenix: true);
  Get.lazyPut(() => SingupController(), fenix: true);
  Get.lazyPut(() => ForgetPasswordController(), fenix: true);
  Get.lazyPut(() => VerificationController(), fenix: true);

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

  Get.lazyPut(() => CategoryRemoteDateImplHttp(apiClent: Get.find()),
      fenix: true);
  Get.lazyPut(() => CategoryRepoImpHttp(categoryRemote: Get.find()),
      fenix: true);
  Get.lazyPut(() => CategoryController(), fenix: true);

  Get.lazyPut(() => VideoPlayerConteroller(), fenix: true);
  Get.lazyPut(() => ContactUsController(), fenix: true);
  Get.lazyPut(() => SettingsController(), fenix: true);
  //// auth
  /// Http
  // Get.lazyPut(() => AuthRepoImpHttp(authRemotData: Get.find()), fenix: true);
  // Get.lazyPut(() => AuthRemotDataImpHttp(apiClent: Get.find()), fenix: true);
////  Firebase
  Get.lazyPut(() => AuthRepoImpHttp(authRemotData: Get.find()), fenix: true);
  Get.lazyPut(() => AuthRemotDataImpHttp(apiClent: Get.find()), fenix: true);

  /// Fixtures

  Get.lazyPut(() => FixturesRemoteDateImpHttp(apiClent: Get.find()),
      fenix: true);
  Get.lazyPut(() => FixturesRepoImpHttp(todayMatchesRemotData: Get.find()),
      fenix: true);
  Get.lazyPut(() => LeaguematchController(), fenix: true);
  Get.lazyPut(() => FixturesController(), fenix: true);
  Get.lazyPut(() => LeaguesController(), fenix: true);

  // Profile and Payment controllers
  Get.lazyPut(() => ProfileController(), fenix: true);
  Get.lazyPut(() => PaymentController(), fenix: true);
  await init();
}
