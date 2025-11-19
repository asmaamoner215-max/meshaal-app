import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weam/core/assets_path/svg_path.dart';
import 'package:weam/features/shared_widget/custom_sizedbox.dart';
import 'package:weam/features/user/data/models/order_model.dart';

import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/enums/yes_no_enum.dart';
import '../../../../shared_widget/custom_app_bar.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel? orderModel;
  const OrderDetailsScreen({
    super.key,
    this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "تفاصيل الطلب",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 32.h,
        ),
        children: [
          Container(
            padding: EdgeInsets.all(16.sp),
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
                  "حالة المريض",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: CustomThemes.greyColor49TextTheme(context).copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const CustomSizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Icon(
                      orderModel?.infectiousDiseases == YesNoEnum.no.name
                          ? Icons.clear
                          : Icons.check,
                      color: orderModel?.infectiousDiseases == YesNoEnum.no.name
                          ? AppColors.redColor
                          : AppColors.primaryColor,
                      weight: 10.sp,
                      size: 16.r,
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Text(
                      "يعانى من امراض معدية",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      orderModel?.urinaryCatheter == YesNoEnum.no.name ? Icons.clear : Icons.check,
                      color: orderModel?.urinaryCatheter == YesNoEnum.no.name
                          ? AppColors.redColor
                          : AppColors.primaryColor,
                      weight: 10.sp,
                      size: 16.r,
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Text(
                      "لديه قسطرة بولية",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      orderModel?.needsOxygen == YesNoEnum.no.name ? Icons.clear : Icons.check,
                      color: orderModel?.needsOxygen == YesNoEnum.no.name
                          ? AppColors.redColor
                          : AppColors.primaryColor,
                      weight: 10.sp,
                      size: 16.r,
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Text(
                      "هل يحتاج الي اكسجين",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const CustomSizedBox(
            height: 24,
          ),
          Container(
            padding: EdgeInsets.all(16.sp),
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
                  "تفاصيل المريض",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: CustomThemes.greyColor49TextTheme(context).copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const CustomSizedBox(
                  height: 24,
                ),
                DetailsContainer(
                  title: "الخدمة",
                  svgPath: SvgPath.plane,
                  body: orderModel?.fatoraName ?? "",
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                DetailsContainer(
                    title: "اسم السائق",
                    svgPath: SvgPath.userName,
                    body: orderModel?.driverName ?? ""),
                const CustomSizedBox(
                  height: 16,
                ),
                DetailsContainer(
                  title: "تاريخ الطب",
                  svgPath: SvgPath.date,
                  body: orderModel?.orderDate ?? "",
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                DetailsContainer(
                    title: "وقت الطلب", svgPath: SvgPath.clock, body: orderModel?.orderTime ?? ""),
                const CustomSizedBox(
                  height: 16,
                ),
                DetailsContainer(
                    title: "عنوان الالتقاء",
                    svgPath: SvgPath.location,
                    body: orderModel?.formAddres ?? ""),
                const CustomSizedBox(
                  height: 16,
                ),
                DetailsContainer(
                    title: "عنوان التنزيل",
                    svgPath: SvgPath.destination,
                    body: orderModel?.toAddres ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsContainer extends StatelessWidget {
  final String title;
  final String svgPath;
  final String body;

  const DetailsContainer({
    super.key,
    required this.title,
    required this.svgPath,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: CustomThemes.primaryColorTextTheme(context).copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        const CustomSizedBox(
          height: 8,
        ),
        Row(
          children: [
            SvgPicture.asset(
              svgPath,
              width: 24.w,
              height: 24.h,
            ),
            const CustomSizedBox(
              width: 8,
            ),
            Text(
              body,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: CustomThemes.greyColor49TextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ],
    );
  }
}
