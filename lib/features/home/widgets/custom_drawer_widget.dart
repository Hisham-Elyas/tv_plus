import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/localization/constants.dart';
import '../../onboarding/widgets/logo_card_widget.dart';
import '../ui/about_us/about_us_screen.dart';
import '../ui/categories/categories_screen.dart';
import '../ui/contact_us/contact_us_screen.dart';
import '../ui/home_screen.dart';
import '../ui/profile/profile_screen.dart';
import '../ui/setting/settings_screen.dart';

class CustomDrawerWidget extends StatelessWidget {
  CustomDrawerWidget({
    super.key,
  });

  final List<Map<String, dynamic>> drawerItems = [
    {'icon': Icons.home, 'text': Home.tr},
    {'icon': Icons.list, 'text': Categories.tr},
    {'icon': Icons.email, 'text': ContactUs.tr},
    {'icon': Icons.info, 'text': AboutUs.tr},
    {'icon': Icons.person, 'text': Profile.tr},
    {'icon': Icons.settings, 'text': Settings.tr},
  ];

  @override
  Widget build(BuildContext context) {
    // Get.find<ProfileController>();
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          LogoCardWidget(
            width: double.infinity,
            height: 180.h,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                return CustomListTile(
                    icon: drawerItems[index]['icon'],
                    text: drawerItems[index]['text'],
                    index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final int index;

  const CustomListTile({
    required this.icon,
    required this.text,
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        switch (index) {
          case 0:
            Get.off(() => const HomeScreen());
            break;
          case 1:
            Get.off(() => const CategoriesScreen());

            break;
          case 2:
            Get.off(() => const ContactUsScreen());
            break;
          case 3:
            Get.off(() => const AboutUsScreen());

            break;
          case 4:
            Get.off(() => const ProfileScreen());

            break;
          case 5:
            Get.off(() => const SettingsScreen());

            break;

          default:
            Get.off(() => const HomeScreen());
        }
      },
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}
