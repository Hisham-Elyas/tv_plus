import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/localization/constants.dart';
import '../controllers/video_player_conteroller.dart';
import '../data/models/category_model.dart';
import '../ui/video_player_screen.dart';

void showFootballChannelPopup(Channel channel) {
  Get.defaultDialog(
    title: channel.customName.isNotEmpty ? channel.customName : channel.name,
    titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main Link Button
        ElevatedButton.icon(
          onPressed: () => _openVideoUrl(channel.url, channel),
          icon: const Icon(Icons.play_circle_fill),
          label: Text(MainLink.tr),
        ),
        const SizedBox(height: 16),

        // Quality Options Header
        if (channel.urlList.isNotEmpty)
          Text(QualityOptions.tr,
              style: TextStyle(fontWeight: FontWeight.bold)),

        const SizedBox(height: 8),

        // Scrollable list of quality buttons
        if (channel.urlList.isNotEmpty)
          SizedBox(
            height: 200, // Limit height so it scrolls if long
            child: ListView.builder(
              itemCount: channel.urlList.length,
              itemBuilder: (context, index) {
                final link = channel.urlList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton.icon(
                    onPressed: () => _openVideoUrl(link.url, channel),
                    icon: const Icon(Icons.play_arrow),
                    label: Text(link.name),
                  ),
                );
              },
            ),
          ),
      ],
    ),
    textConfirm: Close.tr,
    confirmTextColor: Colors.white,
    onConfirm: () => Get.back(),
  );
}

void _openVideoUrl(String url, Channel channel) async {
  final controller = Get.find<VideoPlayerConteroller>();
  controller.videoUrls = url;
  Get.to(() => VideoPlayerScreen(
        channel: channel,
      ));

  controller.setAllOrientationsToLandscape();
}
