import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/features/user/data/models/order_model.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/constants/constants.dart';
import '../../vendor/buisness_logic/vendor_orders_cubit/vendor_orders_cubit.dart';
import '../custom_sizedbox.dart';
import '../custom_text_form_field.dart';

import '../custom_elevated_button.dart';

class RatingDialog extends StatefulWidget {
  final void Function()? onPressed;
  final OrderModel? orderModel;
  const RatingDialog({super.key, this.onPressed, this.orderModel,});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  TextEditingController controller = TextEditingController();
  double rating = 0.0;
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
              "التقييم",
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
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                // itemSize: 28.r,
                ignoreGestures: false,
                itemCount: 5,
                itemSize: 16.sp,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: AppColors.primaryColor,
                ),
                onRatingUpdate: (rating) {
                  this.rating=rating;
                },
              ),
            ),
            const CustomSizedBox(
              height: 8,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "اضافة تعليق",
                style: CustomThemes.greyColor49TextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const CustomSizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.zero,
                      color: AppColors.shadowColor(opacityValue: 0.15),
                      blurRadius: 4.r,
                    )
                  ],),
              child: CustomTextField(
                hintText: "قم بكتابة تعليقك هنا",
                borderRadius: 12,
                filled: true,
                controller: controller,
                fillColor: AppColors.whiteColor,
                borderBorderColor: Colors.transparent,
                maxLines: 3,
              ),
            ),
            const CustomSizedBox(
              height: 16,
            ),
            BlocConsumer<VendorOrdersCubit, VendorOrdersState>(
  listener: (context, state) {
    if(state is RateUserLoadingState){
      showProgressIndicator(context);
    }else if(state is RateUserSuccessState){
      VendorOrdersCubit.get(context).providerOrders();
      Navigator.pushNamedAndRemoveUntil(context, ScreenName.vendorMainLayoutScreen, (route) => false,);
      showToast(errorType: 0, message: "تم ارسال التقييم");
    }else if(state is RateUserErrorState){
      Navigator.pop(context);
      showToast(errorType: 1, message: "حدث خطا");
    }
  },
  builder: (context, state) {
    VendorOrdersCubit cubit = VendorOrdersCubit.get(context);
    return CustomElevatedButton(
              text: "الخطوه التاليه",
              onPressed: widget.onPressed??() {
                cubit.rateUser(orderId: widget.orderModel!.id.toString(), comment: controller.text, rate: rating.toString());
                // Navigator.pushNamedAndRemoveUntil(context, ScreenName.userMainLayoutScreen, (route) => false);
              
              },
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              backgroundColor: AppColors.primaryColor,
              titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
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
