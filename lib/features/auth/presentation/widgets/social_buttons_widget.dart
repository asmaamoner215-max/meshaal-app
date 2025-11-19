import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weam/core/app_theme/app_colors.dart';
import 'package:weam/core/assets_path/svg_path.dart';
import 'package:weam/features/shared_widget/custom_outlined_button.dart';

class SocialButtonsWidget extends StatelessWidget {
  const SocialButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomOutlinedButton(
          padding: EdgeInsets.symmetric(horizontal: 21.w,vertical: 7.h,),
          foregroundColor: AppColors.primaryColor,
          onPressed: () {},
          child: SvgPicture.asset(
            SvgPath.email,
            height: 26.h,
            width: 26.w,
          ),
        ),
        CustomOutlinedButton(
          padding: EdgeInsets.symmetric(horizontal: 21.w,vertical: 7.h,),
          foregroundColor: AppColors.primaryColor,
          onPressed: () {},
          child: SvgPicture.asset(
            SvgPath.facebook,
            height: 26.h,
            width: 26.w,
          ),
        ),
        CustomOutlinedButton(
          padding: EdgeInsets.symmetric(horizontal: 21.w,vertical: 7.h,),
          foregroundColor: AppColors.primaryColor,
          onPressed: () {},
          child: SvgPicture.asset(
            SvgPath.google,
            height: 26.h,
            width: 26.w,
          ),
        ),
      ],
    );
  }
}
