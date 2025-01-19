import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theming/colors.dart';
import '../ui/video_player_screen.dart';

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
      //  Get.to(() => const //VideoPlayerScreen());
Navigator.push(
context,
MaterialPageRoute (builder:
(context) => const VideoPlayerScreen()),
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
                      CachedNetworkImage(
                        width: 80.w,
                        height: 80.h,
                        fit: BoxFit.contain,
                        imageUrl: event["team1Logo"],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              color: ColorsManager.mainBlue,
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                      CachedNetworkImage(
                        width: 80.w,
                        height: 80.h,
                        fit: BoxFit.contain,
                        imageUrl: event["team2Logo"],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    color: ColorsManager.mainBlue,
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
