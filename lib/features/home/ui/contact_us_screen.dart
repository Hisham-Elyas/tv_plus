import 'package:faisal_tv/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_plus/flutter_launcher_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/localization/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';

class ContactUsScreen extends StatefulWidget {
  static const _channel = MethodChannel("flutter_launcher_plus");
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  String _platformVersion = 'Unknown';

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterLauncherPlus.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> dialNumber(String number) async {
    await ContactUsScreen._channel.invokeMethod('dialNumber', <String, String>{
      'number': number,
    });
  }

  Future<void> launchUrl(String websiteUrl) async {
    await ContactUsScreen._channel
        .invokeMethod('launchUrl', <String, String>{'website_url': websiteUrl});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ContactUs.tr),
      drawer: CustomDrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => dialNumber("0570105563"),
              child: Text(
                "0570105563",
                style: TextStyle(
                  fontSize: 20.0.sp,
                  height: 1.5.h,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            verticalSpace(10),
            InkWell(
              onTap: () => launchUrl("faisal2003tv@gmail.com"),
              child: Text(
                "faisal2003tv@gmail.com",
                style: TextStyle(
                  fontSize: 20.0.sp,
                  height: 1.5.h,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            verticalSpace(10),
            InkWell(
              onTap: () => launchUrl("www.faisal-tv.com"),
              child: Text(
                "www.faisal-tv.com",
                style: TextStyle(
                  fontSize: 20.0.sp,
                  height: 1.5.h,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
