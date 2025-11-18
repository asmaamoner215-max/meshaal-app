import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../../shared_widget/custom_sizedbox.dart';
import '../../../../shared_widget/custom_text_form_field.dart';

class WalletComponent extends StatelessWidget {
  final TextEditingController? controller;
  final bool isCodeSent;
  const WalletComponent({super.key,  this.controller, required this.isCodeSent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:isCodeSent?[

      ]: [
        Divider(
          color: AppColors.greyColorD3,
          thickness: 1.w,
        ),
        Text(
          "بيانات المحفظة الالكترونية",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: CustomThemes.primaryColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const CustomSizedBox(
          height: 16,
        ),
        CustomTextField(
          hintText: "رقم التليفون",
          filled: true,
          controller: controller,
          fillColor: AppColors.whiteColor,
        ),
      ],
    );
  }
}
