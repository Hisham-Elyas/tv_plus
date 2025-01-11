import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/theming/colors.dart';
import 'home_screen.dart';

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
