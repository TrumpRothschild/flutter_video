import 'package:base/app_config.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/material.dart';

import 'custom_theme.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class AppTheme {
  static ThemeData light = lightTheme;
  static ThemeData dark = darkTheme;

  static CustomTheme lightCustom = lightCustomTheme;
  static CustomTheme dartCustom = lightCustomTheme;

  static ThemeData currentThemeData(GetXBaseController controller) {
    return controller.themeController.themeType.value == ThemeType.day
        ? AppTheme.light
        : AppTheme.dark;
  }

  static CustomTheme currentCustomData(GetXBaseController controller) {
    return controller.themeController.themeType.value == ThemeType.day
        ? AppTheme.lightCustom
        : AppTheme.dartCustom;
  }
}
