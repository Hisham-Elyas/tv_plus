import 'package:faisal_tv/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/localization/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';
import '../widgets/custom_listtile_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  Future<void> dialNumber(String number) async {
    final Uri phoneUri = Uri.parse("tel:$number");
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not dial $number';
    }
  }

  Future<void> sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Hello FAISAL Tv', 'body': ''},
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not send email to $email';
    }
  }

  Future<void> openWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open $url';
    }
  }

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
                onTap: () => openWebsite("https://www.faisal-tv.com")),
            verticalSpace(10),
            CustomListTileWidget(
                title: "0570105563",
                icon: Icons.phone,
                onTap: () => dialNumber("0570105563")),
            verticalSpace(10),
            CustomListTileWidget(
              title: "faisal2003tv@gmail.com",
              icon: Icons.email,
              onTap: () => sendEmail("faisal2003tv@gmail.com"),
            ),
          ],
        ),
      ),
    );
  }
}
