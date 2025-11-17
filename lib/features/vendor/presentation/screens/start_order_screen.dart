import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../../../../core/app_router/screens_name.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../features/shared_widget/custom_elevated_button.dart';
import '../../../../features/shared_widget/custom_sizedbox.dart';

class StartOrderScreen extends StatefulWidget {
  const StartOrderScreen({super.key});

  @override
  State<StartOrderScreen> createState() => _StartOrderScreenState();
}

class _StartOrderScreenState extends State<StartOrderScreen> {
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
    setMarkers(latLng: const LatLng(24.7136, 46.6753), id: 'fId');
    setMarkers(latLng: const LatLng(24.715589, 46.636249), id: 'fId');
    getPolyLinePoints(const LatLng(24.7136, 46.6753));
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

  void getPolyLinePoints(LatLng? currentLocation) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyDcWIxw6lRSHR9O8ts9R76d9Z7ZzsFmDa0",
      request: PolylineRequest(
        origin: PointLatLng(
          currentLocation!.latitude,
          currentLocation.longitude,
        ),
        destination: const PointLatLng(
          24.715589,
          46.636249,
        ),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      for (var element in result.points) {
        polyLineCoordinates.add(LatLng(element.latitude, element.longitude));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 592.h,
            width: double.infinity,
            child: !isLoading
                ? SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(24.7136, 46.6753),
                        zoom: 12.0,
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
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              children: [
                Row(
                  children: [
                    SvgPicture.asset(SvgPath.locationTick),
                    const CustomSizedBox(
                      width: 8,
                    ),
                    Text(
                      "مكة - المملكة العربية السعودية",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
                CustomElevatedButton(
                  text: "بداية الرحلة",
                  onPressed: () {
                    Navigator.pushNamed(context, ScreenName.vendorOrderScreen);
                  },
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  backgroundColor: AppColors.primaryColor,
                  titleStyle:
                      CustomThemes.whiteColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
