import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/localization/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AboutUs.tr,
      ),
      drawer: CustomDrawerWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.dm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "WHO WE ARE",
              style: TextStyle(
                fontSize: 50.0.sp,
                height: 1.5.h,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              "  At FAISAL TV, we are more than just a sports TV channel—we are a community united by a shared passion for sports. Founded with the mission to bring fans closer to the action, we pride ourselves on delivering unparalleled access to the world's most exciting sporting events.\n\n"
              "Our team consists of sports enthusiasts, expert commentators, and dedicated professionals who work tirelessly to provide top-notch content that entertains, informs, and inspires. From live broadcasts to exclusive interviews, behind-the-scenes features, and in-depth analyses, we offer a 360-degree sports experience tailored to fans of all ages and interests.\n\n"
              "We believe in the power of sports to unite, inspire, and create unforgettable memories. Whether you're cheering for your favorite team or discovering a new sport, FAISAL TV is here to connect you with the moments that matter most.",
              style: TextStyle(
                  fontSize: 16.0.sp,
                  height: 1.5.h,
                  color: Theme.of(context).colorScheme.onSurface),
            )
          ],
        ),
      ),
    );
  }
}
