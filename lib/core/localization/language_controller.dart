// language_controller.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:h_tv/core/helpers/spacing.dart';
import 'package:h_tv/core/localization/constants.dart';

import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';

class LanguageController extends GetxController {
  final String _languageKey = 'appLanguage';
  Locale _appLocale = const Locale('en');

  Locale get appLocale => _appLocale;
  bool get isArabic => _appLocale.languageCode == 'ar';

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    String languageCode = await SharedPrefHelper.getString(_languageKey);
    log('languageCode===========>: $languageCode');
    _appLocale = languageCode != '' ? Locale(languageCode) : const Locale('en');
    Get.updateLocale(_appLocale);
    update();
  }

  Future<void> changeLanguage(Locale newLocale) async {
    await SharedPrefHelper.setData(_languageKey, newLocale.languageCode);
    _appLocale = newLocale;
    Get.updateLocale(newLocale);
    update();
  }

  void toggleLanguage() {
    final newLang = isArabic ? const Locale('en') : const Locale('ar');
    changeLanguage(newLang);
  }

  // Add this to your LanguageController
  void showLanguageBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Select_language.tr,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(Get.context!).colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(Get.context!).colorScheme.onSurface,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            _buildLanguageOption('en', English.tr, ImageAssets.usFlags),
            _buildLanguageOption('ar', Arabic.tr, ImageAssets.saFlags),
            verticalSpace(20)
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
      String langCode, String languageName, String flagPath) {
    return GetBuilder<LanguageController>(
      builder: (controller) => ListTile(
        leading: Image.asset(flagPath, width: 40, height: 30),
        title: Text(languageName,
            style: TextStyle(
              color: Theme.of(Get.context!).colorScheme.onSurface,
            )),
        trailing: controller.appLocale.languageCode == langCode
            ? Icon(
                Icons.check_circle,
                color: Theme.of(Get.context!).colorScheme.primary,
              )
            : null,
        onTap: () {
          controller.changeLanguage(Locale(langCode));
          Get.back();
        },
      ),
    );
  }
}
