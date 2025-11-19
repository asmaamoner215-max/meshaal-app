import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weam/features/user/data/models/get_services_model.dart';

import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/assets_path/svg_path.dart';
import '../../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../../core/app_theme/custom_themes.dart';

class DoctorDetailsWidget extends StatelessWidget {
  final ServiceSubModel serviceSubModel;
  const DoctorDetailsWidget({super.key, required this.serviceSubModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 24.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.greyColorF6,
        borderRadius: BorderRadius.circular(
          20.r,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الاسم",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            serviceSubModel.nameAr ?? "",
            style: CustomThemes.greyColor49TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            serviceSubModel.specialization ?? "",
            style: CustomThemes.greyColor49TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          DetailsRow(
            svgPath: SvgPath.fee,
            title: "سعر الخدمة/",
            body: "${serviceSubModel.price} ريال",
          ),
          // const CustomSizedBox(
          //   height: 8,
          // ),
          // const DetailsRow(
          //   svgPath: SvgPath.time,
          //   title: "مدة الأنتظار/ ",
          //   body: "20 دقيقة",
          // ),
          // const CustomSizedBox(
          //   height: 8,
          // ),
          // const DetailsRow(
          //   svgPath: SvgPath.subLocation,
          //   title: "الرياض/ ",
          //   body: "مملكة العربية السعودية",
          // ),
        ],
      ),
    );
  }
}

class DetailsRow extends StatelessWidget {
  final String svgPath;
  final String title;
  final String body;

  const DetailsRow({
    super.key,
    required this.svgPath,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          svgPath,
          height: 16.h,
          width: 16.w,
        ),
        const CustomSizedBox(
          width: 8,
        ),
        Text(
          title,
          style: CustomThemes.primaryColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          body,
          style: CustomThemes.greyColor49TextTheme(context).copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
