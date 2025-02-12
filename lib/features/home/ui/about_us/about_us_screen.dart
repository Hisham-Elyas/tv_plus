import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/localization/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_drawer_widget.dart';
import '../../widgets/expandable_text_widget.dart';

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
        child: ListView.builder(
          itemCount: FAISAL_Tv_Abut_us_list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FAISAL_Tv_Abut_us_list[index].tr,
                style: TextStyle(
                  fontSize: 40.0.sp,
                  height: 1.5.h,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              ExpandableText(text: FAISAL_Tv_Abut_us_desc_list[index].tr),
            ],
          ),
        ),
      ),
    );
  }
}
