import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weam/features/user/data/models/get_my_invoices_model.dart';
import 'package:weam/features/user/data/models/get_my_travels_model.dart';

import '../../../../core/assets_path/images_path.dart';
import '../../../../core/network/error_message_model.dart';
import '../../../../core/services/maps_services.dart';
import '../../../../core/services/services_locator.dart';
import '../../data/models/order_model.dart';
import '../../data/orders_data_source.dart';

part 'user_orders_state.dart';

class UserOrdersCubit extends Cubit<UserOrdersState> {
  final UserOrdersDataSource _userOrdersDataSource = sl();
  final GoogleMapsServices _mapService = sl();

  UserOrdersCubit() : super(UserOrdersInitial());

  static UserOrdersCubit get(context) => BlocProvider.of(context);
  BaseErrorModel? baseErrorModel;

  bool getMyInvoicesLoading = false;
  GetMyInvoicesModel? getMyInvoicesModel;

  Future<void> getMyInvoices() async {
    getMyInvoicesLoading = true;
    emit(GetMyInvoicesLoadingState());

    final response = await _userOrdersDataSource.getMyInvoices();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getMyInvoicesLoading = false;
        emit(GetMyInvoicesErrorState(error: l.baseErrorModel.message));
      },
      (r) {
        print(r);
        getMyInvoicesModel = r;
        getMyInvoicesLoading = false;
        emit(GetMyInvoicesSuccessState(getMyInvoicesModel: r));
      },
    );
  }

  bool getMyTravelsLoading = false;
  GetMyTravelsModel? getMyTravelsModel;

  void getMyTravels() async {
    getMyTravelsLoading = true;
    emit(GetMyTravelsLoadingState());

    final response = await _userOrdersDataSource.myTravels();
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

  bool cancelOrderLoading = false;
  void cancelOrder({required String orderId}) async {
    cancelOrderLoading = true;
    emit(CancelOrderLoadingState());

    final response = await _userOrdersDataSource.cancelOrder(
      orderId: orderId,
    );
    print(response);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        cancelOrderLoading = false;
        emit(CancelOrderErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        cancelOrderLoading = false;
        emit(CancelOrderSuccessState());
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
    final country = await _mapService.getUserAddress(lat: pos.latitude, lng: pos.latitude);
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

  OrderModel? orderModel;

  bool getOrderModelLoading = false;
// void getOrderData({required String orderId}) async {
//   getOrderModelLoading = true;
//   emit(GetSingleOrderLoadingState());
//
//   final response =
//   await _userOrdersDataSource.getOrderData(orderId: orderId);
//   response.fold(
//         (l) {
//       baseErrorModel = l.baseErrorModel;
//       getOrderModelLoading = false;
//       emit(GetSingleOrderErrorState(error: l.baseErrorModel.message));
//     },
//         (r) async {
//       print(r);
//       orderModel = r;
//       getOrderModelLoading = false;
//       emit(GetSingleOrderSuccessState());
//     },
//   );
// }
}
