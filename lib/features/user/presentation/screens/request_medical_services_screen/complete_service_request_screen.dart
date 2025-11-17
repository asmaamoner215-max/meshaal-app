import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weam/core/app_router/screens_name.dart';
import 'package:weam/features/user/presentation/screens/payment_medical_services_screen.dart';

import '../../../../../core/assets_path/svg_path.dart';
import '../../../../../core/enums/sex_enum.dart';
import '../../../../../core/enums/yes_no_enum.dart';
import '../../../../../features/shared_widget/custom_drop_down_button.dart';
import '../../../../../features/shared_widget/custom_app_bar.dart';
import '../../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../../features/shared_widget/custom_text_form_field.dart';
import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../shared_widget/custom_elevated_button.dart';
import '../../../../shared_widget/custom_outlined_button.dart';
import '../../../../shared_widget/select_button_with_title.dart';
import '../../../buisness_logic/user_services_cubit/user_requests_cubit.dart';

class CompleteServiceRequestArgs {
  final String totalPrice;
  final String price;
  final String description;
  final String seId;
  final String subSeId;

  CompleteServiceRequestArgs({
    required this.totalPrice,
    required this.price,
    required this.description,
    required this.seId,
    required this.subSeId,
  });
}

class CompleteServiceRequestScreen extends StatefulWidget {
  final CompleteServiceRequestArgs completeServiceRequestArgs;
  const CompleteServiceRequestScreen({super.key, required this.completeServiceRequestArgs});

  @override
  State<CompleteServiceRequestScreen> createState() => _CompleteServiceRequestScreenState();
}

class _CompleteServiceRequestScreenState extends State<CompleteServiceRequestScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "عنوان الصفحه",
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
                const CustomSizedBox(
                  height: 16,
                ),
                const Divider(),
                const CustomSizedBox(
                  height: 16,
                ),
                Text(
                  "هل المريض يعانى من اى امراض معدية ؟",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: CustomThemes.greyColor49TextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const CustomSizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SelectButtonWithTitle(
                        isSelected: cubit.infectiousDiseases == YesNoEnum.yes,
                        onPressed: () {
                          cubit.infectiousDiseases = YesNoEnum.yes;
                          setState(() {});
                        },
                        title: 'نعم',
                      ),
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SelectButtonWithTitle(
                        isSelected: cubit.infectiousDiseases == YesNoEnum.no,
                        onPressed: () {
                          cubit.infectiousDiseases = YesNoEnum.no;
                          setState(() {});
                        },
                        title: 'لا',
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                CustomElevatedButton(
                  text: "متابعه",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ScreenName.paymentMedicalServicesScreen,
                      arguments: PaymentMedicalServicesArgs(
                        totalPrice: widget.completeServiceRequestArgs.totalPrice,
                        price: widget.completeServiceRequestArgs.price,
                        description: widget.completeServiceRequestArgs.description,
                        servicesId: widget.completeServiceRequestArgs.seId,
                        subServicesId: widget.completeServiceRequestArgs.subSeId,
                      ),
                    );
                  },
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
