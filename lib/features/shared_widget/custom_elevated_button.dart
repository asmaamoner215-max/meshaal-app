import 'package:weam/core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? elevation;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final TextStyle? titleStyle;

  const CustomElevatedButton({
    super.key,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.onPressed,
    this.child,
    this.text,
     this.borderRadius = 12,
    this.titleStyle,
    this.elevation,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor,
          disabledBackgroundColor: AppColors.greyColorD3,
          backgroundColor: backgroundColor,
          elevation: elevation,
          padding: padding,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        child: child ??
            Text(
              text ?? "",
              style: titleStyle ??
                  Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
            ),
      ),
    );
  }
}
