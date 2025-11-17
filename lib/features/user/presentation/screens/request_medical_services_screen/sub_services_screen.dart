import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/app_router/screens_name.dart';

import '../../../../../features/shared_widget/cached_network_image_widget.dart';
import '../../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../shared_widget/custom_app_bar.dart';
import '../../../data/models/get_services_model.dart';

class SubServicesArgs {
  final List<ServiceSubModel>? list;
  final String? appBarTitle;

  SubServicesArgs({
    required this.list,
    required this.appBarTitle,
  });
}

class SubServicesScreen extends StatelessWidget {
  final SubServicesArgs args;

  const SubServicesScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: CustomAppBar(
          title: args.appBarTitle ?? "",
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (_, index) => const CustomSizedBox(
          height: 16,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 32.h,
        ),
        itemBuilder: (_, index) => ServicesTypeContainer(
          serviceSubModel: args.list![index],
        ),
        itemCount: args.list!.length,
      ),
    );
  }
}

class ServicesTypeContainer extends StatelessWidget {
  final ServiceSubModel serviceSubModel;
  final void Function()? onTap;

  const ServicesTypeContainer({
    super.key,
    this.onTap,
    required this.serviceSubModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: 230.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset.zero,
              blurRadius: 4.r,
              color: AppColors.shadowColor(
                opacityValue: .15,
              ),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.servicesUpperSubContainerColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4.h),
                      blurRadius: 4.r,
                      color: AppColors.shadowColor(
                        opacityValue: .25,
                      ),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          serviceSubModel.name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomThemes.whiteColorTextTheme(context).copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 116.h,
                      width: 116.w,
                      clipBehavior: Clip.antiAlias,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImageWidget(
                        imagePath: serviceSubModel.imageUrl ?? "",
                        // fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, ScreenName.subServicesDetailsScreen,
                    arguments: serviceSubModel);
              },
              child: Container(
                color: AppColors.servicesLowerSubContainerColor,
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                ),
                alignment: Alignment.center,
                child: Text(
                  "التفاصيل",
                  style: CustomThemes.whiteColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
