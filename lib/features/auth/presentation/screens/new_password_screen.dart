import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_router/screens_name.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../features/auth/presentation/widgets/auth_back_ground_widget.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../shared_widget/custom_elevated_button.dart';
import '../widgets/password_text_field.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundWidget(
      child: ListView(
        padding: EdgeInsets.only(
          top: 132.h,
          left: 16.w,
          right: 16.w,
        ),
        children: [
          Image.asset(
            ImagesPath.logoWhiteColor,
            height: 108.h,
            width: 163.w,
          ),
          const CustomSizedBox(
            height: 32,
          ),
          Text(
            "كلمة المرور الجديدة",
            textAlign: TextAlign.center,
            style: CustomThemes.whiteColorTextTheme(context).copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const CustomSizedBox(
            height: 32,
          ),
          const PasswordTextField(
            hintText: "ادخال كلمة المرور الجديدة",
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            "يجب أن تكون على الأقل 8 أحرف",
            textAlign: TextAlign.start,
            style: CustomThemes.greyColor49TextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const CustomSizedBox(
            height: 24,
          ),
          const PasswordTextField(
            hintText: "اعادة ادخال كلمة المرور الجديدة",
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            "يجب أن تتطابق كلمة المرور",
            textAlign: TextAlign.start,
            style: CustomThemes.greyColor49TextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const CustomSizedBox(
            height: 32,
          ),
          CustomElevatedButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {

              Navigator.pushNamedAndRemoveUntil(context, ScreenName.userMainLayoutScreen,(route)=>false);
            },
            text: "حفظ",
            titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 14.h,
            ),
          ),
        ],
      ),
    );
  }
}
