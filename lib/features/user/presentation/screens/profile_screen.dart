import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weam/core/app_theme/app_colors.dart';
import 'package:weam/core/assets_path/svg_path.dart';
import 'package:weam/core/cache_helper/shared_pref_methods.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/constants/constants.dart';
import '../../../shared_widget/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "حسابي",
        ),
      ),
      body: ListView(
        children: [
          ProfileItemWidget(
            title: "الحساب الشخصي",
            assetPath: SvgPath.user,
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.editUserProfile);
            },
          ),
          ProfileItemWidget(
            title: "الفواتير",
            assetPath: SvgPath.taskSquare,
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.resetScreen);
            },
          ),
          ProfileItemWidget(
            title: "الشروط و الاحكام",
            assetPath: SvgPath.terms,
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.termsAndConditionsScreen);
            },
          ),
          ProfileItemWidget(
            title: "إقرار وتعهد بنقل المريض",
            assetPath: SvgPath.terms,
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.patientTransferAcknowledgementScreen);
            },
          ),
          ProfileItemWidget(
            title: "رحلاتي",
            assetPath: SvgPath.orders,
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.userOrdersScreen);
            },
          ),
          ProfileItemWidget(
            title: "تسجيل الخروج",
            assetPath: SvgPath.logout,
            onPressed: () {
              CacheHelper.clearAllData().then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, ScreenName.loginOrRegisterScreen, (route) => false);
              });
            },
          )
        ],
      ),
    );
  }
}

class ProfileItemWidget extends StatelessWidget {
  final String title;
  final String assetPath;
  final void Function()? onPressed;

  const ProfileItemWidget({
    super.key,
    required this.title,
    required this.assetPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      horizontalTitleGap: 8.w,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      leading: SvgPicture.asset(
        assetPath,
        colorFilter: const ColorFilter.mode(
          AppColors.greyColor49,
          BlendMode.srcIn,
        ),
        width: 24.w,
        height: 24.h,
      ),
      trailing: SvgPicture.asset(
        SvgPath.arrowRight,
        width: 24.w,
        height: 24.h,
      ),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: CustomThemes.greyColor49TextTheme(context).copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
