import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/localization/constants.dart';
import '../../../core/localization/language_controller.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/theme_controller.dart';
import '../../auth/login/ui/login_screen.dart';
import '../controllers/settings_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';
import 'feedback_sereen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Settings.tr),
      drawer: CustomDrawerWidget(),
      body: Padding(
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
            verticalSpace(10.h),
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
            verticalSpace(10.h),
            CustomListTileWidget(
              icon: Icons.feedback,
              title: Report_a_Problem_Or_Leave_Feedback.tr,
              onTap: () {
                Get.to(() => const FeedbackScreen());
              },
            ),
            verticalSpace(10.h),
            CustomListTileWidget(
              icon: Icons.logout_rounded,
              title: Logout.tr,
              onTap: () async{
              
              await  Get.find<SettingsController>().authRepo.logeOut();
               Get.offAll(() => const LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTileWidget extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData icon;
  final Widget? trailing;

  const CustomListTileWidget({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 10,
        shadowColor: ColorsManager.lightSecondary,
        child: ListTile(
          trailing: trailing,
          onTap: onTap,
          leading: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ));
  }
}
