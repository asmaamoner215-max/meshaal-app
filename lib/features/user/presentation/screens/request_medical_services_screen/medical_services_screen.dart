import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/features/user/presentation/screens/request_medical_services_screen/sub_services_screen.dart';

import '../../../../../core/app_router/screens_name.dart';
import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../../features/user/buisness_logic/services_cubit/services_cubit.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../shared_widget/cached_network_image_widget.dart';
import '../../../../shared_widget/custom_app_bar.dart';
import '../../../data/models/get_services_model.dart';

class MedicalServicesScreen extends StatefulWidget {
  const MedicalServicesScreen({super.key});

  @override
  State<MedicalServicesScreen> createState() => _MedicalServicesScreenState();
}

class _MedicalServicesScreenState extends State<MedicalServicesScreen> {
  @override
  void initState() {
    ServicesCubit.get(context).getServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الخدمات الطبية",
        ),
      ),
      body: BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {
          if (state is GetServicesErrorState) {
            showToast(errorType: 1, message: state.error);
          }
        },
        builder: (context, state) {
          ServicesCubit cubit = ServicesCubit.get(context);
          return cubit.getServicesLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.primaryColor,
                  ),
                )
              : (cubit.getServicesModel?.data?.isEmpty ?? true)
                  ? const Center(
                      child: Text("لا توجد خدمات متاحة"),
                    )
                  : ListView(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
                      children: [
                        const CustomSizedBox(
                          height: 64,
                        ),
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 159 / 176,
                            mainAxisSpacing: 19.h,
                            crossAxisSpacing: 17.w,
                          ),
                          itemCount: cubit.getServicesModel?.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) => ServicesContainer(
                            serviceDataModel: cubit.getServicesModel!.data![index],
                          ),
                        ),
                      ],
                    );
        },
      ),
    );
  }
}

class ServicesContainer extends StatelessWidget {
  final ServiceDataModel serviceDataModel;

  const ServicesContainer({
    super.key,
    required this.serviceDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ScreenName.subServicesScreen,
          arguments: SubServicesArgs(
            list: serviceDataModel.subs ?? [],
            appBarTitle: serviceDataModel.title,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1.w,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImageWidget(
              imagePath: "${serviceDataModel.imageUrl}",
              width: 104.w,
              height: 104.h,
            ),
            const CustomSizedBox(
              height: 8,
            ),
            Text(
              serviceDataModel.title ?? "",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomThemes.greyColor49TextTheme(context).copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
