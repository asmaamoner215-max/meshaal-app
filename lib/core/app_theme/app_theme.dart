import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets_path/fonts_path.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primarySwatch: AppColors.createMaterialColor(AppColors.primaryColor),
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      primaryColor: AppColors.primaryColor,
      useMaterial3: true,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
        ),
      ),
      scaffoldBackgroundColor: AppColors.whiteColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: FontsPath.almarai,
          ),
          headlineMedium: TextStyle(
            color: AppColors.greyColor797,
            fontFamily: FontsPath.almarai,
          ),
          headlineSmall: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: FontsPath.almarai,
          ),
          bodyLarge: TextStyle(
            color: AppColors.greyColorC6,
            fontFamily: FontsPath.almarai,
          ),
          bodyMedium: TextStyle(
            color: AppColors.greyColor49,
            fontFamily: FontsPath.almarai,
          )));
}
