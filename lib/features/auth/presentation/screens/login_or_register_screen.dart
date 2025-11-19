import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_router/screens_name.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../features/auth/presentation/widgets/auth_back_ground_widget.dart';
import '../../../../features/shared_widget/custom_elevated_button.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';

class LoginOrRegisterScreen extends StatelessWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundWidget(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 88.h, left: 16.w, right: 16.w),
          children: [
            Image.asset(
              ImagesPath.logoWhiteColor,
              width: 315.w,
              height: 191.h,
            ),
            const CustomSizedBox(
              height: 158,
            ),
            CustomElevatedButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ScreenName.loginScreen,
                );
              },
              text: "تسجيل دخول",
              titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 14.h,
              ),
            ),
            const CustomSizedBox(
              height: 32,
            ),
            CustomElevatedButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ScreenName.registerScreen,
                );
              },
              text: "انشاء حساب",
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
      ),
    );
  }
}
