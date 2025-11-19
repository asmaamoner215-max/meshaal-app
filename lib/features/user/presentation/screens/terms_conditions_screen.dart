import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/app_theme/custom_themes.dart';
import 'package:weam/features/shared_widget/custom_sizedbox.dart';
import 'package:weam/core/app_theme/app_colors.dart';
import 'package:weam/features/shared_widget/custom_elevated_button.dart';

import '../../../../core/constants/constants.dart';
import '../../../auth/buisness_logic/auth_cubit/auth_cubit.dart';
import '../../../shared_widget/custom_app_bar.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  void initState() {
    super.initState();
    AuthCubit.get(context).getAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الشروط و الاحكام",
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is GetSettingsErrorState) {
              showToast(errorType: 1, message: state.error);
            }
          },
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            // Loading
            if (cubit.getAppSettingsLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            // Error state: show retry
            if (cubit.baseErrorModel != null &&
                (cubit.getAppSettingModel?.data?.termsUser == null)) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cubit.baseErrorModel?.message ?? "حدث خطأ في جلب البيانات",
                      textAlign: TextAlign.center,
                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    const CustomSizedBox(height: 16),
                    CustomElevatedButton(
                      onPressed: () {
                        cubit.baseErrorModel = null;
                        cubit.getAppSettings();
                      },
                      text: "إعادة المحاولة",
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                    ),
                  ],
                ),
              );
            }

            // Empty state
            if (cubit.getAppSettingModel?.data?.termsUser == null ||
                (cubit.getAppSettingModel!.data!.termsUser!.isEmpty)) {
              return Center(
                child: Text(
                  "لا توجد شروط وأحكام متاحة",
                  style: CustomThemes.greyColor49TextTheme(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              );
            }

            // Content
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 32.h,
              ),
              children: [
                Text(
                  "الشروط و الاحكام",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                const CustomSizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Text(
                        cubit.getAppSettingModel?.data?.termsUser?[index].desc ?? '',
                        style: CustomThemes.greyColor49TextTheme(context).copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  },
                  itemCount: cubit.getAppSettingModel?.data?.termsUser?.length ?? 0,
                )
              ],
            );
          }),
    );
  }
}
