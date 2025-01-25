import 'package:flutter/material.dart';
import 'package:h_tv/core/theming/colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: ColorsManager.lightPrimary,
      secondary: ColorsManager.lightSecondary,
      surface: ColorsManager.lightSurface,
      onSurface: ColorsManager.lightOnSurface,
      error: ColorsManager.lightError,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: ColorsManager.darkPrimary,
      secondary: ColorsManager.darkSecondary,
      surface: ColorsManager.darkSurface,
      onSurface: ColorsManager.darkOnSurface,
      error: ColorsManager.darkError,
    ),
  );
}
