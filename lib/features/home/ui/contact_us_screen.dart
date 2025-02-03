import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/localization/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ContactUs.tr),
      drawer: CustomDrawerWidget(),
      body: Center(
        child: Text(Soon.tr),
      ),
    );
  }
}
