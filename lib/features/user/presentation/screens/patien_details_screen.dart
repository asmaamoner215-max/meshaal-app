import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weam/core/enums/floor_enum.dart';
import 'package:weam/core/enums/needs_enum.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../features/user/buisness_logic/user_services_cubit/user_requests_cubit.dart';
import '../../../../core/enums/yes_no_enum.dart';
import '../../../../features/shared_widget/custom_app_bar.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../features/shared_widget/custom_text_form_field.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/constants/constants.dart';
import '../../../shared_widget/custom_elevated_button.dart';
import '../../../shared_widget/select_button_with_title.dart';

class RequestAmbPatientScreenScreen extends StatefulWidget {
  const RequestAmbPatientScreenScreen({super.key});

  @override
  State<RequestAmbPatientScreenScreen> createState() => _RequestAmbPatientScreenScreenState();
}

class _RequestAmbPatientScreenScreenState extends State<RequestAmbPatientScreenScreen> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "تفاصيل المريض",
        ),
      ),
      body: BlocConsumer<UserRequestsCubit, UserRequestsState>(
        listener: (context, state) {
          if (state is GetPickedImageSuccessState) {
            UserRequestsCubit.get(context).bookingFile = state.image;
          }
        },
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
                ),
                Text(
                  " ادخال وزن المريض ؟",
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
                CustomTextField(
                  hintText: "وزن المريض",
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "برجاء ادخال البيانات";
                    }
                    return null;
                  },
                  controller: cubit.patientWeightController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                Text(
                  "هل المريض يعانى من اى امراض معدية او مزمنة؟",
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
                Text(
                  "هل المريض بحاجة الى اكسجين اثناء التنقل ؟",
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
                        isSelected: cubit.needOxygen == YesNoEnum.yes,
                        onPressed: () {
                          cubit.needOxygen = YesNoEnum.yes;
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
                        isSelected: cubit.needOxygen == YesNoEnum.no,
                        onPressed: () {
                          cubit.needOxygen = YesNoEnum.no;
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
                Text(
                  "هل المريض لدية قسطرة بولية ؟",
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
                        isSelected: cubit.urinaryCatheter == YesNoEnum.yes,
                        onPressed: () {
                          cubit.urinaryCatheter = YesNoEnum.yes;
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
                        isSelected: cubit.urinaryCatheter == YesNoEnum.no,
                        onPressed: () {
                          cubit.urinaryCatheter = YesNoEnum.no;
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
                Text(
                  "يرجي ارفاق تقرير طبي او تذكرة طيران في حالة السفر",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: CustomThemes.greyColor49TextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "هل المريض لدية حجز طيران مؤكد ؟",
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
                SelectButtonWithTitle(
                  isSelected: cubit.bookingFlight == YesNoEnum.yes,
                  onPressed: () {
                    cubit.bookingFlight = YesNoEnum.yes;
                    cubit.getImagePick();
                    setState(() {});
                  },
                  title: 'نعم / ارفاق صورة التذكرة',
                ),
                const CustomSizedBox(
                  height: 8,
                ),
                SelectButtonWithTitle(
                  isSelected: cubit.bookingFlight == YesNoEnum.no,
                  onPressed: () {
                    cubit.bookingFlight = YesNoEnum.no;
                    cubit.bookingFile = null;
                    setState(() {});
                  },
                  title: 'لا',
                ),
                if (cubit.bookingFile != null)
                  const CustomSizedBox(
                    height: 16,
                  ),
                if (cubit.bookingFile != null)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      height: 80.h,
                      width: 72.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Image.file(
                        cubit.bookingFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const CustomSizedBox(
                  height: 16,
                ),
                Text(
                  "هل المريض يحتاج الي",
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
                        isSelected: cubit.needsEnum == NeedsEnum.chair,
                        onPressed: () {
                          cubit.needsEnum = NeedsEnum.chair;
                          setState(() {});
                        },
                        title: 'كرسي متحرك',
                      ),
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SelectButtonWithTitle(
                        isSelected: cubit.needsEnum == NeedsEnum.bed,
                        onPressed: () {
                          cubit.needsEnum = NeedsEnum.bed;
                          setState(() {});
                        },
                        title: 'سرير متحرك',
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                Text(
                  "هل يوجد مصعد بمنزل المريض ؟",
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
                        isSelected: cubit.mesaad == YesNoEnum.yes,
                        onPressed: () {
                          cubit.mesaad = YesNoEnum.yes;
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
                        isSelected: cubit.mesaad == YesNoEnum.no,
                        onPressed: () {
                          cubit.mesaad = YesNoEnum.no;
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
                Text(
                  "في اي طابق يقع منزل المريض ؟",
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
                        isSelected: cubit.floorEnum == FloorEnum.zero,
                        onPressed: () {
                          cubit.floorEnum = FloorEnum.zero;
                          setState(() {});
                        },
                        title: 'الارضي',
                      ),
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SelectButtonWithTitle(
                        isSelected: cubit.floorEnum == FloorEnum.first,
                        onPressed: () {
                          cubit.floorEnum = FloorEnum.first;
                          setState(() {});
                        },
                        title: 'الاول',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SelectButtonWithTitle(
                        isSelected: cubit.floorEnum == FloorEnum.second,
                        onPressed: () {
                          cubit.floorEnum = FloorEnum.second;
                          setState(() {});
                        },
                        title: 'الثاني',
                      ),
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SelectButtonWithTitle(
                        isSelected: cubit.floorEnum == FloorEnum.third,
                        onPressed: () {
                          cubit.floorEnum = FloorEnum.third;
                          setState(() {});
                        },
                        title: 'الثالث',
                      ),
                    ),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SelectButtonWithTitle(
                        isSelected: cubit.floorEnum == FloorEnum.fourth,
                        onPressed: () {
                          cubit.floorEnum = FloorEnum.fourth;
                          setState(() {});
                        },
                        title: 'الرابع',
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                CustomTextField(
                  hintText: "المزيد من التفاصيل",
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "برجاء ادخال البيانات";
                    }
                    return null;
                  },
                  controller: cubit.detailsController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                CustomElevatedButton(
                  text: "متابعه",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushNamed(
                        context,
                        ScreenName.requestDoctorAndConfirmScreen,
                      );
                    }
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
