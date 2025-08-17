import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/localization/constants.dart';
import '../../../core/localization/language_controller.dart';
import '../../../core/theming/theme_controller.dart';
import '../../auth/login/ui/login_screen.dart';
import '../controllers/settings_controller.dart';
import '../widgets/custom_listtile_widget.dart';
import 'setting/feedback_sereen.dart';

class SimplifiedSettingsScreen extends StatelessWidget {
  const SimplifiedSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Column(
        children: [
          CustomListTileWidget(
            icon: Icons.language_rounded,
            title: Language.tr,
            onTap: () {
              Get.find<LanguageController>().showLanguageBottomSheet();
            },
          ),
          verticalSpace(10),
          GetBuilder<ThemeController>(
            builder: (controller) => CustomListTileWidget(
              icon: Icons.brightness_medium,
              title: Dark_Mode.tr,
              trailing: Switch(
                value: controller.themeMode == ThemeMode.dark,
                onChanged: (value) => controller.toggleTheme(value),
              ),
            ),
          ),
          verticalSpace(10),
          CustomListTileWidget(
            icon: Icons.feedback,
            title: Report_a_Problem_Or_Leave_Feedback.tr,
            onTap: () {
              Get.to(() => const FeedbackScreen());
            },
          ),
          verticalSpace(10),
          CustomListTileWidget(
            icon: Icons.logout_rounded,
            title: Logout.tr,
            onTap: () async {
              await Get.find<SettingsController>().authRepo.logeOut();
              Get.offAll(() => const LoginScreen());
            },
          ),
          verticalSpace(10),
          CustomListTileWidget(
            title: DeleteAccount.tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.error,
            ),
            trailing: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
            onTap: () async {
              Get.find<SettingsController>().deleteAccount();
            },
          ),
        ],
      ),
    );
  }
}
