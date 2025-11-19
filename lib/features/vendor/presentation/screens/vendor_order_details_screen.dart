import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weam/core/app_router/screens_name.dart';
import 'package:weam/core/assets_path/svg_path.dart';
import 'package:weam/features/shared_widget/custom_sizedbox.dart';

import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../../../core/constants/constants.dart';
import '../../../shared_widget/custom_app_bar.dart';
import '../../../shared_widget/custom_elevated_button.dart';

class VendorOrderDetailsScreen extends StatelessWidget {
  const VendorOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "عنوان الصفحه",
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
                      Icons.check,
                      color: AppColors.primaryColor,
                      weight: 10.sp,
                      size: 16.r,
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Text(
                      "يعانى من معدية",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style:
                      CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: AppColors.primaryColor,
                      weight: 10.sp,
                      size: 16.r,
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Text(
                      "لديعة قسطرة بولية",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style:
                      CustomThemes.greyColor49TextTheme(context).copyWith(
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
                const DetailsContainer(
                  title: "الخدمة",
                  svgPath: SvgPath.plane,
                  body: "نقل طبى من / الى المطارات",
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                const DetailsContainer(
                  title: "اسم السائق",
                  svgPath: SvgPath.userName,
                  body: "محمد جمال",
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                const DetailsContainer(
                  title: "تاريخ الطب",
                  svgPath: SvgPath.date,
                  body: "17/3/2024 - السبت",
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                const DetailsContainer(
                  title: "وقت الطلب",
                  svgPath: SvgPath.clock,
                  body: "03:00AM",
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                const DetailsContainer(
                  title: "عنوان الالتقاء",
                  svgPath: SvgPath.location,
                  body: "مكة - المملكة العربية السعودية",
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                const DetailsContainer(
                  title: "عنوان التنزيل",
                  svgPath: SvgPath.destination,
                  body: "مكة - المملكة العربية السعودية",
                ),
              ],
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          CustomElevatedButton(
            text: "استمرار",
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.startOrderScreen);
            },
            padding: EdgeInsets.symmetric(vertical: 16.h),
            backgroundColor: AppColors.primaryColor,
            titleStyle:
            CustomThemes.whiteColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
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
        ),
      ],
    );
  }
}
