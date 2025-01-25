import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/shared_pref_helper.dart';
import '../localization/language_controller.dart';

class ThemeController extends GetxController {
  ThemeMode _themeMode = ThemeMode.light;
  final String _themeKey = 'isDarkMode';

  @override
  void onInit() {
    _loadTheme().then((_) => update());
    super.onInit();
  }

  ThemeMode get themeMode => _themeMode;
  Future<void> _loadTheme() async {
    _themeMode = await SharedPrefHelper.getBool(_themeKey) ?? false
        ? ThemeMode.dark
        : ThemeMode.light;
    // update();
  }

  Future<void> toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await SharedPrefHelper.setData(_themeKey, isDark);
    Get.find<LanguageController>().toggleLanguage();
    update();
  }
}
