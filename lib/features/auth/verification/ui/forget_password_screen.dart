import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/card_widget.dart';
import '../../../onboarding/widgets/logo_card_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
                    width: 335.w,
                    height: 200.h,
                    horizontal: 32.w,
                    vertical: 17.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextFormField(
                          controller: TextEditingController(),
                          hintText: "رقم الهاتف",
                          validator: (p0) {
                            return null;
                          },
                        ),
                        verticalSpace(20),
                        AppTextButton(
                          backgroundColor: ColorsManager.mainRed,
                          buttonHeight: 40,
                          buttonWidth: 271,
                          borderRadius: 152,
                          buttonText: "طلب الرمز",
                          onPressed: () {},
                          textStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorsManager.white),
                        )
                      ],
                    ),
                  ),
                  verticalSpace(80),
                  CardWidget(
                    width: 335.w,
                    height: 200.h,
                    horizontal: 32.w,
                    vertical: 17.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextFormField(
                          controller: TextEditingController(),
                          hintText: "رمز التأكيد",
                          validator: (p0) {
                            return null;
                          },
                        ),
                        verticalSpace(20),
                        AppTextButton(
                          backgroundColor: ColorsManager.mainRed,
                          buttonHeight: 40,
                          buttonWidth: 271,
                          borderRadius: 152,
                          buttonText: "تحقق من الرمز",
                          onPressed: () {},
                          textStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorsManager.white),
                        )
                      ],
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
