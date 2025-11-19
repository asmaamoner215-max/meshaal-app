
import 'package:flutter/material.dart';

class AppColors {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static const primaryColor = Color(0xff4BCEBC);
  static const servicesUpperSubContainerColor = Color(0xff39AC9C);
  static const servicesLowerSubContainerColor = Color(0xff91E4D9);
  static const greyColor797 = Color(0xff797C7E);
  static const greyColorD3 = Color(0xffD3D3D3);
  static const greyColorC6 = Color(0xffC6C6C6);
  static const greyColorF6 = Color(0xffF6F7F9);
  static const greyColor49 = Color(0xff494949);
  static const whiteColor = Color(0xffFFFFFF);
  static const redColor = Color(0xffFF0000);
  static const reserveRedColor = Color(0xffFB4455);
  static  Color shadowColor({double opacityValue = 0}) => const Color(0xff000000).withOpacity(opacityValue);
}