import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weam/core/enums/floor_enum.dart';
import 'package:weam/core/enums/needs_enum.dart';

import '../../../../core/enums/yes_no_enum.dart';
import '../../data/models/get_order_model.dart';
import '../../data/models/promo_code_model.dart';
import '../../data/models/relation_model.dart';
import '../../data/models/request_price_model.dart';
import '../../../../core/enums/mekkah_enum.dart';
import '../../../../core/enums/sex_enum.dart';
import '../../../../core/enums/trip_enum.dart';
import '../../../../core/models/base_response_model.dart';
import '../../../../core/network/error_message_model.dart';
import '../../../../core/parameters/requests_parameters/car_request_parameter.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../../core/services/maps_services.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/cache_helper/shared_pref_methods.dart';
import '../../../../core/cache_helper/cache_keys.dart';
import '../../data/models/nationality_model.dart';
import '../../data/requests_data_source.dart';

part 'user_requests_state.dart';

class UserRequestsCubit extends Cubit<UserRequestsState> {
  final GoogleMapsServices _mapService = sl();
  final RequestsDataSource _requestsDataSource = sl();

  UserRequestsCubit() : super(UserRequestsInitial());

  static UserRequestsCubit get(context) => BlocProvider.of(context);

  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

  void getCurrentMarker() {
    BitmapDescriptor.asset(
      ImageConfiguration.empty,
      ImagesPath.mapLocation,
      height: 48.h,
      width: 32.w,
    ).then((value) {
      currentIcon = value;
    });
  }

  Set<Marker> markers = {};

