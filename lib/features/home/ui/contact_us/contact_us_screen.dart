import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/localization/constants.dart';
import '../../controllers/contact_us_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_drawer_widget.dart';
import '../../widgets/custom_listtile_widget.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ContactUs.tr),
      drawer: CustomDrawerWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          children: [
            verticalSpace(20),
            CustomListTileWidget(
                title: "www.faisal-tv.com",
                icon: Icons.language_rounded,
                onTap: () =>
                    controller.openWebsite("https://www.faisal-tv.com")),
            verticalSpace(10),
            CustomListTileWidget(
                title: "0570105563",
                icon: Icons.phone,
                onTap: () => controller.dialNumber("0570105563")),
            verticalSpace(10),
            CustomListTileWidget(
              title: "faisal2003tv@gmail.com",
              icon: Icons.email,
              onTap: () => controller.sendEmail("faisal2003tv@gmail.com"),
            ),
            verticalSpace(10),
            CustomListTileWidget(
              title: "X",
              icon: Icons.language_rounded,
              onTap: () => controller.openWebsite("https://x.com/elonmusk"),
            ),
          ],
        ),
      ),
    );
  }
}
