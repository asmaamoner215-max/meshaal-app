import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomAppBar extends StatelessWidget {
  final List<Widget>? actions;
  final Widget? leading;
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.actions,
    this.leading,
    required this.title,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor(),
            offset: Offset(0, 8.h),
            blurRadius: 32.r,
          )
        ],
      ),
      child: AppBar(
        title: Text(
          title.tr(),
          style: CustomThemes.greyColor49TextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: leading ?? (showBackButton && Navigator.canPop(context)
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.greyColor49,
                  size: 20.sp,
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null),
        centerTitle: false,
        actions: actions,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
