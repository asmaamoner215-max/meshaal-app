import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weam/core/enums/order_status_enum.dart';
import 'package:weam/features/shared_widget/dialogs/rating_dialog.dart';
import 'package:weam/features/user/data/models/order_model.dart';
import 'dart:ui' as ui;

import '../../../../core/app_router/screens_name.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/services/maps_services.dart';
import '../../../shared_widget/custom_app_bar.dart';
import '../../../shared_widget/requests_persons_details_container.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../features/shared_widget/custom_elevated_button.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';

class RoadProgressScreen extends StatefulWidget {
  final OrderModel? orderModel;

  const RoadProgressScreen({super.key, this.orderModel});

  @override
  State<RoadProgressScreen> createState() => _RoadProgressScreenState();
}

class _RoadProgressScreenState extends State<RoadProgressScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentMarker();
  }

  Set<Marker> markers = <Marker>{};
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  bool isLoading = false;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void getCurrentMarker() async {
    setState(() {
      isLoading = true;
    });
    final Uint8List markerIcon =
        await getBytesFromAsset(ImagesPath.mapLocation, 80.w.toInt());
    currentIcon = BitmapDescriptor.bytes(markerIcon);

    trackCarPosition();
    setState(() {
      isLoading = false;
    });
  }

  void setMarkers({
    required String id,
    required LatLng latLng,
  }) {
    markers.add(
      Marker(
        markerId: MarkerId(id),
        icon: currentIcon,
        position: latLng,
        onTap: () {},
      ),
    );
  }

  List<LatLng> polyLineCoordinates = [];
  final GoogleMapsServices googleMapsServices = GoogleMapsServices();

  LatLng? currentLocation;

  void getCurrentLocation({LatLng? destinationPosition}) {
    print("dest");
    print(destinationPosition);
    googleMapsServices.getGeoLocationPosition().then((value) {
      currentLocation = LatLng(value.latitude, value.longitude);
      setMarkers(id: "dest", latLng: destinationPosition!);
      setMarkers(id: "current", latLng: currentLocation!);
      getPolyLinePoints(
        destinationPosition,
      );
      setState(() {});
      // getPolyLinePoints(currentLocation);
    });
  }

  LatLng? carPosition;

  void trackCarPosition() async {
    print("order id");
    print(widget.orderModel!.id!.toString());

    FirebaseFirestore.instance
        .collection('locations')
        .doc(widget.orderModel!.id!.toString())
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        // Assuming 'latitude' and 'longitude' are fields in your document
        Map<String, dynamic> dat = snapshot.data() as Map<String, dynamic>;
        double latitude = dat["latitude"];
        double longitude = dat['longitude'];
        LatLng updatedLatLng = LatLng(latitude, longitude);
        carPosition = updatedLatLng;

        // Update your map with the new LatLng
        getCurrentLocation(destinationPosition: carPosition);
      }
    });
  }

  void getPolyLinePoints(LatLng? destinationPosition) async {
    PolylinePoints polylinePoints = PolylinePoints();
    polyLineCoordinates.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyDcWIxw6lRSHR9O8ts9R76d9Z7ZzsFmDa0",
      request: PolylineRequest(
        origin: PointLatLng(
          currentLocation!.latitude,
          currentLocation!.longitude,
        ),
        destination: PointLatLng(
          destinationPosition?.latitude ?? 0.0,
          destinationPosition?.longitude ?? 0.0,
        ),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      for (var element in result.points) {
        polyLineCoordinates.add(LatLng(element.latitude, element.longitude));
      }
    }
    setState(() {});
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
      body: Column(
        children: [
          SizedBox(
            height: 278.h,
            width: double.infinity,
            child: Stack(
              children: [
                !isLoading
                    ? SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition:  CameraPosition(
                            target: LatLng(currentLocation?.latitude??0.0, currentLocation?.longitude??0.0),
                            zoom: 5.0,
                          ),
                          polylines: {
                            Polyline(
                              polylineId: const PolylineId("route"),
                              points: polyLineCoordinates,
                              color: Colors.red,
                              width: 6,
                            ),
                          },
                          markers: markers,
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
                        widget.orderModel?.statusName??"",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style:
                            CustomThemes.greyColor49TextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      widget.orderModel?.orderTime ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style:
                          CustomThemes.greyColor49TextTheme(context).copyWith(
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "رقم لوحة السيارة",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style:
                            CustomThemes.greyColor49TextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      widget.orderModel?.platNum ?? "1234",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style:
                          CustomThemes.greyColor49TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                RequestsPersonDetailsContainerWidget(
                  name: widget.orderModel?.driverName,
                ),
                // const CustomSizedBox(
                //   height: 16,
                // ),
                // if(widget.orderModel!.doctor==YesNoEnum.yes.name)RequestsPersonDetailsContainerWidget(
                //   appearContact: false,
                //   title: "اسم المسعف",
                // ),
                const CustomSizedBox(
                  height: 16,
                ),
                if(widget.orderModel?.status==OrderStatusEnum.in_hospital.name&&widget.orderModel?.changeKm!="0")
                CustomElevatedButton(
                  text: "نغيير الاتجاه",
                  onPressed: () {
                    Navigator.pushNamed(
                        context, ScreenName.changeDirectionsScreen,
                        arguments: widget.orderModel?.id.toString());
                  },
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  backgroundColor: AppColors.primaryColor,
                  titleStyle:
                      CustomThemes.whiteColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                if (widget.orderModel?.status ==
                    OrderStatusEnum.in_hospital.name)
                  StartTimerWidget(orderModel: widget.orderModel,),
                // BlocConsumer<UserOrdersCubit, UserOrdersState>(
                //   listener: (context, state) {
                //     if(state is CancelOrderSuccessState){
                //       Navigator.pushNamedAndRemoveUntil(context, ScreenName.userMainLayoutScreen, (predicate)=>false);
                //     }else if(state is CancelOrderLoadingState){
                //       showProgressIndicator(context);
                //     }
                //   },
                //   builder: (context, state) {
                //     UserOrdersCubit cubit = UserOrdersCubit.get(context);
                //     return CustomElevatedButton(
                //       text: "انهاء الرحلة",
                //       onPressed: () {
                //         cubit.cancelOrder(orderId: widget.orderModel!.id.toString());
                //       },
                //       padding: EdgeInsets.symmetric(vertical: 16.h),
                //       backgroundColor: AppColors.primaryColor,
                //       titleStyle:
                //           CustomThemes.whiteColorTextTheme(context).copyWith(
                //         fontSize: 16.sp,
                //         fontWeight: FontWeight.w400,
                //       ),
                //     );
                //   },
                // ),
                if (widget.orderModel?.status == OrderStatusEnum.fnish.name)
                  CustomElevatedButton(
                    text: "اكتملت الرحلة",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const RatingDialog(),
                      );
                    },
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: AppColors.primaryColor,
                    titleStyle:
                        CustomThemes.whiteColorTextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                const CustomSizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StartTimerWidget extends StatefulWidget {
  final OrderModel? orderModel;
  const StartTimerWidget({super.key, this.orderModel});

  @override
  State<StartTimerWidget> createState() => _StartTimerWidgetState();
}

class _StartTimerWidgetState extends State<StartTimerWidget> {
  late Duration duration ;
  Timer? _timer;

  late TimeOfDay timeOfDay;

  @override
  void initState() {
    super.initState();
    duration = Duration(
      minutes: DateTime.now()
          .difference(DateTime.parse(widget.orderModel!.updatedAt.toString()))
          .inMinutes,
    );
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        duration = duration + const Duration(seconds: 60);
      });
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "وقت الانتظار",
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
          "يتم احتساب وقت الانتظار بعد (  120 دقايقة )",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: CustomThemes.greyColor797TextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        const CustomSizedBox(
          height: 24,
        ),
        Row(
          children: [
            TimerContainer(
                number:
                    formatDuration(duration).split(":").last.substring(1, 2)),
            const CustomSizedBox(
              width: 16,
            ),
            TimerContainer(
                number:
                    formatDuration(duration).split(":").last.substring(0, 1)),
            const CustomSizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12.h,
                  width: 12.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                const CustomSizedBox(
                  height: 8,
                ),
                Container(
                  height: 12.h,
                  width: 12.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                )
              ],
            ),
            const CustomSizedBox(
              width: 8,
            ),
            TimerContainer(
                number:
                    formatDuration(duration).split(":").first.substring(1, 2)),
            const CustomSizedBox(
              width: 16,
            ),
            TimerContainer(
                number:
                    formatDuration(duration).split(":").first.substring(0, 1)),
          ],
        ),
        const CustomSizedBox(
          height: 24,
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Text(
        //         "رسوم الانتظار",
        //         overflow: TextOverflow.ellipsis,
        //         maxLines: 1,
        //         textAlign: TextAlign.start,
        //         style: CustomThemes.greyColor49TextTheme(context).copyWith(
        //           fontSize: 16.sp,
        //           fontWeight: FontWeight.w400,
        //         ),
        //       ),
        //     ),
        //     Text(
        //       "150 ريـال",
        //       style: CustomThemes.primaryColorTextTheme(context).copyWith(
        //         fontSize: 16.sp,
        //         fontWeight: FontWeight.w700,
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}

class TimerContainer extends StatelessWidget {
  final String number;

  const TimerContainer({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      width: 42.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: AppColors.primaryColor,
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.start,
        style: CustomThemes.whiteColorTextTheme(context).copyWith(
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
