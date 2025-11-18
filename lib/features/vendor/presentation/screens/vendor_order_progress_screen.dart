import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weam/core/enums/trip_enum.dart';
import 'package:weam/features/shared_widget/dialogs/rating_dialog.dart';
import 'package:weam/features/shared_widget/dialogs/time_dialog.dart';
import '../../../../core/enums/order_status_enum.dart';
import '../../../../features/vendor/buisness_logic/vendor_orders_cubit/vendor_orders_cubit.dart';

import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/services/maps_services.dart';
import '../../../shared_widget/custom_app_bar.dart';
import '../../../shared_widget/requests_persons_details_container.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../features/shared_widget/custom_elevated_button.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';

class VendorOrderProgressScreen extends StatefulWidget {
  const VendorOrderProgressScreen({
    super.key,
  });

  @override
  State<VendorOrderProgressScreen> createState() => _VendorOrderProgressScreenState();
}

class _VendorOrderProgressScreenState extends State<VendorOrderProgressScreen> {
  final Completer<GoogleMapController> _googleMapController = Completer<GoogleMapController>();
  late LatLng sourceLocation;

  final GoogleMapsServices googleMapsServices = GoogleMapsServices();
  List<LatLng> polyLineCoordinates = [];

  void getPolyLinePoints(Position? currentLocation, {double? lat, double? lng}) async {
    if (mounted) {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: "AIzaSyDcWIxw6lRSHR9O8ts9R76d9Z7ZzsFmDa0",
        request: PolylineRequest(
          origin: PointLatLng(
            currentLocation!.latitude,
            currentLocation.longitude,
          ),
          destination: PointLatLng(
            lat!,
            lng!,
          ),
          mode: TravelMode.driving,
        ),
      );
      if (result.points.isNotEmpty) {
        polyLineCoordinates.clear();
        for (var element in result.points) {
          polyLineCoordinates.add(LatLng(element.latitude, element.longitude));
        }
      }
      // setState(() {});
    }
  }

  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  Position? currentLocation;

  void getCurrentMarker() {
    var cubit = VendorOrdersCubit.get(context);
    BitmapDescriptor.asset(
      ImageConfiguration.empty,
      ImagesPath.mapLocation,
      height: 48.h,
      width: 32.w,
    ).then((value) {
      currentIcon = value;
    });
    getCurrentLocation(
      lat: cubit.orderModel!.changeKm.toString() != "0"
          ? double.parse(cubit.orderModel!.changeLat.toString())
          : double.parse(cubit.orderModel!.toLat.toString()),
      lng: cubit.orderModel!.changeKm.toString() != "0"
          ? double.parse(cubit.orderModel!.changeLong.toString())
          : double.parse(cubit.orderModel!.toLong.toString()),
    );
    setState(() {});
  }

  StreamSubscription<Position>? _positionStreamSubscription;

  void getCurrentLocation({
    double? lat,
    double? lng,
  }) async {
    if (mounted) {
      googleMapsServices.getGeoLocationPosition().then((value) {
        currentLocation = value;
        sourceLocation = LatLng(
          lat ?? 0.0,
          lng ?? 0.0,
        );
        getPolyLinePoints(
          currentLocation,
          lng: lng,
          lat: lat,
        );
        setState(() {});
        // getPolyLinePoints(currentLocation);
      }).catchError((e) {});
      GoogleMapController controller = await _googleMapController.future;
      _positionStreamSubscription = Geolocator.getPositionStream().listen((Position? event) {
        currentLocation = event;
        getPolyLinePoints(
          currentLocation,
          lng: lng,
          lat: lat,
        );
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                currentLocation!.latitude,
                currentLocation!.longitude,
              ),
              zoom: zoomValue,
            ),
          ),
        );
        updateFirestoreWithLocation(LatLng(
          currentLocation!.latitude,
          currentLocation!.longitude,
        ));
      });
    }
  }

  double zoomValue = 13.5;

  @override
  void initState() {
    super.initState();
  }

  void updateFirestoreWithLocation(LatLng position) {
    // Assuming 'locations' is your Firestore collection
    CollectionReference locations = FirebaseFirestore.instance.collection('locations');

    // Update a document with an ID 'user_location'
    if (mounted) {
        locations
          .doc(VendorOrdersCubit.get(context).orderModel?.id?.toString())
          .set({
            'latitude': position.latitude,
            'longitude': position.longitude,
            'timestamp': Timestamp.now(), // Optional: Include a timestamp if needed
          })
          .then((value) {})
          .catchError((error) {});
    }
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
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
      body: BlocConsumer<VendorOrdersCubit, VendorOrdersState>(
        listener: (context, state) {
          if (state is GetSingleOrderSuccessState) {
            getCurrentMarker();
          }
          if (state is ChangeOrderStatusLoadingState) {
            showProgressIndicator(context);
          } else if (state is ChangeOrderStatusSuccessState) {
            Navigator.pop(context);
            VendorOrdersCubit.get(context)
                .getOrderData(orderId: VendorOrdersCubit.get(context).orderModel!.id.toString());
          }
          if (VendorOrdersCubit.get(context).orderModel?.status ==
                  OrderStatusEnum.inHospital.name &&
              VendorOrdersCubit.get(context).orderModel?.trip == TripEnum.goBack.name &&
              VendorOrdersCubit.get(context).orderModel?.waitMinutes == null) {
            showDialog(
              context: context,
              builder: (_) => TimeDialog(
                orderModel: VendorOrdersCubit.get(context).orderModel,
              ),
              barrierDismissible: false,
            );
          }
        },
        builder: (context, state) {
          VendorOrdersCubit cubit = VendorOrdersCubit.get(context);
          return cubit.getOrderModelLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.primaryColor,
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 278.h,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          currentLocation != null
                              ? SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: GoogleMap(
                                    myLocationButtonEnabled: false,
                                    mapType: MapType.normal,
                                    onCameraMove: (CameraPosition cameraPosition) {
                                      if (mounted) {
                                        setState(() {
                                          zoomValue = cameraPosition.zoom;
                                        });
                                      }
                                    },
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          currentLocation!.latitude, currentLocation!.longitude),
                                      zoom: zoomValue,
                                    ),
                                    polylines: {
                                      Polyline(
                                        polylineId: const PolylineId("route"),
                                        points: polyLineCoordinates,
                                        color: Colors.red,
                                        width: 6,
                                      )
                                    },
                                    onMapCreated: (controller) {
                                      if (!_googleMapController.isCompleted) {
                                        _googleMapController.complete(controller);
                                      }
                                    },
                                    markers: {
                                      Marker(
                                        markerId: const MarkerId("sourceLocation"),
                                        position: LatLng(
                                          sourceLocation.latitude,
                                          sourceLocation.longitude,
                                        ),
                                      ),
                                      Marker(
                                        markerId: const MarkerId("currentLocation"),
                                        icon: currentIcon,
                                        position: LatLng(
                                          currentLocation!.latitude,
                                          currentLocation!.longitude,
                                        ),
                                      ),
                                    },
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator.adaptive(),
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "وقت الوصول المتوقع",
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
                                cubit.orderModel?.orderTime ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: CustomThemes.greyColor49TextTheme(context).copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const CustomSizedBox(
                            height: 16,
                          ),
                          const Divider(),
                          const CustomSizedBox(
                            height: 16,
                          ),
                          RequestsPersonDetailsContainerWidget(
                            appearContact: true,
                            image: cubit.orderModel?.clientData?.image ?? "",
                            title: "اسم العميل",
                            name: cubit.orderModel?.clientData?.name ?? "",
                            contactTitle: "للتواصل مع العميل",
                          ),
                          const CustomSizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(SvgPath.locationTick),
                              const CustomSizedBox(
                                width: 8,
                              ),
                              Text(
                                cubit.orderModel?.toAddresName ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: CustomThemes.greyColor49TextTheme(context).copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const CustomSizedBox(
                            height: 16,
                          ),
                          if (cubit.orderModel!.trip == TripEnum.goBack.name)
                            CustomElevatedButton(
                              text: cubit.orderModel?.status == OrderStatusEnum.accepted.name
                                  ? "بدآ الرحلة"
                                  : cubit.orderModel?.status == OrderStatusEnum.onWay.name
                                      ? "الوصول للوجهة الاولي"
                                      : cubit.orderModel?.status == OrderStatusEnum.inHomeGo.name
                                          ? "الوصول للوجهة الثانية"
                                          : cubit.orderModel?.status ==
                                                  OrderStatusEnum.inHospital.name
                                              ? "العودة من المستشفي"
                                              : cubit.orderModel?.status ==
                                                      OrderStatusEnum.goHome.name
                                                  ? "انهاء الرحلة"
                                                  : "تقييم العميل",
                              onPressed: () {
                                cubit.orderModel?.status == OrderStatusEnum.accepted.name
                                    ? cubit.changeStatus(
                                        orderId: cubit.orderModel!.id.toString(),
                                        status: OrderStatusEnum.onWay.name)
                                    : cubit.orderModel?.status == OrderStatusEnum.onWay.name
                                        ? cubit.changeStatus(
                                            orderId: cubit.orderModel!.id.toString(),
                                            status: OrderStatusEnum.inHomeGo.name)
                                        : cubit.orderModel?.status ==
                                                OrderStatusEnum.inHomeGo.name
                                            ? cubit.changeStatus(
                                                orderId: cubit.orderModel!.id.toString(),
                                                status: OrderStatusEnum.inHospital.name)
                                            : cubit.orderModel?.status ==
                                                    OrderStatusEnum.inHospital.name
                                                ? cubit.changeStatus(
                                                    orderId: cubit.orderModel!.id.toString(),
                                                    status: OrderStatusEnum.goHome.name)
                                                : cubit.orderModel?.status ==
                                                        OrderStatusEnum.goHome.name
                                                    ? cubit.changeStatus(
                                                        orderId: cubit.orderModel!.id.toString(),
                                                        status: OrderStatusEnum.fnish.name)
                                                    : showDialog(
                                                        context: context,
                                                        builder: (_) => RatingDialog(
                                                          orderModel:
                                                              VendorOrdersCubit.get(context)
                                                                  .orderModel,
                                                        ),
                                                        barrierDismissible: false,
                                                      );
                              },
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              backgroundColor: AppColors.primaryColor,
                              titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          if (cubit.orderModel!.trip == TripEnum.go.name)
                            CustomElevatedButton(
                              text: cubit.orderModel?.status == OrderStatusEnum.accepted.name
                                  ? "بدآ الرحلة"
                                  : cubit.orderModel?.status == OrderStatusEnum.onWay.name
                                      ? "الوصول للوجهة الاولي"
                                      : cubit.orderModel?.status == OrderStatusEnum.inHomeGo.name
                                          ? "الوصول للوجهة الثانية"
                                          : cubit.orderModel?.status ==
                                                  OrderStatusEnum.inHospital.name
                                              ? "انهاء الرحلة"
                                              : "تقييم العميل",
                              onPressed: () {
                                cubit.orderModel?.status == OrderStatusEnum.accepted.name
                                    ? cubit.changeStatus(
                                        orderId: cubit.orderModel!.id.toString(),
                                        status: OrderStatusEnum.onWay.name)
                                    : cubit.orderModel?.status == OrderStatusEnum.onWay.name
                                        ? cubit.changeStatus(
                                            orderId: cubit.orderModel!.id.toString(),
                                            status: OrderStatusEnum.inHomeGo.name)
                                        : cubit.orderModel?.status ==
                                                OrderStatusEnum.inHomeGo.name
                                            ? cubit.changeStatus(
                                                orderId: cubit.orderModel!.id.toString(),
                                                status: OrderStatusEnum.inHospital.name)
                                            : cubit.orderModel?.status ==
                                                    OrderStatusEnum.inHospital.name
                                                ? cubit.changeStatus(
                                                    orderId: cubit.orderModel!.id.toString(),
                                                    status: OrderStatusEnum.fnish.name)
                                                : showDialog(
                                                    context: context,
                                                    builder: (_) => RatingDialog(
                                                        orderModel: VendorOrdersCubit.get(context)
                                                          .orderModel,
                                                    ),
                                                    barrierDismissible: false,
                                                  );
                              },
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              backgroundColor: AppColors.primaryColor,
                              titleStyle: CustomThemes.whiteColorTextTheme(context).copyWith(
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
