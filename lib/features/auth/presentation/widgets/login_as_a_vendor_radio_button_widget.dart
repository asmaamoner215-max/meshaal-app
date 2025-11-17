import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/app_theme/app_colors.dart';

import '../../../../core/app_theme/custom_themes.dart';

class LoginAsAVendorRadioButton extends StatefulWidget {
  const LoginAsAVendorRadioButton({super.key});

  @override
  State<LoginAsAVendorRadioButton> createState() =>
      _LoginAsAVendorRadioButtonState();
}

class _LoginAsAVendorRadioButtonState extends State<LoginAsAVendorRadioButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      onTap: () {
        _isSelected = !_isSelected;
        setState(() {});
      },
      titleAlignment: ListTileTitleAlignment.top,
      title: Text(
        " تسجل دخول كمسعف او شريك",
        textAlign: TextAlign.start,
        style: CustomThemes.greyColor49TextTheme(context).copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      horizontalTitleGap: 8.w,
      leading: Checkbox(
        shape: const CircleBorder(),
        value: _isSelected,
        side: const BorderSide(
          color: AppColors.primaryColor,
        ),
        onChanged: (value) {
          _isSelected = value!;
          setState(() {});
        },
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
      ),
    );
  }
}
