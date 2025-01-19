import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theming/colors.dart';

void showCustomSnackBar(
    {required String message,
    bool isError = false,
    String? title,
    void Function(GetSnackBar)? onTap}) {
  Get.closeAllSnackbars();
  Get.snackbar(
    title ?? "Errors",
    message,
    onTap: onTap,
    titleText:
        Text(title ?? "Errors", style: const TextStyle(color: Colors.white)),
    messageText: Text(message, style: const TextStyle(color: Colors.white)),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? const Color(0xffcf6679) : ColorsManager.mainBlue,
  );
}
