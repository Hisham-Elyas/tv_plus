import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/category_model.dart';

void showFootballChannelPopup(
    {required Channel channel, required void Function(String) onPressedLink}) {
  Get.defaultDialog(
    title: channel.customName.isNotEmpty ? channel.customName : channel.name,
    titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main Link Button
        ElevatedButton.icon(
          onPressed: () => onPressedLink(channel.url),
          icon: const Icon(Icons.play_circle_fill),
          label: const Text("🎯 Main Link"),
        ),
        const SizedBox(height: 12),

        // Quality Links
        if (channel.urlList.isNotEmpty)
          const Text("📺 Quality Options:",
              style: TextStyle(fontWeight: FontWeight.bold)),

        const SizedBox(height: 8),
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
                    onPressed: () => onPressedLink(channel.url),
                    icon: const Icon(Icons.play_arrow),
                    label: Text(link.name),
                  ),
                );
              },
            ),
          ),
      ],
    ),
    confirmTextColor: Colors.white,
    onConfirm: () => Get.back(),
  );
}
