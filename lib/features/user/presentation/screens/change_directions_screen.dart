import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weam/core/app_router/screens_name.dart';
import 'package:weam/core/constants/constants.dart';
import 'package:weam/features/user/buisness_logic/user_services_cubit/user_requests_cubit.dart';

import '../../../../core/app_theme/custom_themes.dart';
import '../../../shared_widget/custom_outlined_button.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../features/shared_widget/custom_elevated_button.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';

class ChangeDirectionScreen extends StatefulWidget {
  final String id;

  const ChangeDirectionScreen({
    super.key,
    required this.id,
  });

  @override
  State<ChangeDirectionScreen> createState() => _ChangeDirectionScreenState();
}

class _ChangeDirectionScreenState extends State<ChangeDirectionScreen> {
  @override
  void initState() {
    super.initState();
    UserRequestsCubit.get(context).getChangedCurrentPosition(markerId: 'changedId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserRequestsCubit, UserRequestsState>(
        listener: (context, state) {
          if (state is ChangeDestSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
                context, ScreenName.userMainLayoutScreen, (predicate) => false);
          } else if (state is ChangeDestLoadingState) {
            showProgressIndicator(context);
          }
          if (state is RequestPriceLoadingState) {
            showProgressIndicator(context);
          } else if (state is RequestPriceSuccessState) {
            Navigator.pop(context);
          }
          if (state is GetLocationDescriptionSuccess) {
            UserRequestsCubit.get(context).changeAddressName = state.details ?? "";
          }
          if (state is RequestChangeDestPriceLoadingState) {
            showProgressIndicator(context);
          } else if (state is RequestChangeDestPriceSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          UserRequestsCubit cubit = UserRequestsCubit.get(context);
          return Column(
            children: [
              SizedBox(
                height: 480.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    !cubit.getChangedUserLocationLoading
                        ? SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: GoogleMap(
                              markers: cubit.markers,
                              myLocationButtonEnabled: false,
                              onMapCreated: (GoogleMapController controller) {
                                if (!cubit.mapController.isCompleted) {
                                  cubit.mapController.complete(controller);
                                }
                              },
                              onTap: (latLng) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                cubit.userChangedCurrentPosition = Position(
                                  longitude: latLng.longitude,
                                  latitude: latLng.latitude,
                                  timestamp: DateTime.now(),
                                  // Current timestamp
                                  accuracy: 10.0,
                                  // Example accuracy
                                  altitude: 50.0,
                                  // Example altitude
                                  altitudeAccuracy: 5.0,
                                  // Example altitude accuracy
                                  heading: 90.0,
                                  // Example heading
                                  headingAccuracy: 1.0,
                                  // Example heading accuracy
                                  speed: 10.0,
                                  // Example speed
                                  speedAccuracy: 1.0, // Example speed accuracy
                                );
                                cubit.addMarker(latLng, "changedId");
                              },
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  cubit.userChangedCurrentPosition?.latitude ?? 0,
                                  cubit.userChangedCurrentPosition?.longitude ?? 0,
                                ),
                                zoom: 11.5,
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                    // Positioned(
                    //   top: 64.h,
                    //   left: 16.w,
                    //   right: 16.w,
                    //   child: CustomTextField(
                    //     hintText: "البحث عن الموقع",
                    //     fillColor: AppColors.whiteColor,
                    //     borderRadius: 12,
                    //     filled: true,
                    //     hintStyle:
                    //         CustomThemes.greyColorC6TextTheme(context).copyWith(
                    //       fontSize: 16.sp,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //     prefixIcon: IconButton(
                    //       onPressed: () {},
                    //       icon: SvgPicture.asset(
                    //         SvgPath.searchFiledIcon,
                    //         width: 24.w,
                    //         height: 24.h,
                    //       ),
                    //       padding: EdgeInsets.zero,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
                  children: [
                    Container(
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
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          const CustomSizedBox(
                            height: 8,
                          ),
                          Text(
                            cubit.changeAddressName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.start,
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
                                child: Text(
                                  "رسوم تغيير مسار",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: CustomThemes.greyColor49TextTheme(context).copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Text(
                                "${cubit.priceChangeDestModel?.total ?? ""} ريـال",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
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
                    CustomElevatedButton(
                      text: "طلب سعر",
                      onPressed: cubit.priceChangeDestModel == null
                          ? () {
                              cubit.changeDestPrice(
                                orderId: widget.id,
                                lat: cubit.userChangedCurrentPosition!.latitude.toString(),
                                long: cubit.userChangedCurrentPosition!.latitude.toString(),
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
                      text: "تاكيد",
                      onPressed: cubit.priceChangeDestModel != null
                          ? () {
                              cubit.changeDestination(
                                orderId: widget.id,
                                lat: cubit.userChangedCurrentPosition!.latitude.toString(),
                                long: cubit.userChangedCurrentPosition!.longitude.toString(),
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
                        cubit.priceChangeDestModel = null;
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
              )
            ],
          );
        },
      ),
    );
  }
}
