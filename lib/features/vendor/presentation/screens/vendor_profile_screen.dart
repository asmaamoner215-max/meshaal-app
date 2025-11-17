import 'package:flutter/material.dart';
import 'package:weam/core/assets_path/svg_path.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../core/cache_helper/shared_pref_methods.dart';
import '../../../../core/constants/constants.dart';
import '../../../shared_widget/custom_app_bar.dart';
import '../../../user/presentation/screens/profile_screen.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

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
        children: [
          ProfileItemWidget(
            title: "الحساب الشخصى",
            assetPath: SvgPath.user,
            onPressed: () {

              Navigator.pushNamed(context, ScreenName.vendorEditProfileScreen,);
            },
          ),
          ProfileItemWidget(
            title: "الشرو ط و الاحكام",
            assetPath: SvgPath.terms,
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.termsAndConditionsScreen);},
          ),

          ProfileItemWidget(
            title: "تسجيل الخروج",
            assetPath: SvgPath.logout,
            onPressed: () {
              CacheHelper.clearAllData().then((value) {
                Navigator.pushNamedAndRemoveUntil(context,
                    ScreenName.loginOrRegisterScreen, (route) => false);
              });
            },
          )
        ],
      ),
    );
  }
}
