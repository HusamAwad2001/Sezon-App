import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_strings.dart';

class AppThemes {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    primarySwatch: MaterialColor(
      AppColors.primaryCode,
      <int, Color>{
        50: AppColors.primaryColor.withOpacity(0.1),
        100: AppColors.primaryColor.withOpacity(0.2),
        200: AppColors.primaryColor.withOpacity(0.3),
        300: AppColors.primaryColor.withOpacity(0.4),
        400: AppColors.primaryColor.withOpacity(0.5),
        500: AppColors.primaryColor.withOpacity(0.6),
        600: AppColors.primaryColor.withOpacity(0.7),
        700: AppColors.primaryColor.withOpacity(0.8),
        800: AppColors.primaryColor.withOpacity(0.9),
        900: AppColors.primaryColor.withOpacity(1),
      },
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: AppStrings.fontFamily,
    appBarTheme: const AppBarTheme(
      elevation: 0,
    ),
  );
}
