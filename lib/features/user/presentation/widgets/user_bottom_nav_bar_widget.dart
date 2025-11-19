import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/assets_path/svg_path.dart';

class UserBottomNavBarWidget extends StatelessWidget {
  final void Function(int)? onTap;
  final int currentIndex;

  const UserBottomNavBarWidget({
    super.key,
    this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 4.r,
            color: AppColors.shadowColor(opacityValue: 0.20),
          ),
        ],
      ),
      child: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,

        iconSize: 26.r,
        items: [
          BottomNavigationBarItem(
            label: "الرئيسية",
            icon: SvgPicture.asset(
              SvgPath.home,
              width: 24.w,
              height: 24.h,
              colorFilter: currentIndex == 0
                  ? const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn,)
                  : null,
            ),
          ),
          BottomNavigationBarItem(
            label: "حسابي",
            icon: SvgPicture.asset(
              SvgPath.userNav,
              width: 24.w,
              height: 24.h,
              colorFilter: currentIndex == 1
                  ? const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn,)
                  : null,
            ),
          ),
          // BottomNavigationBarItem(
          //   label: "الاتصال بالطوارئ",
          //   icon: SvgPicture.asset(
          //     SvgPath.callCalling,
          //     width: 24.w,
          //     height: 24.h,
          //     colorFilter: currentIndex == 2
          //         ? const ColorFilter.mode(
          //             AppColors.primaryColor, BlendMode.srcIn)
          //         : null,
          //   ),
          // )
        ],
      ),
    );
  }
}
