import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weam/core/constants/extensions.dart';
import 'package:weam/features/user/buisness_logic/user_services_cubit/user_requests_cubit.dart';
import 'package:weam/features/user/presentation/screens/request_medical_services_screen/complete_service_request_screen.dart';

import '../../../../../core/app_router/screens_name.dart';
import '../../../../../core/app_theme/custom_themes.dart';
import '../../../../../core/app_theme/app_colors.dart';
import '../../../../../core/assets_path/svg_path.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../features/shared_widget/custom_elevated_button.dart';
import '../../../../../features/shared_widget/custom_sizedbox.dart';
import '../../../../shared_widget/custom_text_form_field.dart';

class StartRequestScreen extends StatefulWidget {
  final CompleteServiceRequestArgs completeServiceRequestArgs;
  const StartRequestScreen({super.key, required this.completeServiceRequestArgs});

  @override
  State<StartRequestScreen> createState() => _StartRequestScreenState();
}

class _StartRequestScreenState extends State<StartRequestScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    UserRequestsCubit.get(context).getCurrentPosition(markerId: 'currentId');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserRequestsCubit, UserRequestsState>(
        listener: (context, state) {
          UserRequestsCubit cubit = UserRequestsCubit.get(context);
          if (state is GetLocationDescriptionSuccess) {
            Navigator.pop(context);
            cubit.fromAddress = state.details;
          } else if (state is GetLocationDescriptionLoading) {
            showProgressIndicator(context);
          }
        },
        builder: (context, state) {
          UserRequestsCubit cubit = UserRequestsCubit.get(context);
          return Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: 592.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      !cubit.getUserLocationLoading
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
                                  cubit.userCurrentPosition = Position(
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
                                  cubit.addMarker(latLng, "currentId");
                                },
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    cubit.userCurrentPosition?.latitude ?? 0,
                                    cubit.userCurrentPosition?.longitude ?? 0,
                                  ),
                                  zoom: 11.5,
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                      Positioned(
                        top: 64.h,
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
                          top: 126.h,
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
                                    cubit.animateCameraToPosition(
                                      lat: cubit.searchResults[index].geometry?.location.lat ?? 0,
                                      lng: cubit.searchResults[index].geometry?.location.lng ?? 0,
                                      markerId: "currentId",
                                    );
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
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(SvgPath.locationTick),
                      const CustomSizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          cubit.fromAddress ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: CustomThemes.greyColor49TextTheme(context).copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  CustomElevatedButton(
                    text: "استكمال الطلب",
                    width: double.infinity,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ScreenName.completeServicesRequestScreen,
                        arguments: widget.completeServiceRequestArgs,
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
              ).symmetricPadding(
                horizontal: 16,
                vertical: 16,
              )
            ],
          );
        },
      ),
    );
  }
}
