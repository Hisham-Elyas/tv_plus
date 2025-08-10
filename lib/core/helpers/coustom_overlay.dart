import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: strict_top_level_inference
showOverlay({required Future<void> Function() asyncFunction}) {
  Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: const Center(
        child: CircularProgressIndicator(),
      ));
}
