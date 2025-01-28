import 'dart:developer';

import 'package:feedback/feedback.dart';
import 'package:get/get.dart';

import '../../auth/repos/auth_repo.dart';

class SettingsController extends GetxController {
  final AuthRepoImpFirebase authRepo = Get.find();

  void showFeedback() {
    BetterFeedback.of(Get.context!).show(
      (feedback) {
        // upload to server, share whatever
        // for example purposes just show it to the user

        log('Feedback text:');
        log(feedback.text);
        log('Size of image: ${feedback.screenshot.length}');
        if (feedback.extra != null) {
          log('Extras: ${feedback.extra!.toString()}');
        }
      },
    );
  }
}
