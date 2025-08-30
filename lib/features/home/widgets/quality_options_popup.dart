import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/localization/constants.dart';
import '../../../core/theming/colors.dart';
import '../controllers/video_player_conteroller.dart';
import '../data/models/category_model.dart';
import '../ui/video_player_screen.dart';

void showFootballChannelPopup(Channel channel) {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400, // تحدد أقصى ارتفاع للـ Dialog
            minWidth: 280,
            maxWidth: 400,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  channel.customName.isNotEmpty
                      ? channel.customName
                      : channel.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Main Link Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shadowColor: ColorsManager.lightSecondary,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.r), // assuming you use flutter_screenutil
                    ),
                  ),
                  onPressed: () => _openVideoUrl(channel.url, channel),
                  icon: const Icon(Icons.play_circle_fill),
                  label: Text(MainLink.tr),
                ),
                const SizedBox(height: 16),

                // Quality Options Header
                if (channel.urlList.isNotEmpty)
                  Text(
                    QualityOptions.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 8),

                // List of quality buttons
                if (channel.urlList.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: channel.urlList.length,
                      itemBuilder: (context, index) {
                        final link = channel.urlList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              elevation: 3,
                              shadowColor: ColorsManager.lightSecondary,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10
                                    .r), // assuming you use flutter_screenutil
                              ),
                            ),
                            onPressed: () => _openVideoUrl(link.url, channel),
                            icon: const Icon(Icons.play_arrow),
                            label: Text(link.name),
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shadowColor: ColorsManager.lightSecondary,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.r), // assuming you use flutter_screenutil
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(Close.tr),
                ),
              ],
            ),
          ),
        ),
      );
    },
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
