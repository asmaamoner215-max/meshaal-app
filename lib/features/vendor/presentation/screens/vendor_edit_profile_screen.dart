import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weam/core/parameters/auth_parameters/register_parameters.dart';
import 'package:weam/features/shared_widget/cached_network_image_widget.dart';
import 'package:weam/core/cache_helper/cache_keys.dart';
import 'package:weam/core/cache_helper/shared_pref_methods.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../core/constants/reg_exp.dart';
import '../../../../features/shared_widget/custom_elevated_button.dart';
import '../../../../features/shared_widget/custom_outlined_button.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../features/shared_widget/dialogs/delete_account_dialog.dart';

import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/constants/constants.dart';
import '../../../auth/buisness_logic/auth_cubit/auth_cubit.dart';
import '../../../auth/presentation/widgets/phone_text_field.dart';
import '../../../shared_widget/custom_app_bar.dart';
import '../../../shared_widget/custom_text_form_field.dart';

class VendorEditProfileScreen extends StatefulWidget {
  const VendorEditProfileScreen({super.key});

  @override
  State<VendorEditProfileScreen> createState() =>
      _VendorEditProfileScreenState();
}

class _VendorEditProfileScreenState extends State<VendorEditProfileScreen> {
  @override
  void initState() {
    super.initState();
    AuthCubit.get(context).getUserData();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController platController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? imagePath;
  File? file;
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    platController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "عنوان الصفحه",
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is GetUserDataSuccessState) {
            nameController = TextEditingController(
              text: state.getUserDatModel.data!.name,
            );
            phoneController = TextEditingController(
              text: state.getUserDatModel.data!.phone,
            );
            emailController = TextEditingController(
              text: state.getUserDatModel.data!.email,
            );
            platController = TextEditingController(
              text: state.getUserDatModel.data!.plateNum,
            );
            imagePath = state.getUserDatModel.data!.imageUrl;
          }
          if (state is GetPickedImageSuccessState) {
            file = state.pickedImage;
          }
          if (state is UpdateUserDataSuccessState) {
            file = null;
            AuthCubit.get(context).getUserData();
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return cubit.getUserDataLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.primaryColor,
                  ),
                )
              : ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 32.h,
                  ),
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          cubit.getImagePick();
                        },
                        borderRadius: BorderRadius.circular(100.r),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.greyColor49, width: 1.w),
                              ),
                              child: file == null
                                  ? CachedNetworkImageWidget(
                                      imagePath: imagePath!,
                                      errorWidget: SvgPicture.asset(
                                        SvgPath.user,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : Image.file(
                                      file!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SvgPicture.asset(
                              SvgPath.editProfile,
                              width: 32.w,
                              height: 32.h,
                            )
                          ],
                        ),
                      ),
                    ),
                    const CustomSizedBox(
                      height: 12,
                    ),
                    Text(
                      nameController.text.isNotEmpty
                          ? nameController.text
                          : "الاسم",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 18,
                    ),
                    Text(
                      "الاسم",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      hintText: "الاسم",
                      filled: true,
                      controller: nameController,
                      fillColor: AppColors.whiteColor,
                    ),
                    const CustomSizedBox(
                      height: 18,
                    ),
                    Text(
                      "البريد الاليكتروني",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      hintText: "البريد الالكتروني",
                      filled: true,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "برجاء ادخال البريد الالكتروني";
                        } else if (!RegularExp.emailRegex.hasMatch(value)) {
                          return "ادخل صيغة بريد صحيحة";
                        } else {
                          return null;
                        }
                      },
                      fillColor: AppColors.whiteColor,
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    Text(
                      "رقم الهاتف",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 8,
                    ),
                    PhoneTextField(
                      controller: phoneController,
                    ),
                    const CustomSizedBox(
                      height: 24,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        cubit.updateUserData(
                          registerParameters: RegisterParameters(
                            name: nameController.text,
                            phone: phoneController.text,
                            plateId: null,
                            deviceToken:
                                CacheHelper.getData(key: CacheKeys.fcmToken)
                                    as String?,
                            email: emailController.text,
                            password: null,
                            type: null,
                            image: file,
                          ),
                        );
                      },
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                      ),
                      text: "حفظ",
                      titleStyle:
                          CustomThemes.whiteColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    CustomOutlinedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => const DeleteAccountDialog());
                      },
                      backgroundColor: AppColors.whiteColor,
                      foregroundColor: AppColors.primaryColor,
                      borderRadius: 12,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                      ),
                      text: "حذف الحساب",
                      style:
                          CustomThemes.primaryColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
