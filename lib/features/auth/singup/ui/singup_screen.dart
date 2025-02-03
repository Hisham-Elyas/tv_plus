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
import '../controllers/singup_controller.dart';

class SingupScreen extends GetView<SingupController> {
  const SingupScreen({super.key});

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
              ).copyWith(top: 20.h),
              width: double.infinity,
              child: Column(
                children: [
                  LogoCardWidget(
                    width: 335.w,
                    height: 140.h,
                  ),
                  verticalSpace(25),
                  CardWidget(
                    horizontal: 32.w,
                    vertical: 17.h,
                    width: 335.w,
                    // height: 600.h,
                    child: Form(
                      key: controller.singUpformKey,
                      child: Column(
                        children: [
                          Text(Sign_Up.tr,
                              style: TextStyle(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          verticalSpace(15),
                          AppTextFormField(
                            onSaved: (val) => controller.setuserName = val,
                            hintText: UserName.tr,
                            validator: controller.userNamevalidator,
                          ),
                          verticalSpace(15),
                          AppTextFormField(
                            onSaved: (val) => controller.setEmail = val,
                            hintText: Enter_your_email.tr,
                            validator: controller.emailvalidator,
                          ),
                          verticalSpace(15),
                          AppTextFormField(
                            onSaved: (val) => controller.setPassword = val,
                            hintText: Enter_your_password.tr,
                            validator: controller.passwordvalidator,
                          ),
                          verticalSpace(15),
                          AppTextFormField(
                            onSaved: (val) =>
                                controller.setconfirmPassword = val,
                            hintText: Confirm_password.tr,
                            validator: controller.passwordvalidator,
                          ),
                          verticalSpace(15),
                          AppTextFormField(
                            onSaved: (val) => controller.setphoneNumber = val,
                            hintText: Phone_number.tr,
                            validator: controller.phonevalidator,
                          ),
                          verticalSpace(20),
                          AppTextButton(
                            backgroundColor: ColorsManager.mainRed,
                            buttonHeight: 40,
                            buttonWidth: 271,
                            borderRadius: 152,
                            buttonText: Sign_Up.tr,
                            onPressed: controller.singUp,
                            textStyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.surface),
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
