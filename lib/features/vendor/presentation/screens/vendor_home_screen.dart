import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weam/core/app_router/screens_name.dart';
import 'package:weam/core/constants/extensions.dart';
import 'package:weam/features/vendor/buisness_logic/vendor_orders_cubit/vendor_orders_cubit.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../core/enums/order_status_enum.dart';
import '../../../shared_widget/cached_network_image_widget.dart';
import '../../../shared_widget/custom_elevated_button.dart';
import '../../../shared_widget/custom_outlined_button.dart';
import '../../../shared_widget/custom_sizedbox.dart';
import '../../../user/data/models/order_model.dart';
import '../../../user/presentation/screens/reset_details_screen.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  int isSelected = 0;

  @override
  void initState() {
    super.initState();
    VendorOrdersCubit.get(context).providerOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<VendorOrdersCubit, VendorOrdersState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            VendorOrdersCubit cubit = VendorOrdersCubit.get(context);
            return cubit.getMyTravelsLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: AppColors.primaryColor,
                    ),
                  )
                : Column(
                    children: [
                      const CustomSizedBox(
                        height: 64,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TabBarButton(
                              isSelected: isSelected == 0,
                              title: "الرحلات الحالية",
                              onPressed: () {
                                if (isSelected != 0) {
                                  setState(() {
                                    isSelected = 0;
                                  });
                                }
                              },
                            ),
                          ),
                          const CustomSizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TabBarButton(
                              isSelected: isSelected == 1,
                              title: "الرحلات السابقة",
                              onPressed: () {
                                if (isSelected != 1) {
                                  setState(() {
                                    isSelected = 1;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ).symmetricPadding(horizontal: 30),
                      const CustomSizedBox(
                        height: 32,
                      ),
                      if (isSelected == 0)
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              cubit.providerOrders();
                            },
                            child: ListView.separated(
                              itemBuilder: (_, index) => OrderContainerWidget(
                                orderModel: cubit.getMyTravelsModel?.data?[index],
                                buttonTitle: cubit.getMyTravelsModel?.data?[index].status !=
                                        OrderStatusEnum.wait.name
                                    ? "متابعه"
                                    : 'التفاصيل',
                                onPressed: () {
                                  if (cubit.getMyTravelsModel?.data?[index].status !=
                                      OrderStatusEnum.wait.name) {
                                    cubit.getOrderData(
                                        orderId:
                                            cubit.getMyTravelsModel!.data![index].id.toString());
                                  }

                                  cubit.getMyTravelsModel?.data?[index].status ==
                                          OrderStatusEnum.wait.name
                                      ? Navigator.pushNamed(
                                          context,
                                          ScreenName.orderDetailsScreen,
                                          arguments: cubit.getMyTravelsModel?.data?[index],
                                        )
                                      : Navigator.pushNamed(
                                          context,
                                          ScreenName.vendorOrderScreen,
                                        );
                                },
                              ),
                              separatorBuilder: (_, index) => const CustomSizedBox(
                                height: 16,
                              ),
                              itemCount: cubit.getMyTravelsModel?.data?.length ?? 0,
                            ),
                          ),
                        ),
                      if (isSelected == 1)
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              cubit.providerOrders();
                            },
                            child: ListView.separated(
                              itemBuilder: (_, index) => FinishedOrderContainerWidget(
                                orderModel: cubit.getMyTravelsModel?.previous?[index],
                              ),
                              separatorBuilder: (_, index) => const CustomSizedBox(
                                height: 16,
                              ),
                              itemCount: cubit.getMyTravelsModel?.previous?.length ?? 0,
                            ),
                          ),
                        ),
                    ],
                  );
          },
        ),
      ).symmetricPadding(horizontal: 16),
    );
  }
}

class OrderContainerWidget extends StatelessWidget {
  final String buttonTitle;
  final void Function()? onPressed;
  final OrderModel? orderModel;

  const OrderContainerWidget({
    super.key,
    required this.buttonTitle,
    this.onPressed,
    this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColors.greyColorF6,
        borderRadius: BorderRadius.circular(
          20.r,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 80.h,
                width: 80.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CachedNetworkImageWidget(
                  fit: BoxFit.cover,
                  imagePath: orderModel?.clientData?.image ?? "",
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
                      "اسم العميل",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: CustomThemes.primaryColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      orderModel?.clientData?.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      orderModel?.toAddres ?? "",
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
              )
            ],
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            orderModel?.fatoraName ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          TitleBodyHorizontalText(
            title: "الوجهة",
            body: orderModel?.toAddres ?? "",
          ),
          const CustomSizedBox(
            height: 8,
          ),
          TitleBodyHorizontalText(title: "الوقت", body: orderModel?.orderTime ?? ""),
          const CustomSizedBox(
            height: 16,
          ),
          CustomElevatedButton(
            text: buttonTitle,
            onPressed: onPressed,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            backgroundColor: AppColors.primaryColor,
            titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class FinishedOrderContainerWidget extends StatelessWidget {
  final OrderModel? orderModel;

  const FinishedOrderContainerWidget({
    super.key,
    this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColors.greyColorF6,
        borderRadius: BorderRadius.circular(
          20.r,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 80.h,
                  width: 80.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: CachedNetworkImageWidget(
                    fit: BoxFit.cover,
                    imagePath: orderModel?.clientData?.image ?? "",
                    errorWidget: SvgPicture.asset(
                      SvgPath.user,
                      fit: BoxFit.cover,
                    ),
                  )),
              const CustomSizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اسم العميل",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: CustomThemes.primaryColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      orderModel?.clientData?.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      orderModel?.toAddres ?? "",
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
              )
            ],
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            orderModel?.fatoraName ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          TitleBodyHorizontalText(
            title: "الوجهة",
            body: orderModel?.toAddres ?? "",
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            orderModel?.orderDate ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: CustomThemes.greyColor49TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarButton extends StatelessWidget {
  final bool isSelected;
  final String title;
  final void Function()? onPressed;

  const TabBarButton({
    super.key,
    required this.isSelected,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? CustomElevatedButton(
            onPressed: onPressed,
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.whiteColor,
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
            ),
            text: title,
            titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          )
        : CustomOutlinedButton(
            onPressed: onPressed,
            backgroundColor: AppColors.whiteColor,
            foregroundColor: AppColors.primaryColor,
            borderRadius: 12,
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
            ),
            text: title,
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          );
  }
}
