import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/app_router/screens_name.dart';
import 'package:weam/features/user/presentation/screens/request_medical_services_screen/complete_service_request_screen.dart';

import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../data/models/get_services_model.dart';

class AvailableDurationWidget extends StatelessWidget {
  final ServiceSubModel serviceSubModel;

  const AvailableDurationWidget({super.key, required this.serviceSubModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 32.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(
          16.r,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1.2.w,
              ),
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.primaryColor,
            ),
            alignment: Alignment.center,
            child: Text(
              "اليوم",
              textAlign: TextAlign.center,
              style: CustomThemes.greyColor49TextTheme(context).copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              serviceSubModel.fromTime != null
                  ? "من ${TimeOfDay(hour: int.parse(serviceSubModel.fromTime!.split(":").first), minute: int.parse(serviceSubModel.fromTime!.split(":").last)).format(context)}   إلي ${TimeOfDay(hour: int.parse(serviceSubModel.toTime!.split(":").first), minute: int.parse(serviceSubModel.toTime!.split(":").last)).format(context)}"
                  : "لم يتم التحديد",
              textAlign: TextAlign.center,
              style: CustomThemes.greyColor49TextTheme(context).copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                ScreenName.startRequestScreen,
                arguments: CompleteServiceRequestArgs(
                    totalPrice: serviceSubModel.price.toString(),
                    price: serviceSubModel.price.toString(),
                    description: serviceSubModel.subspecialtiesAr?.toString() ??
                        serviceSubModel.name.toString(),
                    seId: serviceSubModel.serviceId.toString(),
                    subSeId: serviceSubModel.id.toString()),
              );
              // Navigator.pushNamed(
              //   context,
              //   ScreenName.paymentMedicalServicesScreen,
              //   arguments: PaymentMedicalServicesArgs(
              //     totalPrice: serviceSubModel.price ?? "",
              //     price: serviceSubModel.price ?? "",
              //     description: serviceSubModel.specialization ?? "",
              //   ),
              // );
            },
            child: Ink(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 16.h,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1.2.w,
                ),
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.reserveRedColor,
              ),
              child: Text(
                "أحجز",
                textAlign: TextAlign.center,
                style: CustomThemes.whiteColorTextTheme(context).copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
