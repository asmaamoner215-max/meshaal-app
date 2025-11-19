import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/constants/constants.dart';
import 'package:weam/core/enums/user_type_enum.dart';
import 'package:weam/core/parameters/auth_parameters/login_parameters.dart';
import 'package:weam/core/cache_helper/cache_keys.dart';
import 'package:weam/core/cache_helper/shared_pref_methods.dart';
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
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() {
    final savedRemember = CacheHelper.getBoolean(key: CacheKeys.rememberMe) ?? false;
    if (savedRemember) {
      final savedPhone = CacheHelper.getData(key: CacheKeys.savedLoginPhone) as String?;
      final savedPassword = CacheHelper.getData(key: CacheKeys.savedLoginPassword) as String?;
      if (savedPhone != null) phoneController.text = savedPhone;
      if (savedPassword != null) passwordController.text = savedPassword;
      rememberMe = true;
    }
  }

  Future<void> _persistCredentials() async {
    if (rememberMe) {
      await CacheHelper.saveData(key: CacheKeys.rememberMe, value: true);
      await CacheHelper.saveData(key: CacheKeys.savedLoginPhone, value: phoneController.text);
      await CacheHelper.saveData(key: CacheKeys.savedLoginPassword, value: passwordController.text);
    } else {
      await CacheHelper.saveData(key: CacheKeys.rememberMe, value: false);
      await CacheHelper.removeData(key: CacheKeys.savedLoginPhone);
      await CacheHelper.removeData(key: CacheKeys.savedLoginPassword);
    }
  }

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
                // Navigate immediately without delay
                if (mounted && state.loginDataModel?.data?.type != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      state.loginDataModel!.data!.type == UserTypeEnum.client.name
                          ? ScreenName.userMainLayoutScreen
                          : ScreenName.vendorMainLayoutScreen,
                      (route) => false);
                }
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
                  // Remember Me Checkbox
                  Row(
                    children: [
                      SizedBox(
                        height: 20.w,
                        width: 20.w,
                        child: Checkbox(
                          value: rememberMe,
                          activeColor: AppColors.primaryColor,
                          onChanged: (val) {
                            setState(() {
                              rememberMe = val ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'حفظ بيانات تسجيل الدخول',
                          style: CustomThemes.greyColor797TextTheme(context).copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            rememberMe = !rememberMe;
                          });
                        },
                        child: Text(
                          rememberMe ? 'إلغاء الحفظ' : 'حفظ',
                          style: CustomThemes.primaryColorTextTheme(context).copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const CustomSizedBox(height: 12),
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
                      print(phoneController);
                      print(passwordController);
                      if (formKey.currentState!.validate()) {
                        _persistCredentials();
                        cubit.login(
                          loginParameters: LoginParameters(
                              deviceToken: CacheHelper.getData(key: CacheKeys.fcmToken) as String?,
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
