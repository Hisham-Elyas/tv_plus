import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/localization/constants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/card_widget.dart';
import '../../../onboarding/widgets/logo_card_widget.dart';
import '../controller/forget_password_controller.dart';
import '../controller/verification_controller.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.find<ForgetPasswordController>().email ?? '';
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
                  verticalSpace(100),
                  CardWidget(
                    width: 335.w,
                    // height: 200.h,
                    horizontal: 32.w,
                    vertical: 17.h,
                    child: GetBuilder<VerificationController>(
                      builder: (controller) => Form(
                        key: controller.verificationOtpformKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              email,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            verticalSpace(20),
                            AppTextFormField(
                              hintText: VerificationCode.tr,
                              validator: (val) =>
                                  controller.validateEmptyText("OTP", val),
                              onSaved: (val) => controller.setOtp = val,
                            ),
                            verticalSpace(20),
                            AppTextFormField(
                              onSaved: (val) => controller.setnewPassword = val,
                              hintText: NewPassword.tr,
                              validator: (val) =>
                                  controller.validateEmptyText("Password", val),
                            ),
                            verticalSpace(20),
                            AppTextButton(
                              backgroundColor: ColorsManager.mainRed,
                              buttonHeight: 40,
                              buttonWidth: 271,
                              borderRadius: 152,
                              buttonText: Verify.tr,
                              onPressed: () {
                                controller.verifyOTP(email: email);
                              },
                              textStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.surface),
                            )
                          ],
                        ),
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
