import '../../../core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>>? items;
  final void Function(dynamic)? onChanged;
  final dynamic value;
  final String? hintText;
  final Widget? hint;
  final Widget? prefixIcon;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final double? borderRadius;

  const CustomDropDownButton({
    super.key,
    this.items,
    this.onChanged,
    this.value,
    this.hintText,
    this.hint,
    this.prefixIcon,
    this.style,
    this.borderRadius,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius?.r ?? 10.r),
      borderSide: BorderSide(
        color: AppColors.greyColorD3,
        width: 1.5.w,
      ),
    );
    InputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius?.r ?? 10.r),
      borderSide: BorderSide(
        color: AppColors.primaryColor,
        width: 1.5.w,
      ),
    );
    InputBorder errorBorderColor = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius?.r ?? 10.r),
      borderSide: BorderSide(
        color: AppColors.redColor,
        width: 1.5.w,
      ),
    );
    return DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      initialValue: value,
      isExpanded: true,
      hint: hint,
      style: style,
      padding: EdgeInsets.zero,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        hintStyle: hintStyle ??
            CustomThemes.greyColorC6TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
        border: border,
        contentPadding: EdgeInsetsDirectional.only(
          start: 12.w,
          end: 4.w,
          bottom: 4.h,
          top: 4.h,
        ),
        focusedBorder: focusedBorder,
        enabledBorder: border,
        disabledBorder: border,
        errorBorder: errorBorderColor,
      ),
      iconSize: 24.r,
      icon: SvgPicture.asset(
        SvgPath.arrowDown,
        width: 24.w,
        height: 24.h,
      ),
    );
  }
}
