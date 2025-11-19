import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/app_router/screens_name.dart';
import 'package:weam/core/cache_helper/cache_keys.dart';
import 'package:weam/core/cache_helper/shared_pref_methods.dart';
import 'package:weam/features/auth/buisness_logic/auth_cubit/auth_cubit.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../features/auth/presentation/widgets/auth_back_ground_widget.dart';
import '../../../../features/shared_widget/custom_elevated_button.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    AuthCubit.get(context).getAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return AuthBackgroundWidget(
          child: cubit.getAppSettingsLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView(
                  padding: EdgeInsets.only(top: 132.h, left: 16.w, right: 16.w),
                  children: [
                    Hero(
                      tag: "logoTag",
                      child: Material(
                        color: Colors.transparent,
                        child: Image.asset(
                          ImagesPath.logoWhiteColor,
                          width: 315.w,
                          height: 191.h,
                        ),
                      ),
                    ),
                    const CustomSizedBox(
                      height: 158,
                    ),
                    Text(
                      cubit.getAppSettingModel?.data?.introTitle ?? "",
                      textAlign: TextAlign.center,
                      style: CustomThemes.primaryColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    Text(
                      cubit.getAppSettingModel?.data?.introDesc ?? "",
                      textAlign: TextAlign.center,
                      style: CustomThemes.greyColor797TextTheme(context).copyWith(
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
                        CacheHelper.saveData(key: CacheKeys.welcome, value: "done");
                        Navigator.pushNamedAndRemoveUntil(
                            context, ScreenName.loginOrRegisterScreen, (route) => false);
                      },
                      text: "ابدء الان",
                      titleStyle: CustomThemes.whiteColorTextTheme(context)
                          .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400),
                      padding: EdgeInsets.symmetric(
                        vertical: 14.h,
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
