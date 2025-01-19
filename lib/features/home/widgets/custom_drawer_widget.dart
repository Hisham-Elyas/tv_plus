import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theming/colors.dart';
import '../../onboarding/widgets/logo_card_widget.dart';
import '../ui/about_us_screen.dart';
import '../ui/categories_screen.dart';
import '../ui/contact_us_screen.dart';
import '../ui/home_screen.dart';
import '../ui/profile_screen.dart';

class CustomDrawerWidget extends StatelessWidget {
  CustomDrawerWidget({
    super.key,
  });

  final List<Map<String, dynamic>> drawerItems = [
    {'icon': Icons.home, 'text': 'Home'},
    {'icon': Icons.list, 'text': 'Categories'},
    {'icon': Icons.email, 'text': 'Contact us'},
    {'icon': Icons.info, 'text': 'About us'},
    {'icon': Icons.person, 'text': 'Profile'},
    {'icon': Icons.logout_outlined, 'text': 'Logout'},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsManager.white,
      surfaceTintColor: ColorsManager.white,
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
                );
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

  const CustomListTile({
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        switch (text) {
          case 'Home':
            Get.off(() => const HomeScreen());

            break;
          case 'Categories':
            Get.off(() => const CategoriesScreen());

            break;
          case 'Profile':
            Get.off(() => const ProfileScreen());

            break;
          case 'Contact us':
            Get.off(() => const ContactUsScreen());

            break;
          case 'About us':
            Get.off(() => const AboutUsScreen());

            break;

          default:
            Get.off(() => const HomeScreen());
        }
      },
      leading: Icon(
        icon,
        color: ColorsManager.mainBlack,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ColorsManager.mainBlack,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}
