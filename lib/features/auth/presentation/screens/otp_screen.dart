import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/features/auth/buisness_logic/auth_cubit/auth_cubit.dart';
import '../../../../core/app_router/screens_name.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../core/constants/constants.dart';
import '../../../../features/auth/presentation/widgets/auth_back_ground_widget.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../shared_widget/custom_elevated_button.dart';
import '../widgets/password_text_field.dart';
import '../widgets/pin_field_builder.dart';

class OtpArguments extends Equatable {
  final String phone;
  final int code;
  final int? userId;
  final bool isForgetPassword;

  const OtpArguments({
    required this.phone,
    required this.code,
    required this.isForgetPassword,
    this.userId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        phone,
        code,
      ];
}

class OtpScreen extends StatefulWidget {
  final OtpArguments otpArguments;

  const OtpScreen({super.key, required this.otpArguments});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String obscurePhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 3) {
      return phoneNumber;
    }

    int lengthToObscure = phoneNumber.length - 3;
    String stars = '*' * lengthToObscure;
    String lastThreeDigits = phoneNumber.substring(lengthToObscure);

    return stars + lastThreeDigits;
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AuthBackgroundWidget(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ChangeForgetPasswordLoadingState) {
            showProgressIndicator(context);
          } else if (state is ChangeForgetPasswordSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              ScreenName.loginScreen,
              (route) => false,
            );
          } else if (state is ChangeForgetPasswordErrorState) {
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
                "رمز التحقق",
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
                " لقد أرسلنا لك الرمز المكون من 4 أرقام إلى ${obscurePhoneNumber(widget.otpArguments.phone)} أدخل الرمز أدناه للتحقق من رقم الهاتف ",
                textAlign: TextAlign.start,
                style: CustomThemes.greyColor49TextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const CustomSizedBox(
                height: 24,
              ),
              PinFieldBuilder(
                controller:
                    TextEditingController(text: "${widget.otpArguments.code}"),
              ),
              const CustomSizedBox(
                height: 16,
              ),
              if (widget.otpArguments.isForgetPassword)
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      PasswordTextField(
                        controller: passwordController,
                        hintText: "ادخال كلمة المرور الجديدة",
                      ),
                      const CustomSizedBox(
                        height: 16,
                      ),
                      PasswordTextField(
                        hintText: "اعادة ادخال كلمة المرور الجديدة",
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "برجاء ادخال تآكيد";
                          } else if (value != passwordController.text) {
                            return "كلمتان المرور غير متطابقتان";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const CustomSizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              const CustomSizedBox(
                height: 16,
              ),
              CustomElevatedButton(
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  print( passwordController.text);
                  print( widget.otpArguments.userId.toString());
                  if (!widget.otpArguments.isForgetPassword) {
                    showProgressIndicator(context);
                    Timer(const Duration(seconds: 2), () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, ScreenName.loginScreen, (route) => false);
                      showToast(
                        errorType: 0,
                        message: "تم التأكيد بنجاح قم بالتسجيل",
                      );
                    });
                  } else {
                    if(formKey.currentState!.validate()){
                      cubit.changeForgetPassword(
                        password: passwordController.text,
                        userId: widget.otpArguments.userId.toString(),
                      );
                    }
                  }
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
