import 'package:flutter/material.dart';

import '../../../core/theming/colors.dart';
import '../widgets/custom_drawer_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us", style: TextStyle(color: Colors.white)),
        backgroundColor: ColorsManager.mainBlack,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: ColorsManager.white, // Change this to your desired color
        ),
      ),
      drawer: CustomDrawerWidget(),
    );
  }
}
