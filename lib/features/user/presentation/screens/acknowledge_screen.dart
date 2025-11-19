import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/app_theme/custom_themes.dart';
import 'package:weam/features/shared_widget/custom_sizedbox.dart';

import '../../../../core/constants/constants.dart';
import '../../../auth/buisness_logic/auth_cubit/auth_cubit.dart';
import '../../../shared_widget/custom_app_bar.dart';

class AcknowledgeScreen extends StatefulWidget {
  const AcknowledgeScreen({super.key});

  @override
  State<AcknowledgeScreen> createState() => _AcknowledgeScreenState();
}

class _AcknowledgeScreenState extends State<AcknowledgeScreen> {
  @override
  void initState() {
    super.initState();
    AuthCubit.get(context).getAcknowledge();
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
            return Center(
              child: state is GetAcknowledgeLoadingState
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : state is GetAcknowledgeSuccessState
                      ? ListView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 32.h,
                          ),
                          children: [
                            Text(
                              "الاقرار",
                              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              ),
                            ),
                            const CustomSizedBox(
                              height: 24,
                            ),
                            Text(
                              state.data,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
            );
          }),
    );
  }
}
