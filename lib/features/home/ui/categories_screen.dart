import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:h_tv/core/helpers/spacing.dart';
import 'package:h_tv/features/home/ui/home_screen.dart';

import '../../../core/theming/colors.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, String>> channels = [
    {
      "name": "MBC 1",
      "imageUrl":
          "https://i.imgur.com/7bRVpnu.png", // Replace with actual logo URL
    },
    {
      "name": "MBC 2",
      "imageUrl":
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032', // Replace with actual logo URL
    },
    {
      "name": "MBC 2",
      "imageUrl":
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032', // Replace with actual logo URL
    },
    {
      "name": "MBC 2",
      "imageUrl":
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032', // Replace with actual logo URL
    },
    {
      "name": "MBC 2",
      "imageUrl":
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032', // Replace with actual logo URL
    },
    {
      "name": "MBC 2",
      "imageUrl":
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032', // Replace with actual logo URL
    },
    {
      "name": "MBC 2",
      "imageUrl":
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032', // Replace with actual logo URL
    },
    {
      "name": "MBC 2",
      "imageUrl":
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032', // Replace with actual logo URL
    },
  ];

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainBlack,
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(color: ColorsManager.white),
        ),
        iconTheme: const IconThemeData(
          color: ColorsManager.white, // Change this to your desired color
        ),
      ),
      drawer: CustomDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.4.h, // Aspect ratio of each item
            crossAxisCount: 3, // Number of columns
            crossAxisSpacing: 1, // Spacing between columns
            mainAxisSpacing: 1, // Spacing between rows
          ),
          itemCount: channels.length,
          itemBuilder: (context, index) {
            final channel = channels[index];
            return CategoriesCardWidget(channel: channel);
          },
        ),
      ),
    );
  }
}

class CategoriesCardWidget extends StatelessWidget {
  const CategoriesCardWidget({
    super.key,
    required this.channel,
  });

  final Map<String, String> channel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.r),
      elevation: 3,
      color: ColorsManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                channel["imageUrl"]!,
                width: 70.w,
                height: 70.h,
                fit: BoxFit.contain,
              ),
            ),
            verticalSpace(8),
            Text(
              channel["name"]!,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
