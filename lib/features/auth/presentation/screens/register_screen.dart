import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/enums/user_type_enum.dart';
import '../../../../core/parameters/auth_parameters/register_parameters.dart';
import '../../../../features/auth/presentation/screens/otp_screen.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/reg_exp.dart';
import '../../../../features/shared_widget/custom_text_form_field.dart';
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  bool _isSelected = false;
  late AnimationController animationController;
  late Animation<double> animation;

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController plateNumber = TextEditingController();
  TextEditingController idNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundWidget(
      child: SafeArea(
        child: Form(
          key: formKey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is RegisterLoadingState) {
                showProgressIndicator(context);
              } else if (state is RegisterSuccessState) {
                Navigator.pop(context);
                showToast(
                  errorType: 0,
                  message: state.registerModel?.message ?? "",
                ).then((value) {
                  if (state.registerModel != null && context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      ScreenName.otpScreen,
                      (route) => false,
                      arguments: OtpArguments(
                        phone: state.registerModel?.phone ?? "",
                        code: state.registerModel?.code ?? 0000,
                        isForgetPassword: false,
                      ),
                    );
                  }
                });
              } else if (state is RegisterErrorState) {
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
                padding: EdgeInsets.only(
                  top: 88.h,
                  left: 16.w,
                  right: 16.w,
                  bottom: 16.h,
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
                    "انشاء حساب",
                    textAlign: TextAlign.center,
                    style: CustomThemes.whiteColorTextTheme(context).copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const CustomSizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    hintText: "الاسم",
                    filled: true,
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "برجاء ادخال الاسم";
                      } else {
                        return null;
                      }
                    },
                    fillColor: AppColors.whiteColor,
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: "البريد الالكتروني",
                    filled: true,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "برجاء ادخال البريد الالكتروني";
                      } else if (!RegularExp.emailRegex.hasMatch(value)) {
                        return "ادخل صيغة بريد صحيحة";
                      } else {
                        return null;
                      }
                    },
                    fillColor: AppColors.whiteColor,
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  PhoneTextField(
                    controller: phoneController,
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  SizeTransition(
                    sizeFactor: animation,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: "رقم لوحة السيارة",
                          filled: true,
                          controller: plateNumber,
                          validator: _isSelected
                              ? (value) {
                                  if (value!.isEmpty) {
                                    return "برجاء ادخال رقم لوحة السيارة";
                                  } else {
                                    return null;
                                  }
                                }
                              : null,
                          fillColor: AppColors.whiteColor,
                        ),
                        const CustomSizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  PasswordTextField(
                    controller: passwordController,
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  PasswordTextField(
                    hintText: "التحقق من كلمة المرور",
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
                    height: 16,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    onTap: () {
                      if (_isSelected) {
                        animationController.reverse();
                      } else {
                        animationController.forward();
                      }
                      _isSelected = !_isSelected;
                      setState(() {});
                    },
                    titleAlignment: ListTileTitleAlignment.top,
                    title: Text(
                      " انشاء حساب كمسعف او شريك",
                      textAlign: TextAlign.start,
                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    horizontalTitleGap: 8.w,
                    leading: Checkbox(
                      shape: const CircleBorder(),
                      value: _isSelected,
                      activeColor: AppColors.primaryColor,
                      side: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                      onChanged: (value) {
                        print(value);
                        _isSelected = value!;
                        if (!_isSelected) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                        setState(() {});
                      },
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                    ),
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: "رقم الهوية",
                    controller: idNumber,
                    maxLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "برجاء ادخال البيانات";
                      }
                      return null;
                    },
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  CustomElevatedButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.register(
                          registerParameters: RegisterParameters(
                            name: nameController.text,
                            phone: phoneController.text,
                            plateId: _isSelected ? plateNumber.text : null,
                            deviceToken: null,
                            email: emailController.text,
                            password: passwordController.text,
                            idNumber: idNumber.text,
                            type:
                                _isSelected ? UserTypeEnum.provider.name : UserTypeEnum.client.name,
                          ),
                        );
                      }
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
                  //       "او انشاء حساب بواسطة",
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
                      Navigator.pushNamedAndRemoveUntil(
                          context, ScreenName.loginScreen, (route) => false);
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "هل لديك حساب ؟ ",
                          style: CustomThemes.greyColor49TextTheme(context).copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "تسجيل الدخول",
                              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
