import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tzdata;

import 'core/di/dependency_injection.dart';
import 'core/helpers/constants.dart';
import 'core/localization/constants.dart';
import 'core/localization/language_controller.dart';
import 'core/localization/translations.dart';
import 'core/theming/app_themes.dart';
import 'core/theming/theme_controller.dart';
import 'features/auth/login/ui/login_screen.dart';
import 'features/auth/remote/auth_remotdata.dart';
import 'features/home/ui/main_home_screen.dart';
import 'features/onboarding/ui/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await ScreenUtil.ensureScreenSize();
  await setupGetIt();
  tzdata.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (themeController) => GetBuilder<LanguageController>(
        init: LanguageController(),
        builder: (langController) => BetterFeedback(
          theme: themeController.feedbackTheme,
          localeOverride: langController.appLocale,
          child: ScreenUtilInit(
            designSize: const Size(390, 844),
            builder: (ctx, child) => GetMaterialApp(
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: themeController.themeMode,
              debugShowCheckedModeBanner: false,
              translations: MyTranslations(),
              locale: langController.appLocale,
              title: 'TV-App',
              // theme: ThemeData(
              //   fontFamily: 'Cairo',
              //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              //   useMaterial3: true,
              // ),
              home: const AppContent(),
              // home: isOnBordingView
              //     ? auth.isAuthenticated
              //         ? const MainHomeScreen()
              //         : const LoginScreen()
              //     : const IntroScreen(),
              // home: HomeScreen(),
              // home: MatchListScreen(),
              // home: isOnBordingView
              //     ? firebaseAuth.authStateChanges().listen((User? user) {
              //         if (user != null) {
              //         r
              //         } else {
              //           log("............... not User is login ");
              //         }
              //       })
              //     : const IntroScreen(),

              // home: HomeScreen2(
              //     // matches: sampleMatches,
              //     ),
              // home: OnboardingScreen(),
              // home: const SingupScreen(),
              // home: const LoginScreen(),
              // home: const OTPScreen(),
              // home: const ForgetPasswordScreen(),
              // home: const HomeScreen(),
              // home: CategoriesScreen(),
              // home: const VideoPlayerScreen(
              //   videoUrl: '',
              // ),
            ),
          ),
        ),
      ),
    );
  }
}

// دالة عرض الـ Dialog
Future<bool?> showExitPopup(BuildContext context) async {
  return await AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.scale,
    title: exitDialogTitle.tr,
    desc: exitDialogDesc.tr,
    btnCancelText: noButton.tr,
    btnOkText: yesButton.tr,
    btnCancelOnPress: () => Get.back(result: false),
    btnOkOnPress: () => Get.back(result: true),
  ).show();
}

class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) {
    // The 'context' here IS A DESCENDANT of GetMaterialApp, so it will work!
    final AuthRemotDataImpHttp auth = Get.find<AuthRemotDataImpHttp>();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        // This 'context' is now valid for showing a Material dialog
        final bool? shouldPop = await showExitPopup(context);
        if (shouldPop == true) {
          SystemNavigator.pop();
        }
      },
      child: isOnBordingView
          ? auth.isAuthenticated
              ? const MainHomeScreen()
              : const LoginScreen()
          : const IntroScreen(),
    );
  }
}
