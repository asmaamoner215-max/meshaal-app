import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/enums/yes_no_enum.dart';
import '../../../../core/parameters/requests_parameters/car_request_parameter.dart';
import '../../../../features/shared_widget/dialogs/pay_dialog.dart';
import '../../buisness_logic/user_services_cubit/user_requests_cubit.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/constants/constants.dart';
import '../../../shared_widget/custom_app_bar.dart';
import '../../../shared_widget/custom_outlined_button.dart';
import '../../../shared_widget/select_button_with_title.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../features/shared_widget/custom_elevated_button.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../features/shared_widget/custom_text_form_field.dart';

class RequestDoctorAndConfirmScreen extends StatefulWidget {
  const RequestDoctorAndConfirmScreen({super.key});

  @override
  State<RequestDoctorAndConfirmScreen> createState() => _RequestDoctorAndConfirmScreenState();
}

class _RequestDoctorAndConfirmScreenState extends State<RequestDoctorAndConfirmScreen> {
  int requestScreen = 0;

  TextEditingController searchController = TextEditingController();
  TextEditingController promoCodeController = TextEditingController();

  var promoForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "تأكيد الطلب",
        ),
      ),
      body: BlocConsumer<UserRequestsCubit, UserRequestsState>(
        listener: (context, state) {
          UserRequestsCubit cubit = UserRequestsCubit.get(context);
          if (state is GetLocationDescriptionSuccess) {
            Navigator.pop(context);
            cubit.toAddress = state.details;
          } else if (state is GetLocationDescriptionLoading) {
            showProgressIndicator(context);
          }
          if (state is AddMarker) {
            cubit.getPolyLinePoints(
              destLocation: state.latLng,
              currentLocation: cubit.userCurrentPosition,
            );
          }
          if (state is GetPolyLineLoadingState) {
            showProgressIndicator(context);
          } else if (state is GetPolyLineSuccessState) {
            Navigator.pop(context);
          }
          if (state is CheckPromoCodeLoadingState) {
            showProgressIndicator(context);
          } else if (state is CheckPromoCodeSuccessState) {
            Navigator.pop(context);
            showToast(
              errorType: state.promoModel!.status == true ? 0 : 1,
              message: state.promoModel?.msg ?? "",
            );
          } else if (state is CheckPromoCodeErrorState) {
            Navigator.pop(context);
          }
          if (state is RequestPriceLoadingState) {
            showProgressIndicator(context);
          } else if (state is RequestPriceSuccessState) {
            Navigator.pop(context);
            showToast(errorType: 0, message: "تم تحديد السعر");
          } else if (state is RequestPriceErrorState) {
            Navigator.pop(context);
            showToast(errorType: 0, message: state.error);
          }
        },
        builder: (context, state) {
          UserRequestsCubit cubit = UserRequestsCubit.get(context);
          return Column(
            children: [
              SizedBox(
                height: 283.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: GoogleMap(
                        markers: cubit.markers,
                        // myLocationButtonEnabled: false,
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          if (!cubit.mapController.isCompleted) {
                            cubit.mapController.complete(controller);
                          }
                        },
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId("route"),
                            points: cubit.polyLineCoordinates,
                            color: Colors.red,
                            width: 6,
                          )
                        },
                        onTap: (latLng) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          cubit.userDestinationPosition = latLng;
                          cubit.addMarker(
                            latLng,
                            "destId",
                          );
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            cubit.userCurrentPosition?.latitude ?? 0,
                            cubit.userCurrentPosition?.longitude ?? 0,
                          ),
                          zoom: 11.5,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16.h,
                      left: 16.w,
                      right: 16.w,
                      child: CustomTextField(
                        hintText: "البحث عن الموقع",
                        fillColor: AppColors.whiteColor,
                        borderRadius: 12,
                        filled: true,
                        //   onSubmitted: (value) {
                        //   cubit.searchPlaces(value);
                        // },
                        controller: searchController,
                        hintStyle: CustomThemes.greyColorC6TextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            cubit.searchPlaces(searchController.text);
                          },
                          icon: SvgPicture.asset(
                            SvgPath.searchFiledIcon,
                            width: 24.w,
                            height: 24.h,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    if (cubit.searchResults.isNotEmpty)
                      Positioned.fill(
                        top: 80.h,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          color: AppColors.whiteColor,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            separatorBuilder: (_, index) {
                              return const CustomSizedBox(
                                height: 8,
                              );
                            },
                            itemCount: cubit.searchResults.length,
                            // shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  cubit.userDestinationPosition = LatLng(
                                    cubit.searchResults[index].geometry?.location.lat ?? 0,
                                    cubit.searchResults[index].geometry?.location.lng ?? 0,
                                  );
                                  cubit.animateCameraToPosition(
                                    lat: cubit.searchResults[index].geometry?.location.lat ?? 0,
                                    lng: cubit.searchResults[index].geometry?.location.lng ?? 0,
                                    markerId: "destId",
                                  );

                                  // cubit.getPolyLinePoints(
                                  //   destLocation: LatLng(
                                  //     cubit.searchResults[index].geometry
                                  //             ?.location.lat ??
                                  //         0.0,
                                  //     cubit.searchResults[index].geometry
                                  //             ?.location.lng ??
                                  //         0.0,
                                  //   ),
                                  //   currentLocation: cubit.userCurrentPosition,
                                  // );
                                  cubit.clearSearchedResult();
                                },
                                leading: SvgPicture.asset(
                                  SvgPath.location,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.primaryColor,
                                    BlendMode.srcIn,
                                  ),
                                  height: 32.h,
                                  width: 32.w,
                                ),
                                title: Text(
                                  cubit.searchResults[index].name ?? "",
                                  style: CustomThemes.greyColor49TextTheme(context).copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  cubit.searchResults[index].formattedAddress ?? '',
                                  style: CustomThemes.greyColor49TextTheme(context).copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 24.h,
                  ),
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset.zero,
                            blurRadius: 4.r,
                            color: AppColors.shadowColor(opacityValue: 0.15),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "اسم الوجهة",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: CustomThemes.greyColor49TextTheme(context).copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: cubit.priceModel == null
                                      ? "اطلب سعر"
                                      : cubit.priceModel?.total ?? "",
                                  style: cubit.promoModel != null
                                      ? CustomThemes.greyColor49TextTheme(context).copyWith(
                                          fontSize: 14.sp,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: AppColors.greyColor49,
                                          fontWeight: FontWeight.w700,
                                        )
                                      : CustomThemes.primaryColorTextTheme(context).copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  children: [
                                    if (cubit.promoModel != null)
                                      TextSpan(
                                        text: "  ${cubit.promoModel?.total ?? ""} ",
                                        style: CustomThemes.primaryColorTextTheme(context).copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    TextSpan(
                                      text: cubit.priceModel != null ? " ريـال" : "",
                                      style: CustomThemes.primaryColorTextTheme(context).copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // Text(
                              //   ",",
                              //   overflow: TextOverflow.ellipsis,
                              //   maxLines: 1,
                              //   style:
                              //       CustomThemes.primaryColorTextTheme(context)
                              //           .copyWith(
                              //     fontSize: 16.sp,
                              //     fontWeight: FontWeight.w700,
                              //   ),
                              // ),
                            ],
                          ),
                          const CustomSizedBox(
                            height: 16,
                          ),
                          Text(
                            cubit.toAddress ?? "قم بتحديد وجهة",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: CustomThemes.greyColor49TextTheme(context).copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset.zero,
                            blurRadius: 4.r,
                            color: AppColors.shadowColor(opacityValue: 0.15),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "خدمة التمريض",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: CustomThemes.greyColor49TextTheme(context).copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              if (cubit.needDoctorInsideAmb == YesNoEnum.yes)
                                Text(
                                  cubit.priceModel == null
                                      ? "اطلب سعر"
                                      : "${cubit.priceModel?.doctor ?? ""} ريـال",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                            ],
                          ),
                          const CustomSizedBox(
                            height: 16,
                          ),
                          Text(
                            "هل تريد ممرض/ة يتواجد بسيارة الاسعاف ؟",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: CustomThemes.greyColor49TextTheme(context).copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const CustomSizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SelectButtonWithTitle(
                                  isSelected: cubit.needDoctorInsideAmb == YesNoEnum.yes,
                                  onPressed: () {
                                    cubit.needDoctorInsideAmb = YesNoEnum.yes;
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
                                  isSelected: cubit.needDoctorInsideAmb == YesNoEnum.no,
                                  onPressed: () {
                                    cubit.needDoctorInsideAmb = YesNoEnum.no;
                                    setState(() {});
                                  },
                                  title: 'لا',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    if (cubit.priceModel != null && cubit.promoModel == null)
                      Form(
                        key: promoForm,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: "ادخل كود الخصم",
                                controller: promoCodeController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "برجاء ادخال فيمة";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const CustomSizedBox(
                              width: 16,
                            ),
                            CustomElevatedButton(
                              text: "ارسال",
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ),
                              onPressed: () {
                                if (promoForm.currentState!.validate()) {
                                  cubit.addPromoCode(
                                    coupon: promoCodeController.text,
                                    total: cubit.priceModel!.total.toString(),
                                  );
                                }
                              },
                              backgroundColor: AppColors.primaryColor,
                              titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    CustomElevatedButton(
                      text: "طلب سعر",
                      onPressed: cubit.priceModel == null
                          ? () {
                              cubit.userDestinationPosition != null
                                  ? cubit.requestPrice(
                                      requestParameters: RequestAmpParameters(
                                        formLat: cubit.userCurrentPosition?.latitude ?? 0,
                                        formLong: cubit.userCurrentPosition?.longitude ?? 0,
                                        toLat: cubit.userDestinationPosition?.latitude ?? 0.0,
                                        toLong: cubit.userDestinationPosition?.longitude ?? 0.0,
                                        trip: cubit.tripEnum.name,
                                        makkah: cubit.mekkahEnum.name,
                                        doctor: cubit.needDoctorInsideAmb.name,
                                      ),
                                    )
                                  : showToast(
                                      errorType: 1,
                                      message: "قم باختيار عنوان الوصول",
                                    );
                            }
                          : null,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      backgroundColor: AppColors.primaryColor,
                      titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    CustomElevatedButton(
                      text: "اطلب فورا",
                      onPressed: cubit.priceModel != null
                          ? () {
                              showDialog(
                                context: context,
                                builder: (_) => const PayDialog(),
                              );
                            }
                          : null,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      backgroundColor: AppColors.primaryColor,
                      titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    Text(
                      "اذا كنت تريد تغير البيانات قم بالضغط علي تغير البيانات ثم اطلب سعر مجددا",
                      style: CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    CustomOutlinedButton(
                      onPressed: () {
                        cubit.priceModel = null;
                        cubit.promoModel = null;
                        setState(() {});
                      },
                      backgroundColor: AppColors.whiteColor,
                      foregroundColor: AppColors.primaryColor,
                      borderRadius: 12,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                      ),
                      text: "تغير البيانات",
                      style: CustomThemes.primaryColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
