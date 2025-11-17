import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';
import '../../../features/auth/presentation/widgets/pin_field_builder.dart';
import '../../user/buisness_logic/user_services_cubit/user_requests_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../custom_elevated_button.dart';
import '../custom_sizedbox.dart';

class PayWithOtpSMSDialog extends StatelessWidget {
  final void Function()? onPressed;
  final String id;
  final String code;

  const PayWithOtpSMSDialog(
      {super.key, this.onPressed, required this.id, required this.code,});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      surfaceTintColor: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 32.h,
        ),
        child: BlocConsumer<UserRequestsCubit, UserRequestsState>(
          listener: (context, state) {
            if (state is PayWithWalletSMSLoadingState) {
              showProgressIndicator(context);
            } else if (state is PayWithWalletSMSSuccessState) {
              Navigator.pushNamedAndRemoveUntil(context, ScreenName.userMainLayoutScreen, (route)=>false,);
              UserRequestsCubit.get(context).handleSentParameters();
              showToast(
                errorType: 0,
                message: "تم الدفع بنجاح",
              );
            }else if(state is PayWithWalletSMSSuccessState){
              Navigator.pop(context);
              showToast(
                errorType: 1,
                message: state.baseResponseModel?.message??"حدث خطا",
              );
            }
          },
          builder: (context, state) {
            UserRequestsCubit cubit = UserRequestsCubit.get(context);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "تم ارسال الرمز",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const CustomSizedBox(
                  height: 8,
                ),
                Divider(
                  endIndent: 81.w,
                  indent: 81.w,
                ),
                const CustomSizedBox(
                  height: 8,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "برجاء ادخال الرمز",
                    style: CustomThemes.greyColor49TextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                PinFieldBuilder(
                  controller: TextEditingController(text: code),
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    cubit.payWithWalletSMS(
                      orderId: id,
                      orderSMSCode: code,
                    );
                  },
                  width: double.infinity,
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.whiteColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                  ),
                  text: "تاكيد الدفع",
                  titleStyle:
                      CustomThemes.whiteColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
