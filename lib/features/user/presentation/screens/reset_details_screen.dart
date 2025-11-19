import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../features/user/data/models/order_model.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/constants/constants.dart';
import '../../../shared_widget/custom_app_bar.dart';
import '../widgets/payment_widgets/payment_summary_widget.dart';

class ResetDetailsScreen extends StatelessWidget {
  final OrderModel orderModel;
  const ResetDetailsScreen({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "عنوان الصفحههه",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        children: [
          Text(
            orderModel.fatoraName ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Text(
            orderModel.orderDate ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: CustomThemes.greyColor49TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          TitleBodyHorizontalText(title: "الوجهة", body: orderModel.toAddresName ?? ""),
          const CustomSizedBox(
            height: 16,
          ),
          TitleBodyHorizontalText(title: "الوقت", body: orderModel.orderTime ?? ""),
          const CustomSizedBox(
            height: 16,
          ),
          TitleBodyHorizontalText(title: "اسم السائق", body: orderModel.driverName ?? ""),
          const CustomSizedBox(
            height: 16,
          ),
          TitleBodyHorizontalText(title: "اسم المريض", body: orderModel.patientName ?? ""),
          const CustomSizedBox(
            height: 16,
          ),
          Divider(
            color: AppColors.greyColorD3,
            thickness: 1.w,
          ),
          const CustomSizedBox(
            height: 16,
          ),
          PaymentSummaryWidget(
            title: orderModel.trip ?? "",
            price: orderModel.price ?? "",
          ),
          const CustomSizedBox(
            height: 16,
          ),
          PaymentSummaryWidget(
            title: "خدمة وجود طبيب",
            price: orderModel.doctorPrice ?? "",
          ),
          const CustomSizedBox(
            height: 16,
          ),
          PaymentSummaryWidget(
            title: "ضريبة",
            price: orderModel.taxTotal ?? "",
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Divider(
            color: AppColors.greyColorD3,
            thickness: 1.w,
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "الاجمالى",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${orderModel.total ?? ""} ريال",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

class TitleBodyHorizontalText extends StatelessWidget {
  final String title;
  final String body;
  const TitleBodyHorizontalText({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title : ",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: CustomThemes.primaryColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          body,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: CustomThemes.greyColor49TextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
