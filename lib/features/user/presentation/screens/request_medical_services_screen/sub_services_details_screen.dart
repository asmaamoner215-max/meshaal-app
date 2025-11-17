import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/features/user/presentation/widgets/medical_services_widget/doctor_details_widget.dart';

import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../shared_widget/cached_network_image_widget.dart';
import '../../../../shared_widget/custom_app_bar.dart';
import '../../../data/models/get_services_model.dart';
import '../../widgets/medical_services_widget/available_duration_widget.dart';

class SubServicesDetailsScreen extends StatelessWidget {
  final ServiceSubModel serviceSubModel;

  const SubServicesDetailsScreen({
    super.key,
    required this.serviceSubModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: CustomAppBar(
          title: serviceSubModel.specializationAr ?? "",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
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
            alignment: Alignment.center,
            child: Text(
              "البيانات",
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Center(
            child: Container(
                height: 132.h,
                width: 132.w,
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImageWidget(
                  imagePath: serviceSubModel.imageUrl ?? "",
                )),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            serviceSubModel.name ?? "",
            textAlign: TextAlign.center,
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          // const CustomSizedBox(
          //   height: 16,
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         padding: EdgeInsets.symmetric(
          //           vertical: 8.h,
          //         ),
          //         decoration: BoxDecoration(
          //           color: AppColors.primaryColor.withOpacity(.50),
          //           border: Border.all(
          //             color: AppColors.primaryColor,
          //             width: 1.w,
          //           ),
          //           borderRadius: BorderRadius.circular(
          //             16.r,
          //           ),
          //         ),
          //         alignment: Alignment.center,
          //         child: Text(
          //           "الرياض",
          //           style: CustomThemes.primaryColorTextTheme(context).copyWith(
          //             fontSize: 16.sp,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         ),
          //       ),
          //     ),
          //     const CustomSizedBox(
          //       width: 16,
          //     ),
          //     Expanded(
          //       child: Container(
          //         padding: EdgeInsets.symmetric(
          //           vertical: 8.h,
          //         ),
          //         decoration: BoxDecoration(
          //           border: Border.all(
          //             color: AppColors.primaryColor,
          //             width: 1.w,
          //           ),
          //           borderRadius: BorderRadius.circular(
          //             16.r,
          //           ),
          //         ),
          //         alignment: Alignment.center,
          //         child: Text(
          //           "جدة",
          //           style: CustomThemes.primaryColorTextTheme(context).copyWith(
          //             fontSize: 16.sp,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const CustomSizedBox(
            height: 16,
          ),
          DoctorDetailsWidget(
            serviceSubModel: serviceSubModel,
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Text(
            "مواعيد الحجز المتاحة",
            textAlign: TextAlign.center,
            style: CustomThemes.greyColor49TextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          AvailableDurationWidget(serviceSubModel: serviceSubModel),
          // const CustomSizedBox(
          //   height: 16,
          // ),
          // Visibility(
          //   visible: serviceSubModel.about != null,
          //   child: ExpansionWidget(
          //     title: "عن الدكتور",
          //     body: "${serviceSubModel.about}",
          //   ),
          // ),
          // Visibility(visible: serviceSubModel.experience!=null,child: ExpansionWidget(
          //   title: "الخبرة الأكاديمية والمهنية",
          //   body: "${serviceSubModel.experience}",
          // ),)
          // ,
          // Visibility(
          //   visible: serviceSubModel.subspecialties!=null,
          //   child: ExpansionWidget(
          //     title: "التخصصات الفرعية",
          //     body: "${serviceSubModel.subspecialties}",
          //   ),
          // ),
        ],
      ),
    );
  }
}
