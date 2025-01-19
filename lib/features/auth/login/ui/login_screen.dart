import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/card_widget.dart';
import '../../../onboarding/widgets/logo_card_widget.dart';
import '../../singup/ui/singup_screen.dart';
import '../../verification/ui/forget_password_screen.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageAssets.bgImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 21.h,
              ).copyWith(top: 57.h),
              width: double.infinity,
              child: Column(
                children: [
                  LogoCardWidget(
                    width: 335.w,
                    height: 152.h,
                  ),
                  verticalSpace(35),
                  CardWidget(
                    horizontal: 32.w,
                    vertical: 17.h,
                    width: 335.w,
                    height: 473.h,
                    child: Form(
                      key: controller.loginformKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextFormField(
                            onSaved: (val) => controller.setuserName = val,
                            hintText: "اسم المستخدم",
                            validator: controller.userNamevalidator,
                          ),
                          verticalSpace(15),
                          AppTextFormField(
                            onSaved: (val) => controller.setPassword = val,
                            hintText: "كلمة السر",
                            validator: controller.passwordvalidator,
                          ),
                          verticalSpace(10),
                          TextButton(
                            onPressed: () =>
                                Get.to(() => const ForgetPasswordScreen()),
                            child: Text(
                              " نسيت كلمة المرور؟",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: ColorsManager.mainRed),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    Get.to(() => const SingupScreen()),
                                child: Text(
                                  "سجل الآن",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w900,
                                      color: ColorsManager.mainBlue),
                                ),
                              ),
                              Text(
                                "ليس لديك حساب؟",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ColorsManager.mainBlack,
                                    fontSize: 15.sp),
                              ),
                            ],
                          ),
                          AppTextButton(
                            backgroundColor: ColorsManager.mainRed,
                            buttonHeight: 50,
                            buttonWidth: 302,
                            borderRadius: 152,
                            buttonText: "تسجيل الدخول",
                            onPressed: controller.login,
                            textStyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorsManager.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
