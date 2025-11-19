import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/app_theme/app_colors.dart';
import '../../core/app_theme/custom_themes.dart';
import '../../core/assets_path/svg_path.dart';
import 'cached_network_image_widget.dart';
import 'custom_sizedbox.dart';

class RequestsPersonDetailsContainerWidget extends StatelessWidget {
  final bool appearContact;
  final String? name;
  final String? contactTitle;
  final String? image;
  final String? title;
  const RequestsPersonDetailsContainerWidget(
      {super.key, this.appearContact = true, this.name, this.title, this.image, this.contactTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 4.r,
            color: AppColors.shadowColor(opacityValue: 0.15),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 80.h,
            width: 80.w,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: CachedNetworkImageWidget(
              imagePath: image ?? "",
              errorWidget: SvgPicture.asset(
                SvgPath.user,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const CustomSizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "اسم السائق",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  name ?? "محمد احمد محمد",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: CustomThemes.greyColor49TextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (appearContact)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          contactTitle ?? "للتواصل مع السائق",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: CustomThemes.greyColor49TextTheme(context).copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgPath.whatsapp,
                            width: 20.w,
                            height: 20.h,
                          ),
                          const CustomSizedBox(
                            width: 16,
                          ),
                          SvgPicture.asset(
                            SvgPath.callCalling,
                            width: 20.w,
                            height: 20.h,
                          ),
                        ],
                      )
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
