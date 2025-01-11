import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theming/colors.dart';
import '../../onboarding/widgets/logo_card_widget.dart';

import 'about_us_screen.dart';
import 'categories_screen.dart';
import 'contact_us_screen.dart';
import 'profile_screen.dart';
import 'video_player_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {
        "team1": "الدينزي",
        "team2": "فالنسيا",
        "team1Logo": "https://imgs.ysscores.com/teams/150/1701690118820.png",
        "team2Logo": "https://imgs.ysscores.com/teams/150/4871690119302.png",
        "status": "جارية الآن",
        "league": "كأس ملك إسبانيا",
        "commentator": "عبدالعزيز السير",
        "channel": "SSC Extra 2",
      },
      {
        "team1": "التعاون",
        "team2": "القادسية",
        "team1Logo": "https://imgs.ysscores.com/teams/150/1701690118820.png",
        "team2Logo": "https://imgs.ysscores.com/teams/150/4871690119302.png",
        "status": "انتهت المباراة",
        "league": "كأس الملك السعودي",
        "commentator": "خالد المديفر",
        "channel": "SSC Extra 1",
      },
      {
        "team1": "الهلال",
        "team2": "الاتحاد",
        "team1Logo": "https://imgs.ysscores.com/teams/150/1701690118820.png",
        "team2Logo": "https://imgs.ysscores.com/teams/150/4871690119302.png",
        "status": "انتهت المباراة",
        "league": "كأس الملك السعودي",
        "commentator": "عبدالله الحربي",
        "channel": "SSC SPORTS 1",
      },
    ];
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

class MatchCardWidget extends StatelessWidget {
  const MatchCardWidget({
    super.key,
    required this.event,
  });

  final Map<String, dynamic> event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VideoPlayerScreen()),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 3,
        color: ColorsManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.network(
                        event["team1Logo"],
                        fit: BoxFit.contain,
                        width: 80.w,
                        height: 80.h,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        event["team1"],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    event["status"],
                    style: TextStyle(
                      fontSize: 16,
                      color: event["status"] == "جارية الآن"
                          ? Colors.green
                          : Colors.black,
                    ),
                  ),
                  Column(
                    children: [
                      Image.network(
                        event["team2Logo"],
                        width: 80.w,
                        height: 80.h,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        event["team2"],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    event["league"],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const Icon(Icons.mic, color: Colors.grey),
                  const Icon(Icons.tv, color: Colors.grey),
                  Text(
                    event["channel"],
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
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
            Get.off(() => CategoriesScreen());

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
