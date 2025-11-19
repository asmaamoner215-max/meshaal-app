import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/constants/constants.dart';
import 'package:weam/features/user/data/models/order_model.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../user/presentation/screens/road_progress_screen.dart';
import '../../vendor/buisness_logic/vendor_orders_cubit/vendor_orders_cubit.dart';
import '../custom_elevated_button.dart';
import '../custom_sizedbox.dart';

class TimeDialog extends StatefulWidget {
  final void Function()? onPressed;
  final OrderModel? orderModel;

  const TimeDialog({super.key, this.onPressed, this.orderModel});

  @override
  State<TimeDialog> createState() => _TimeDialogState();
}

class _TimeDialogState extends State<TimeDialog> {
  late Duration duration;
  Timer? _timer;

  late TimeOfDay timeOfDay;

  @override
  void initState() {
    super.initState();
    duration = Duration(
      minutes: DateTime.now()
          .difference(DateTime.parse(widget.orderModel!.updatedAt.toString()))
          .inMinutes,
    );
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        duration = duration + const Duration(seconds: 60);
      });
      print(duration);
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "وقت الانتظار",
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Divider(
              endIndent: 81.w,
              indent: 81.w,
            ),
            const CustomSizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimerContainer(
                    number: formatDuration(duration)
                        .split(":")
                        .last
                        .substring(1, 2)),
                const CustomSizedBox(
                  width: 16,
                ),
                TimerContainer(
                    number: formatDuration(duration)
                        .split(":")
                        .last
                        .substring(0, 1)),
                const CustomSizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 12.h,
                      width: 12.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    const CustomSizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 12.h,
                      width: 12.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    )
                  ],
                ),
                const CustomSizedBox(
                  width: 8,
                ),
                TimerContainer(
                    number: formatDuration(duration)
                        .split(":")
                        .first
                        .substring(1, 2)),
                const CustomSizedBox(
                  width: 16,
                ),
                TimerContainer(
                    number: formatDuration(duration)
                        .split(":")
                        .first
                        .substring(0, 1)),
              ],
            ),
            const CustomSizedBox(
              height: 16,
            ),
            BlocConsumer<VendorOrdersCubit, VendorOrdersState>(
              listener: (context, state) {
                if(state is WaitMinutesLoadingState){
                  showProgressIndicator(context);
                }else if(state is WaitMinutesSuccessState){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  showToast(errorType: 0, message: "تم ارسال توقيت الانتظار");
                }else if(state is WaitMinutesErrorState){
                  Navigator.pop(context);
                  showToast(errorType: 1, message: "حدث خطا");
                }
              },
              builder: (context, state) {
                VendorOrdersCubit cubit = VendorOrdersCubit.get(context);
                return CustomElevatedButton(
                  text: "الخطوه التاليه",
                  onPressed: widget.onPressed ??
                      () {
                        cubit.waitMinutes(
                          minutes: duration.inMinutes.toString(),
                          orderId: widget.orderModel!.id.toString(),
                        );
                      },
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  backgroundColor: AppColors.primaryColor,
                  titleStyle:
                      CustomThemes.whiteColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
