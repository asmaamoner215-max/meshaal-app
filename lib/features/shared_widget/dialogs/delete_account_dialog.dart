import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../custom_outlined_button.dart';
import '../custom_sizedbox.dart';

import '../custom_elevated_button.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      surfaceTintColor: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 32.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "حذف الحساب",
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Divider(
              endIndent: 81.w,
              indent: 81.w,
            ),
            const CustomSizedBox(
              height: 16,
            ),
            Text(
              "هل أنت متأكد من حذف حسابك؟",
              style: CustomThemes.greyColor49TextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const CustomSizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {},
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                    ),
                    text: "حذف ",
                    titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const CustomSizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CustomOutlinedButton(
                    onPressed: () {},
                    backgroundColor: AppColors.whiteColor,
                    foregroundColor: AppColors.primaryColor,
                    borderRadius: 12,
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                    ),
                    text: "الغاء",
                    style: CustomThemes.primaryColorTextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
