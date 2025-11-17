import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../../shared_widget/custom_sizedbox.dart';
import '../../../../shared_widget/custom_text_form_field.dart';

class CardComponent extends StatelessWidget {
  const CardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: AppColors.greyColorD3,
          thickness: 1.w,
        ),
        const CustomSizedBox(
          height: 16,
        ),
        Text(
          "بيانات بطاقة الائتمان",
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
        const CustomTextField(
          hintText: "رقم البطاقة",
          filled: true,
          fillColor: AppColors.whiteColor,
        ),
        const CustomSizedBox(
          height: 16,
        ),
        const CustomTextField(
          hintText: "اسم البطاقة",
          filled: true,
          fillColor: AppColors.whiteColor,
        ),
        const CustomSizedBox(
          height: 16,
        ),
        const Row(
          children: [
            Expanded(
              child: CustomTextField(
                hintText: "تاريخ الانتهاء",
                filled: true,
                fillColor: AppColors.whiteColor,
              ),
            ),
            CustomSizedBox(
              width: 16,
            ),
            Expanded(
              child: CustomTextField(
                hintText: "CVV",
                filled: true,
                fillColor: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
