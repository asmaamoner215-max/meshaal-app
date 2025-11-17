import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/app_theme/custom_themes.dart';
import 'package:weam/features/shared_widget/custom_sizedbox.dart';

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
          listener: (context, state) {},
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            return Center(
              child: cubit.getAppSettingsLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : ListView(
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
                        const CustomSizedBox(
                          height: 24,
                        ),
                        if (cubit.getAppSettingModel?.data?.termsUser != null)
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Text(
                                cubit.getAppSettingModel?.data?.termsUser?[index].desc ?? '',
                              );
                            },
                            itemCount: cubit.getAppSettingModel?.data?.termsUser?.length ?? 0,
                          )
                      ],
                    ),
            );
          }),
    );
  }
}
