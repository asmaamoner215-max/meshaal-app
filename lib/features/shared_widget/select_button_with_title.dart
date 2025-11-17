import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../features/shared_widget/custom_outlined_button.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';

class SelectButtonWithTitle extends StatelessWidget {
  final void Function()? onPressed;
  final bool isSelected;
  final Color borderColor;
  final String title;

  const SelectButtonWithTitle({
    super.key,
    this.onPressed,
    required this.isSelected,
    this.borderColor = AppColors.greyColorD3,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: onPressed,
      borderColor: borderColor,
      foregroundColor: AppColors.primaryColor,
      borderRadius: 12,
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 16.w,
      ),
      child: Row(
        children: [
          Ink(
            height: 20.h,
            width: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1.w,
              ),
            ),
          ),
          const CustomSizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: CustomThemes.greyColor797TextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
