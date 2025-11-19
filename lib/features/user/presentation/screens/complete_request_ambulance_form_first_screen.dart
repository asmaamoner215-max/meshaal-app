import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weam/core/app_router/screens_name.dart';
import 'package:weam/core/enums/sex_enum.dart';
import 'package:weam/features/shared_widget/custom_outlined_button.dart';
import 'package:weam/features/user/buisness_logic/user_services_cubit/user_requests_cubit.dart';

import 'package:jiffy/jiffy.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../features/shared_widget/custom_drop_down_button.dart';
import '../../../../features/shared_widget/custom_app_bar.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../features/shared_widget/custom_text_form_field.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/constants/constants.dart';
import '../../../shared_widget/custom_elevated_button.dart';
import '../../../shared_widget/select_button_with_title.dart';

class CompleteRequestAmbulanceFormScreen extends StatefulWidget {
  const CompleteRequestAmbulanceFormScreen({super.key});

  @override
  State<CompleteRequestAmbulanceFormScreen> createState() =>
      _CompleteRequestAmbulanceFormScreenState();
}

class _CompleteRequestAmbulanceFormScreenState extends State<CompleteRequestAmbulanceFormScreen> {
  var formKey = GlobalKey<FormState>();
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    UserRequestsCubit.get(context).getNationality();
    UserRequestsCubit.get(context).getRelationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "استكمال الطلب",
        ),
      ),
      body: BlocConsumer<UserRequestsCubit, UserRequestsState>(
        listener: (context, state) {},
        builder: (context, state) {
          UserRequestsCubit cubit = UserRequestsCubit.get(context);
          return Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 11.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset.zero,
                        blurRadius: 4.r,
                        color: AppColors.shadowColor(opacityValue: 0.15),
                      )
                    ],
                  ),
                  child: Text(
                    "لاستكمال الطلب يرجى ملئ هذة البيانات",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: CustomThemes.whiteColorTextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                CustomTextField(
                  hintText: "اسم المريض",
                  maxLines: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "برجاء ادخال البيانات";
                    }
                    return null;
                  },
                  controller: cubit.patientNameController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SelectButtonWithTitle(
                        isSelected: cubit.sexEnum.name == SexEnum.male.name,
                        onPressed: () {
                          cubit.sexEnum = SexEnum.male;
                          setState(() {});
                        },
                        title: 'ذكر',
                      ),
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SelectButtonWithTitle(
                        isSelected: cubit.sexEnum.name == SexEnum.female.name,
                        onPressed: () {
                          cubit.sexEnum = SexEnum.female;
                          setState(() {});
                        },
                        title: 'انثى',
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        borderColor: AppColors.greyColorD3,
                        borderRadius: 10,
                        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: cubit.orderDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(
                                days: 365,
                              ),
                            ),
                          ).then((value) {
                            cubit.orderDate = value;
                            setState(() {});
                          });
                        },
                        foregroundColor: AppColors.primaryColor,
                        child: Row(
                          children: [
                            Expanded(
                              child: cubit.orderDate == null
                                  ? Text(
                                      "التاريخ",
                                      style: CustomThemes.greyColorC6TextTheme(context).copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : Text(
                                      Jiffy.parse(cubit.orderDate!.toString())
                                          .format(pattern: 'yyyy/MM/dd'),
                                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ),
                            SvgPicture.asset(
                              SvgPath.arrowDown,
                              width: 24.w,
                              height: 24.h,
                            )
                          ],
                        ),
                      ),
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: CustomOutlinedButton(
                        borderColor: AppColors.greyColorD3,
                        borderRadius: 10,
                        foregroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                        onPressed: () {
                          showTimePicker(
                                  context: context,
                                  initialTime:
                                      cubit.orderTime ?? const TimeOfDay(hour: 1, minute: 0))
                              .then((value) {
                            cubit.orderTime = value;
                            setState(() {});
                          });
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: cubit.orderTime == null
                                  ? Text(
                                      "الوقت",
                                      style: CustomThemes.greyColorC6TextTheme(context).copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : Text(
                                      cubit.orderTime != null
                                          ? "${cubit.orderTime?.format(context)}"
                                          : "",
                                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ),
                            SvgPicture.asset(
                              SvgPath.arrowDown,
                              width: 24.w,
                              height: 24.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                CustomDropDownButton(
                  items: cubit.nationalList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ))
                      .toList(),
                  value: cubit.nationality,
                  borderRadius: 10,
                  hintText: "الجنسية",
                  onChanged: (value) {
                    setState(() {
                      cubit.nationality = value;
                    });
                  },
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                if (cubit.getRelationLoading)
                  const Center(child: CircularProgressIndicator.adaptive()),
                if (!cubit.getRelationLoading)
                  CustomDropDownButton(
                    items: cubit.relationList
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name),
                            ))
                        .toList(),
                    value: cubit.selectedRelation,
                    borderRadius: 10,
                    hintText: "صلة القرابه",
                    onChanged: (value) {
                      setState(() {
                        cubit.selectedRelation = value;
                      });
                    },
                  ),
                const CustomSizedBox(
                  height: 16,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  titleAlignment: ListTileTitleAlignment.top,
                  title: RichText(
                    text: TextSpan(
                      text: "أوافق على",
                      children: [
                        TextSpan(
                          text: " الإقرار ",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, ScreenName.acknowledgmentScreen);
                            },
                          children: [
                            TextSpan(
                              text: "بصحة البيانات ",
                              children: const [],
                              style: CustomThemes.greyColor49TextTheme(context).copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                          style: CustomThemes.primaryColorTextTheme(context).copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 8.w,
                  leading: Checkbox(
                    // shape: const CircleBorder(),
                    value: isSelected,
                    activeColor: AppColors.primaryColor,
                    side: const BorderSide(
                      color: AppColors.primaryColor,
                    ),
                    onChanged: (value) {
                      print(value);
                      isSelected = value!;

                      setState(() {});
                    },
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                  ),
                ),
                CustomElevatedButton(
                  text: "متابعه",
                  onPressed: isSelected
                      ? () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.orderDate != null && cubit.orderTime != null) {
                              if (cubit.nationality != null) {
                                if (cubit.selectedRelation != null) {
                                  Navigator.pushNamed(
                                    context,
                                    ScreenName.patientRequestAmbScreen,
                                  );
                                } else {
                                  showToast(errorType: 1, message: "برجاء اختيار صلة القرابة");
                                }
                              } else {
                                showToast(errorType: 1, message: "برجاء اختيار الجنسية");
                              }
                            } else {
                              showToast(errorType: 1, message: "برجاء اختيار الوقت والتاريخ");
                            }
                          }
                        }
                      : null,
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
        },
      ),
    );
  }
}
