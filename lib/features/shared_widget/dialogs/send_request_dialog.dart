import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../custom_elevated_button.dart';
import '../custom_outlined_button.dart';
import '../custom_sizedbox.dart';

class AcceptRequestDialogDialog extends StatelessWidget {
  final void Function()? onPressed;
  const AcceptRequestDialogDialog({super.key, this.onPressed});

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
              "طلب زيارة منزلية",
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
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "لقد تم قبول طلبك و سيقوم دكتور مصطفى احمد بالزيارة المنزلية",
                style: CustomThemes.greyColor49TextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const CustomSizedBox(
              height: 8,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "التكلفة : 150 ريـال",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const CustomSizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ScreenName.doctorArrivesScreen);
                    },
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                    ),
                    text: "موافقة ",
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColors.whiteColor,
                    foregroundColor: AppColors.primaryColor,
                    borderRadius: 12,
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                    ),
                    text: "رفض",
                    style: CustomThemes.primaryColorTextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
