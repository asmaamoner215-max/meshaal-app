import 'package:flutter/material.dart';

import '../../core/app_theme/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String? title;
  final void Function()? onPressed;
  final TextStyle? style;
  final Widget? child;
  final TextAlign? textAlign;
  const CustomTextButton({
    super.key,
    this.title,
    this.onPressed,
    this.textAlign,
    this.style, this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: AppColors.primaryColor,
      ),

      child: child??Text(
        title??"",
        textAlign: textAlign,
        style: style,
      ),
    );
  }
}
