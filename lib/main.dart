import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:h_tv/core/helpers/constants.dart';
import 'package:h_tv/features/onboarding/ui/intro_screen.dart';

import 'core/di/dependency_injection.dart';
import 'core/localization/language_controller.dart';
import 'core/localization/translations.dart';
import 'core/theming/app_themes.dart';
import 'core/theming/theme_controller.dart';
import 'features/home/ui/main_navigation_screen.dart';

void main() async {
  // await parseM3UFile0("assets/playlist.m3u");
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await ScreenUtil.ensureScreenSize();
  await setupGetIt();
  // final String m3uContent = await rootBundle.loadString('assets/playlist.m3u');
  // await parseM3U();
  // print(m3uContent);

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
        builder: (langController) => ScreenUtilInit(
            designSize: const Size(390, 844),
            builder: (context, child) => GetMaterialApp(
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
                  home: isOnBordingView
                      ? const MainNavigationScreen()
                      : const IntroScreen(),
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
                )),
      ),
    );
  }
}
