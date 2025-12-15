import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_router/screens_name.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';
import '../../buisness_logic/user_services_cubit/user_requests_cubit.dart';
import 'choose_direction_screen.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          children: [
            const CustomSizedBox(
              height: 46,
            ),
            Center(
              child: Image.asset(
                ImagesPath.mashaalPrimaryLogo,
                width: 180.w,
                height: 121.h,
              ),
            ),
            const CustomSizedBox(
              height: 16,
            ),
            ServicesTypeContainer(
              imagePath: ImagesPath.ambulanceReal,
              title: 'طلب سيارة اسعاف',
              onTap: () {
                UserRequestsCubit.get(context).handleSentParameters();

                Navigator.pushNamed(
                  context,
                  ScreenName.chooseDirectionsScreen,
                  arguments: ChooseDirectionScreenArguments(
                    buttonTitle: "استكمال الطلب",
                    buttonPressed: () {
                      Navigator.pushNamed(context, ScreenName.completeRequestAmbScreen);
                    },
                  ),
                );
              },
            ),
            const CustomSizedBox(
              height: 16,
            ),
            ServicesTypeContainer(
              imagePath: ImagesPath.doctors,
              title: 'خدمات طبية منزلية',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ScreenName.medicalServicesScreen,
                );
              },
            ),
            const CustomSizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class ServicesTypeContainer extends StatelessWidget {
  final String imagePath;
  final String title;
  final void Function()? onTap;
  const ServicesTypeContainer({
    super.key,
    required this.imagePath,
    required this.title,
    this.onTap,
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
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
                offset: Offset.zero,
                blurRadius: 4.r,
                color: AppColors.shadowColor(opacityValue: .15))
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: AppColors.whiteColor,
                alignment: Alignment.center,
                child: Image.asset(
                  imagePath,
                ),
              ),
            ),
            Container(
              color: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
              ),
              alignment: Alignment.center,
              child: Text(
                title,
                style: CustomThemes.whiteColorTextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
