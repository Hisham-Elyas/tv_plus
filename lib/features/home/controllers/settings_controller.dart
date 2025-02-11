import 'dart:developer';
import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../../../core/localization/constants.dart';
import '../../auth/login/ui/login_screen.dart';
import '../../auth/repos/auth_repo.dart';

class SettingsController extends GetxController {
  final AuthRepoImpFirebase authRepo = Get.find();

  void showFeedback() {
    BetterFeedback.of(Get.context!).show(
      (feedback) async {
        // upload to server, share whatever
        // for example purposes just show it to the user
        final screenshotFilePath =
            await writeImageToStorage(feedback.screenshot);

        final Email email = Email(
          body: feedback.text,
          subject: 'FAISAL Tv Feedback',
          recipients: ['faisal2003tv@gmail.com'],
          attachmentPaths: [screenshotFilePath],
          isHTML: false,
        );
        await FlutterEmailSender.send(email);
        log('Feedback text:');
        log(feedback.text);
        log('Size of image: ${feedback.screenshot.length}');
        if (feedback.extra != null) {
          log('Extras: ${feedback.extra!.toString()}');
        }
      },
    );
  }

  void deleteAccount() {
    // Show confirmation dialog before deleting account
    Get.defaultDialog(
      title: DeleteAccount.tr,
      middleText: DeleteAccountConfirmation.tr,
      onConfirm: () async {
        showOverlay(
          asyncFunction: () async {
            final isSuccess = await authRepo.deleteAccount();

            if (isSuccess) {
              Get.back(); // Close dialog
              Get.offAll(() => const LoginScreen());
            }
          },
        );
      },
      textCancel: Cancel.tr,
      textConfirm: Delete.tr,
    );
  }

  Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }
}
