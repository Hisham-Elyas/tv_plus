import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/video_player_conteroller.dart';
import '../../data/models/category_model.dart';
import '../../widgets/channel_card_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/show_football_channel_popup.dart';
import '../video_player_screen.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  final CategoryWithChannels category;
  const CategoriesDetailsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: category.categoryName,
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
            category.channels
                .sort((a, b) => a.customName.compareTo(b.customName));
            final Channel channel = category.channels[index];
            return ChannelCardWidget(
              channel: channel,
              onTap: () async {
                // Get.to(() => VideoPlayerOptionScreen(
                //       channel: channel,
                //     ));
                showFootballChannelPopup(
                  channel: channel,
                  onPressedLink: (p0) async {
                    Get.find<VideoPlayerConteroller>().videoUrls = p0;
                    Get.to(() => VideoPlayerScreen(
                          channel: channel,
                        ));
                    await Get.find<VideoPlayerConteroller>()
                        .setAllOrientationsToLandscape();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
