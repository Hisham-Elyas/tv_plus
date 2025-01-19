import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theming/colors.dart';
import '../data/models/channel_category_model.dart';
import '../widgets/channel_card_widget.dart';
import 'video_player_screen.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  final ChannelCategory category;
  const CategoriesDetailsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainBlack,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: ColorsManager.white, // Change this to your desired color
        ),
        title: Text(
          category.categoryName,
          style: const TextStyle(color: ColorsManager.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.4.h, // Aspect ratio of each item
            crossAxisCount: 3, // Number of columns
            crossAxisSpacing: 1, // Spacing between columns
            mainAxisSpacing: 1, // Spacing between rows
          ),
          itemCount: category.channels.length,
          itemBuilder: (context, index) {
            final Channel channel = category.channels[index];
            return ChannelCardWidget(
              channel: channel,
              onTap: () {
            //    Get.to(() => //VideoPlayerScreen(
           //           videoUrl: //channel.videoUrl,
                  //  ));
Navigator.push(
context,
MaterialPageRoute (builder:
(context) => const VideoPlayerScreen(videoUrl: channel.videoUrl,)),
);
              },
            );
          },
        ),
      ),
    );
  }
}
