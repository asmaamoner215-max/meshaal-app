import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/constants/constants.dart';
import 'package:weam/core/enums/user_type_enum.dart';
import 'package:weam/core/parameters/auth_parameters/login_parameters.dart';
import '../../../../core/app_router/screens_name.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../features/auth/presentation/widgets/auth_back_ground_widget.dart';
import '../../../../features/auth/presentation/widgets/phone_text_field.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../shared_widget/custom_elevated_button.dart';
import '../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../widgets/password_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundWidget(
      child: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
              showProgressIndicator(context);
            } else if (state is LoginSuccessState) {
              Navigator.pop(context); // Close loading dialog
              if (state.loginDataModel?.status == true) {
                showToast(
                  errorType: 0,
                  message: state.loginDataModel?.message ?? "تسجيل دخول ناجح",
                );
                // Store data before async gap
                final userType = state.loginDataModel?.data?.type;
                final navigator = Navigator.of(context);
                // Navigate after a short delay
                Future.delayed(const Duration(milliseconds: 500), () async {
                  if (!mounted) return;
                  if (userType != null) {
                    final routeName = userType == UserTypeEnum.client.name
                        ? ScreenName.userMainLayoutScreen
                        : ScreenName.vendorMainLayoutScreen;
                    navigator.pushNamedAndRemoveUntil(
                        routeName,
                        (route) => false);
                  }
                });
              } else {
                showToast(
                  errorType: 1,
                  message: state.loginDataModel?.message ?? "فشل تسجيل الدخول",
                );
              }
            } else if (state is LoginErrorState) {
              Navigator.pop(context);
              showToast(
                errorType: 1,
                message: state.error,
              );
            } else if (state is LoginSuccessWithWrongCredState) {
              Navigator.pop(context);
              showToast(
                errorType: 1,
                message: state.baseErrorModel?.message ?? "",
              );
            }
          },
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            return Form(
              key: formKey,
              child: ListView(
                padding: EdgeInsets.only(top: 88.h, left: 16.w, right: 16.w),
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
                    "تسجيل الدخول",
                    textAlign: TextAlign.center,
                    style: CustomThemes.whiteColorTextTheme(context).copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const CustomSizedBox(
                    height: 24,
                  ),
                  PhoneTextField(
                    controller: phoneController,
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  PasswordTextField(
                    controller: passwordController,
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ScreenName.forgetPasswordScreen,
                      );
                    },
                    child: Text(
                      "هل نسيت كلمة السر ؟",
                      textAlign: TextAlign.end,
                      style: CustomThemes.greyColor797TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // const CustomSizedBox(
                  //   height: 16,
                  // ),
                  // const LoginAsAVendorRadioButton(),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  CustomElevatedButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.login(
                          loginParameters: LoginParameters(
                            mobileNumber: phoneController.text,
                            password: passwordController.text,
                          ),
                        );
                      }
                      // Navigator.pushNamedAndRemoveUntil(context, ScreenName.userMainLayoutScreen,(route)=>false);
                    },
                    text: "تسجيل الدخول",
                    titleStyle: CustomThemes.whiteColorTextTheme(context)
                        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400),
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                    ),
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  // Row(
                  //   children: [
                  //     const Expanded(
                  //       child: Divider(
                  //         color: AppColors.primaryColor,
                  //       ),
                  //     ),
                  //     const CustomSizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       "او تسجيل الدخول بواسطة",
                  //       textAlign: TextAlign.end,
                  //       style: CustomThemes.greyColor797TextTheme(context)
                  //           .copyWith(
                  //         fontSize: 16.sp,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //     const CustomSizedBox(
                  //       width: 10,
                  //     ),
                  //     const Expanded(
                  //       child: Divider(
                  //         color: AppColors.primaryColor,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // const CustomSizedBox(
                  //   height: 16,
                  // ),
                  // const SocialButtonsWidget(),
                  // const CustomSizedBox(
                  //   height: 16,
                  // ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ScreenName.registerScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "ليس لديك حساب ؟ ",
                          style: CustomThemes.greyColor49TextTheme(context).copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "انشاء حساب",
                              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
