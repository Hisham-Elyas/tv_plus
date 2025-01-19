import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/theming/colors.dart';
import '../../onboarding/widgets/logo_card_widget.dart';
import '../widgets/custom_drawer_widget.dart';
import '../widgets/match_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainBlack,
        centerTitle: true,
        title: const LogoCardWidget(width: 150, height: 53),
        iconTheme: const IconThemeData(
          color: ColorsManager.white, // Change this to your desired color
        ),
      ),
      drawer: CustomDrawerWidget(),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 10.h),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return MatchCardWidget(event: event);
        },
      ),
    );
  }
}
