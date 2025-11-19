import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weam/core/app_theme/app_colors.dart';
import 'package:weam/core/assets_path/svg_path.dart';

class AuthBackgroundWidget extends StatelessWidget {
  final Widget child;

  const AuthBackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 456.h,
            child: SvgPicture.asset(
              SvgPath.authBackVector,
              fit: BoxFit.fill,
            ),
          )
          ,
          child,
        ],
      ),
    );
  }
}
