import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/app_router/screens_name.dart';
import 'package:weam/core/app_theme/app_colors.dart';
import '../../../../core/assets_path/images_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController animationController;

  @override
  void initState() {
    _loading();
    super.initState();
  }

  void _handleLogoAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
  }

  void _loading() async {
    _handleLogoAnimation();
    
    // انتظار بسيطة (3 ثواني) ثم الانتقال للشاشة التالية
    await Future.delayed(const Duration(seconds: 3));
    
    // الانتقال إلى شاشة تسجيل الدخول/تسجيل جديد
    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        ScreenName.loginOrRegisterScreen,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: FadeTransition(
          opacity: opacity,
          child: Hero(
            tag: "logoTag",
            child: Material(
              color: Colors.transparent,
              child: Image.asset(
                ImagesPath.logoWhiteColor,
                width: 315.w,
                height: 191.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
