import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/localization/constants.dart';
import '../../../core/widgets/app_text_button.dart';
import '../controllers/settings_controller.dart';
import '../widgets/custom_app_bar.dart';

class FeedbackScreen extends GetView<SettingsController> {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: feeedback.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 12.0.w),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 60.h),
              Text(
                How_feedback_it_work.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              const Divider(),
              SizedBox(height: 50.h),
              AppTextButton(
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
                buttonHeight: 50.h,
                buttonWidth: 200.w,
                buttonText: Provide_feedback.tr,
                onPressed: () {
                  controller.showFeedback();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.feedback,
          size: 24.dm,
          // color: AppColor.mainColor,
        ),
        onPressed: () {
          controller.showFeedback();
        },
      ),
    );
  }
}
