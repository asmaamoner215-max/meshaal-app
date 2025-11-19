import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../features/user/buisness_logic/user_orders/user_orders_cubit.dart';
import '../../../../features/user/presentation/screens/profile_screen.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../core/constants/constants.dart';
import '../../../shared_widget/custom_app_bar.dart';
import '../../../shared_widget/custom_elevated_button.dart';
import '../../../shared_widget/custom_sizedbox.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  @override
  void initState() {
    UserOrdersCubit.get(context).getMyInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الفواتير",
        ),
      ),
      body: BlocConsumer<UserOrdersCubit, UserOrdersState>(
        listener: (context, state) {
          if (state is GetMyInvoicesErrorState) {
            showToast(errorType: 1, message: state.error);
          }
        },
        builder: (context, state) {
          UserOrdersCubit cubit = UserOrdersCubit.get(context);
          return cubit.getMyInvoicesLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.primaryColor,
                  ),
                )
              : cubit.baseErrorModel != null
                  ? Center(
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
                              cubit.getMyInvoices();
                            },
                            text: "إعادة المحاولة",
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: AppColors.whiteColor,
                          ),
                        ],
                      ),
                    )
              : (cubit.getMyInvoicesModel?.data?.isEmpty ?? true)
                  ? Center(
                      child: Text(
                        "لا توجد فواتير متاحة",
                        style: CustomThemes.greyColor49TextTheme(context).copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (_, index) {
                        return ProfileItemWidget(
                          title: cubit.getMyInvoicesModel?.data?[index].fatoraName ?? "",
                          assetPath: SvgPath.taskSquare,
                          onPressed: () {
                            Navigator.pushNamed(context, ScreenName.resetDetailsScreen,
                                arguments: cubit.getMyInvoicesModel!.data![index]);
                          },
                        );
                      },
                      itemCount: cubit.getMyInvoicesModel?.data?.length ?? 0,
                    );
        },
      ),
    );
  }
}
