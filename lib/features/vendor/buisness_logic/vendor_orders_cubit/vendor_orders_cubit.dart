import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weam/features/user/data/models/order_model.dart';

import '../../../../core/assets_path/images_path.dart';
import '../../../../core/network/error_message_model.dart';
import '../../../../core/services/maps_services.dart';
import '../../../../core/services/services_locator.dart';
import '../../../user/data/models/get_my_invoices_model.dart';
import '../../../user/data/models/get_my_travels_model.dart';
import '../../data/orders_remote_data_source.dart';

part 'vendor_orders_state.dart';

class VendorOrdersCubit extends Cubit<VendorOrdersState> {
  final VendorOrdersDataSource _vendorOrdersDataSource = sl();
  final GoogleMapsServices _mapService = sl();

  VendorOrdersCubit() : super(VendorOrdersInitial());

  static VendorOrdersCubit get(context) => BlocProvider.of(context);
  BaseErrorModel? baseErrorModel;

  bool getMyTravelsLoading = false;
  GetMyTravelsModel? getMyTravelsModel;

  void providerOrders() async {
    getMyTravelsLoading = true;
    emit(GetMyTravelsLoadingState());

    final response = await _vendorOrdersDataSource.providerOrders();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getMyTravelsLoading = false;
        emit(GetMyTravelsErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        print(r);
        getMyTravelsModel = r;
        getMyTravelsLoading = false;
        emit(GetMyTravelsSuccessState(getMyTravelsModel: r));
      },
    );
  }

  bool getOrderModelLoading = false;
  OrderModel? orderModel;

  void getOrderData({required String orderId}) async {
    getOrderModelLoading = true;
    emit(GetSingleOrderLoadingState());

    final response =
        await _vendorOrdersDataSource.getOrderData(orderId: orderId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getOrderModelLoading = false;
        emit(GetSingleOrderErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        print(r);
        orderModel = r;
        getOrderModelLoading = false;
        emit(GetSingleOrderSuccessState());
      },
    );
  }
  bool waitMinutesLoading = false;
  void waitMinutes({required String minutes, required String orderId,}) async {
    waitMinutesLoading = true;
    emit(WaitMinutesLoadingState());

    final response =
        await _vendorOrdersDataSource.waitMinutes(orderId: orderId, minutes: minutes);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        waitMinutesLoading = false;
        emit(WaitMinutesErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        print(r);
        waitMinutesLoading = false;
        emit(WaitMinutesSuccessState());
      },
    );
  }

  void changeStatus({
    required String orderId,
    required String status,
  }) async {
    emit(ChangeOrderStatusLoadingState());

    final response = await _vendorOrdersDataSource.changeStatus(
      orderId: orderId,
      status: status,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(ChangeOrderStatusErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        print(r);
        emit(ChangeOrderStatusSuccessState());
      },
    );
  }

  void rateUser({
    required String orderId,
    required String comment,   required String rate,
  }) async {
    emit(RateUserLoadingState());

    final response = await _vendorOrdersDataSource.rateUser(
      orderId: orderId,
      comment: comment,
      rate: rate,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(RateUserErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        print(r);
        emit(RateUserSuccessState());
      },
    );
  }

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

  void addMarker(LatLng pos, String id) async {
    final country =
        await _mapService.getUserAddress(lat: pos.latitude, lng: pos.latitude);
    markers.removeWhere((e) => e.markerId.value == id);
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: pos,
        icon: currentIcon,
        infoWindow: InfoWindow(
          title: country[0].country,
        ),
      ),
    );
    emit(AddMarker(latLng: pos));
  }
}
