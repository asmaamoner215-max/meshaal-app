import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/app_router/screens_name.dart';
import 'package:weam/features/auth/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:weam/features/auth/presentation/screens/otp_screen.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../core/constants/constants.dart';
import '../../../../features/auth/presentation/widgets/auth_back_ground_widget.dart';
import '../../../../features/auth/presentation/widgets/phone_text_field.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../shared_widget/custom_elevated_button.dart';

class ForgetPasswordScreenScreen extends StatefulWidget {
  const ForgetPasswordScreenScreen({super.key});

  @override
  State<ForgetPasswordScreenScreen> createState() =>
      _ForgetPasswordScreenScreenState();
}

class _ForgetPasswordScreenScreenState
    extends State<ForgetPasswordScreenScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundWidget(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is CheckForgetPasswordLoadingState) {
            showProgressIndicator(context);
          } else if (state is CheckForgetPasswordSuccessState) {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              ScreenName.otpScreen,
              arguments: OtpArguments(
                phone: textEditingController.text,
                code: state.forgetPasswordModel.code,
                userId: state.forgetPasswordModel.data,
                isForgetPassword: true,
              ),
            );
          } else if (state is CheckForgetPasswordErrorState) {
            Navigator.pop(context);
            showToast(
              errorType: 1,
              message: state.error,
            );
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return ListView(
            padding: EdgeInsets.only(top: 132.h, left: 16.w, right: 16.w),
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
                "إعادة تعيين كلمة المرور",
                textAlign: TextAlign.center,
                style: CustomThemes.whiteColorTextTheme(context).copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const CustomSizedBox(
                height: 32,
              ),
              Text(
                "أدخل رقم الهاتف المرتبط بحسابك وسنرسل رسالة تحتوي على رمز التحقق  لإعادة  ضبط كلمه السر",
                textAlign: TextAlign.start,
                style: CustomThemes.greyColor49TextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const CustomSizedBox(
                height: 24,
              ),
              PhoneTextField(
                controller: textEditingController,
              ),
              const CustomSizedBox(
                height: 16,
              ),
              CustomElevatedButton(
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  cubit.checkForget(phoneNumber: textEditingController.text);
                },
                text: "ارسال",
                titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 14.h,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
