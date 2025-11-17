import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weam/features/shared_widget/custom_outlined_button.dart';

import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../../shared_widget/custom_sizedbox.dart';

class PaymentButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isSelected;
  final String title;
  final String assetName;

  const PaymentButton({
    super.key,
    required this.isSelected,
    this.onPressed,
    required this.title,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: onPressed,
      borderColor: isSelected ? AppColors.primaryColor : AppColors.greyColor49,
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
            width: 16,
          ),
          SvgPicture.asset(
            assetName,
            width: 24.w,
            height: 24.h,
          ),
          const CustomSizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: CustomThemes.greyColor49TextTheme(context).copyWith(
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