  void addChooseCurrentLocationMarker(LatLng pos, String id) async {
    final address = await getLocationDescription(pos: pos);
    markers.removeWhere((e) => e.markerId.value == id);
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: pos,
        icon: currentIcon,
        infoWindow: InfoWindow(
          title: "",
          snippet: address?.formattedAddress ?? "",
        ),
      ),
    );
    emit(AddMarker(latLng: pos));
  }

  void addChooseDestinationLocationMarker(LatLng pos, String id) async {
    final address = await getLocationDescription(pos: pos);
    markers.removeWhere((e) => e.markerId.value == id);
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: pos,
        icon: currentIcon,
        infoWindow: InfoWindow(
          title: "",
          snippet: address?.formattedAddress ?? "",
        ),
      ),
    );
    emit(AddMarker(latLng: pos));
  }

  void addMarker(LatLng pos, String id) async {
    final address = await getLocationDescription(pos: pos);
    markers.removeWhere((e) => e.markerId.value == id);
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: pos,
        icon: currentIcon,
        infoWindow: InfoWindow(
          title: "",
          snippet: address?.formattedAddress ?? "",
        ),
      ),
    );
    emit(AddMarker(latLng: pos));
  }

  LocationDescription? locationDetails;
  bool getLocationDescriptionLoading = false;

  Future<LocationDescription?> getLocationDescription({
    required LatLng pos,
  }) async {
    getLocationDescriptionLoading = true;
    emit(GetLocationDescriptionLoading());
    locationDetails = await _mapService.getLocationDescription(
      pos.latitude,
      pos.longitude,
    );
    getLocationDescriptionLoading = false;
    emit(GetLocationDescriptionSuccess(details: locationDetails?.formattedAddress ?? ""));
    return locationDetails;
  }

  List<PlaceResult> searchResults = [];

  void searchPlaces(String query) async {
    emit(GetSearchedLocationsLoading());
    searchResults = await _mapService.searchPlaces(query);
    emit(GetSearchedLocationsSuccess());
  }

  void clearSearchedResult() async {
    searchResults.clear();
    emit(ClearSearchedAddressList());
  }

  RequestAmpParameters? requestAmpParameters;

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  void animateCameraToPosition({
    required double lat,
    required double lng,
    required String markerId,
  }) async {
    markers.removeWhere((e) => e.markerId.value == markerId);
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            lat,
            lng,
          ),
          zoom: 15,
        ),
      ),
    );
    addMarker(
      LatLng(
        lat,
        lng,
      ),
      markerId,
    );
    emit(AnimateCameraToPosition());
  }

  bool getUserLocationLoading = false;
  Position? userCurrentPosition;

  void getCurrentPosition({required String markerId}) async {
    getCurrentMarker();
    getUserLocationLoading = true;
    markers.removeWhere((e) => e.markerId.value == markerId);
    emit(GetCurrentLocationLoading());
    try {
      userCurrentPosition = await _mapService.getGeoLocationPosition();

      addMarker(
        LatLng(
          userCurrentPosition!.latitude,
          userCurrentPosition!.longitude,
        ),
        markerId,
      );
      getUserLocationLoading = false;
      emit(GetCurrentLocationPositionSuccess());
    } catch (e) {
      getUserLocationLoading = false;
      emit(GetCurrentLocationPositionError());
    }
  }

  bool getChangedUserLocationLoading = false;
  Position? userChangedCurrentPosition;

  void getChangedCurrentPosition({required String markerId}) async {
    getCurrentMarker();
    getChangedUserLocationLoading = true;
    markers.removeWhere((e) => e.markerId.value == markerId);
    emit(GetCurrentLocationLoading());
    try {
      // print(await MapService.getCurrentPosition());
      userChangedCurrentPosition = await _mapService.getGeoLocationPosition();

      addMarker(
        LatLng(
          userChangedCurrentPosition!.latitude,
          userChangedCurrentPosition!.longitude,
        ),
        markerId,
      );
      getChangedUserLocationLoading = false;
      emit(GetCurrentLocationPositionSuccess());
    } catch (e) {
      getChangedUserLocationLoading = false;
      emit(GetCurrentLocationPositionError());
    }
  }

  bool getUserDestinationLocationLoading = false;
  LatLng? userDestinationPosition;

  // void getDestinationPosition({required String markerId}) async {
  //   getCurrentMarker();
  //   getUserDestinationLocationLoading = true;
  //   markers.removeWhere((e) => e.markerId.value == markerId);
  //   emit(GetCurrentLocationLoading());
  //   try {
  //     // print(await MapService.getCurrentPosition());
  //     userDestinationPosition = await _mapService.getCurrentPosition();
  //
  //     addMarker(
  //       LatLng(
  //         userDestinationPosition!.latitude,
  //         userDestinationPosition!.longitude,
  //       ),
  //       markerId,
  //     );
  //     getUserDestinationLocationLoading = false;
  //     emit(GetCurrentLocationPositionSuccess());
  //   } catch (e) {
  //     getUserDestinationLocationLoading = false;
  //     print(e);
  //     emit(GetCurrentLocationPositionError());
  //   }
  // }

  /// Car Request Fields
  DateTime? orderDate;
  TimeOfDay? orderTime;
  double? fromLat;
  double? fromLng;
  String? fromAddress;
  double? toLat;
  double? toLng;
  String? toAddress;
  MekkahEnum mekkahEnum = MekkahEnum.inside;
  TripEnum tripEnum = TripEnum.go;
  SexEnum sexEnum = SexEnum.male;
  YesNoEnum infectiousDiseases = YesNoEnum.no;
  YesNoEnum needDoctorInsideAmb = YesNoEnum.no;
  YesNoEnum needOxygen = YesNoEnum.no;
  YesNoEnum urinaryCatheter = YesNoEnum.no;
  YesNoEnum bookingFlight = YesNoEnum.no;
  FloorEnum floorEnum = FloorEnum.zero;
  NeedsEnum needsEnum = NeedsEnum.bed;
  YesNoEnum mesaad = YesNoEnum.yes;
  File? bookingFile;
  TextEditingController patientNameController = TextEditingController();
  TextEditingController patientWeightController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  void handleSentParameters() {
    orderDate = null;
    orderTime = null;
    fromLat = null;
    fromLng = null;
    promoModel = null;
    fromAddress = null;
    polyLineCoordinates.clear();
    toLat = null;
    toLng = null;
    toAddress = null;
    nationality = null;
    userCurrentPosition = null;
    userDestinationPosition = null;
    priceModel = null;
    bookingFile = null;
    bookingFlight = YesNoEnum.no;
    selectedRelation = null;
    markers.clear();
    patientNameController.clear();
    // relationController.clear();
    patientWeightController.clear();
  }

  BaseErrorModel? baseErrorModel;

  void sendCarRequest({
    required RequestAmpParameters requestParameters,
  }) async {
    emit(SendCarRequestLoadingState());

    final response = await _requestsDataSource.sendCarRequest(
      parameters: requestParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(SendCarRequestErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        emit(SendCarRequestSuccessState(baseResponseModel: r));
      },
    );
  }

  void sendVisitRequest({
    required RequestAmpParameters requestParameters,
  }) async {
    emit(SendVisitRequestLoadingState());

    final response = await _requestsDataSource.sendVisitRequest(
      parameters: requestParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(SendVisitRequestErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        emit(SendVisitRequestSuccessState(baseResponseModel: r));
      },
    );
  }

  void payWithWalletSMS({
    required String orderId,
    required String orderSMSCode,
  }) async {
    emit(PayWithWalletSMSLoadingState());

    final response = await _requestsDataSource.payWithWalletSMS(
      orderId: orderId,
      orderSMSCode: orderSMSCode,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(PayWithWalletSMSErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        emit(PayWithWalletSMSSuccessState(baseResponseModel: r));
      },
    );
  }

  PriceModel? priceModel;

  void requestPrice({
    required RequestAmpParameters requestParameters,
  }) async {
    emit(RequestPriceLoadingState());

    final response = await _requestsDataSource.requestPrice(
      parameters: requestParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          RequestPriceErrorState(error: l.baseErrorModel.message),
        );
      },
      (r) async {
        priceModel = r.data;
        // requestPriceData = false;
        emit(
          RequestPriceSuccessState(baseResponseModel: r),
        );
      },
    );
  }

  PriceModel? priceChangeDestModel;

  void changeDestPrice({
    required String orderId,
    required String lat,
    required String long,
  }) async {
    emit(RequestChangeDestPriceLoadingState());

    final response =
        await _requestsDataSource.changeDestPrice(orderId: orderId, lat: lat, long: long);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          RequestChangeDestPriceErrorState(error: l.baseErrorModel.message),
        );
      },
      (r) async {
        priceChangeDestModel = r.data;
        // requestPriceData = false;
        emit(
          RequestChangeDestPriceSuccessState(priceModel: r.data),
        );
      },
    );
  }

  PromoModel? promoModel;
  void addPromoCode({
    required String coupon,
    required String total,
  }) async {
    emit(CheckPromoCodeLoadingState());
    final response = await _requestsDataSource.addPromoCode(
      coupon: coupon,
      total: total,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          CheckPromoCodeErrorState(error: l.baseErrorModel.message),
        );
      },
      (r) async {
        if (r.status == true) {
          promoModel = r;
        }
        emit(CheckPromoCodeSuccessState(promoModel: r));
      },
    );
  }

  String changeAddressName = "";
  void changeDestination({
    required String orderId,
    required String lat,
    required String long,
  }) async {
    emit(ChangeDestLoadingState());

    final response = await _requestsDataSource.changeDestination(
        orderId: orderId, lat: lat, long: long, addressName: changeAddressName);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          ChangeDestErrorState(error: l.baseErrorModel.message),
        );
      },
      (r) async {
        priceModel = r.data;
        // requestPriceData = false;
        emit(
          ChangeDestSuccessState(),
        );
      },
    );
  }

  final _picker = ImagePicker();

  Future<void> getImagePick() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(GetPickedImageSuccessState(image: File(pickedFile.path)));
    } else {
      emit(GetPickedImageErrorState());
    }
  }

  Nationality? nationality;
  List<Nationality> nationalList = [];
  bool getNationalityLoading = false;

  void getNationality() async {
    // Fast path: in-memory
    if (nationalList.isNotEmpty) {
      emit(GetNationalitySuccessState(
          baseResponseModel: BaseResponseModel(status: true, message: 'cached', data: nationalList)));
      return;
    }
    // Fast path: cached in SharedPreferences
    try {
      final cached = CacheHelper.getData(key: CacheKeys.nationalityCache) as String?;
      if (cached != null && cached.isNotEmpty) {
        final List<dynamic> arr = jsonDecode(cached);
        nationalList = arr
            .whereType<Map>()
            .map((e) => Nationality.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        emit(GetNationalitySuccessState(
            baseResponseModel:
                BaseResponseModel(status: true, message: 'cached', data: nationalList)));
        // background refresh (no loader)
        _refreshNationality();
        return;
      }
    } catch (_) {}

    // Network with loader
    getNationalityLoading = true;
    emit(GetNationalityLoadingState());
    final response = await _requestsDataSource.getNationality();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getNationalityLoading = false;
        emit(GetNationalityErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        nationalList = r.data ?? [];
        // cache result
        try {
          await CacheHelper.saveData(
              key: CacheKeys.nationalityCache, value: jsonEncode(nationalList.map((e) => e.toJson()).toList()));
          await CacheHelper.saveData(
              key: CacheKeys.nationalityCacheAt, value: DateTime.now().millisecondsSinceEpoch);
        } catch (_) {}
        getNationalityLoading = false;
        emit(GetNationalitySuccessState(baseResponseModel: r));
      },
    );
  }

  Future<void> _refreshNationality() async {
    final response = await _requestsDataSource.getNationality();
    response.fold(
      (_) {},
      (r) async {
        nationalList = r.data ?? [];
        try {
          await CacheHelper.saveData(
              key: CacheKeys.nationalityCache, value: jsonEncode(nationalList.map((e) => e.toJson()).toList()));
          await CacheHelper.saveData(
              key: CacheKeys.nationalityCacheAt, value: DateTime.now().millisecondsSinceEpoch);
        } catch (_) {}
        emit(GetNationalitySuccessState(baseResponseModel: r));
      },
    );
  }

  RelationModel? selectedRelation;
  List<RelationModel> relationList = [];
  bool getRelationLoading = false;

  void getRelationList() async {
    // In-memory fast path
    if (relationList.isNotEmpty) {
      emit(GetRelationSuccessState());
      return;
    }
    // Cache fast path
    try {
      final cached = CacheHelper.getData(key: CacheKeys.relationCache) as String?;
      if (cached != null && cached.isNotEmpty) {
        final List<dynamic> arr = jsonDecode(cached);
        relationList = arr
            .whereType<Map>()
            .map((e) => RelationModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        emit(GetRelationSuccessState());
        _refreshRelations();
        return;
      }
    } catch (_) {}

    // Network with loader
    getRelationLoading = true;
    emit(GetRelationLoadingState());
    final response = await _requestsDataSource.getRelationList();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getRelationLoading = false;
        emit(GetRelationErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        // deduplicate by id/name
        final set = <RelationModel>{...r};
        relationList = set.toList();
        try {
          await CacheHelper.saveData(
              key: CacheKeys.relationCache,
              value: jsonEncode(relationList.map((e) => {"id": e.id, "name": e.name}).toList()));
          await CacheHelper.saveData(
              key: CacheKeys.relationCacheAt, value: DateTime.now().millisecondsSinceEpoch);
        } catch (_) {}
        getRelationLoading = false;
        emit(GetRelationSuccessState());
      },
    );
  }

  Future<void> _refreshRelations() async {
    final response = await _requestsDataSource.getRelationList();
    response.fold(
      (_) {},
      (r) async {
        final set = <RelationModel>{...r};
        relationList = set.toList();
        try {
          await CacheHelper.saveData(
              key: CacheKeys.relationCache,
              value: jsonEncode(relationList.map((e) => {"id": e.id, "name": e.name}).toList()));
          await CacheHelper.saveData(
              key: CacheKeys.relationCacheAt, value: DateTime.now().millisecondsSinceEpoch);
        } catch (_) {}
        emit(GetRelationSuccessState());
      },
    );
  }

  List<LatLng> polyLineCoordinates = [];

  bool getPolyLinesLoading = false;

  void getPolyLinePoints({
    LatLng? destLocation,
    Position? currentLocation,
  }) async {
    getPolyLinesLoading = true;
    emit(GetPolyLineLoadingState());
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyDcWIxw6lRSHR9O8ts9R76d9Z7ZzsFmDa0",
      request: PolylineRequest(
        origin: PointLatLng(
          currentLocation!.latitude,
          currentLocation.longitude,
        ),
        destination: PointLatLng(
          destLocation!.latitude,
          destLocation.longitude,
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
    getPolyLinesLoading = false;

    emit(GetPolyLineSuccessState());
  }

  bool requestPriceData = true;
}
