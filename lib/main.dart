import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:h_tv/features/home/ui/categories_screen.dart';

import 'core/di/dependency_injection.dart';
import 'core/helpers/constants.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'features/auth/login/ui/login_screen.dart';
import 'features/auth/singup/ui/singup_screen.dart';
import 'features/auth/verification/ui/forget_password_screen.dart';
import 'features/auth/verification/ui/verification_otp_screen.dart';
import 'features/home/ui/home_screen.dart';
import 'features/home/ui/video_player_screen.dart';
import 'features/onboarding/ui/intro_screen.dart';
import 'features/onboarding/ui/onboarding_screen.dart';
import 'screen/home_screen.dart';
import 'screen/tv_channel_list_screen.dart';

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
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Cairo',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isOnBordingView ? const LoginScreen() : const IntroScreen(),
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
    );
  }
}
