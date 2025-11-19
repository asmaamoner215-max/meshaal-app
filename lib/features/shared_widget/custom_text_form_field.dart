import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final Color? borderBorderColor;
  final bool isNotVisible;
  final bool? filled;
  final FocusNode? focusNode;
  final double? borderRadius;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.enabled = true,
    this.isNotVisible = false,
    this.controller,
    this.hintStyle,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.fillColor,
    this.filled,
    this.validator,
    this.borderRadius,
    this.focusedBorderColor,
    this.borderBorderColor,
    this.maxLines,
    this.minLines,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius?.r ?? 10.r),
      borderSide: BorderSide(
        color: borderBorderColor ?? AppColors.greyColorD3,
        width: 1.5.w,
      ),
    );
    InputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius?.r ?? 10.r),
      borderSide: BorderSide(
        color: focusedBorderColor ?? AppColors.primaryColor,
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
    return TextFormField(
      controller: controller,
      obscureText: isNotVisible,
      focusNode: focusNode,
      validator: validator,
      maxLines: maxLines,
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      minLines: minLines,
      keyboardType: keyboardType,
      style: CustomThemes.greyColor49TextTheme(context).copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        border: border,
        focusedBorder: focusedBorder,
        enabledBorder: border,
        disabledBorder: border,
        // suffixIconColor: WidgetStateColor.resolveWith(
        //   (states) => states.contains(MaterialState.focused)
        //       ? AppColors.primaryColor
        //       : AppColors.greyColorD3,
        // ),
        errorBorder: errorBorderColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: filled,
        hintText: hintText,
        hintStyle: hintStyle ??
            CustomThemes.greyColorC6TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
        enabled: enabled,
      ),
    );
  }
}
