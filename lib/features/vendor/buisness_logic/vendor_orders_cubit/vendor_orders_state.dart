part of 'vendor_orders_cubit.dart';

@immutable
sealed class VendorOrdersState {}

final class VendorOrdersInitial extends VendorOrdersState {}

final class Loading extends VendorOrdersState {}
final class Success extends VendorOrdersState {}
final class Error extends VendorOrdersState {}

final class GetMyInvoicesLoadingState extends VendorOrdersState {}
final class GetMyInvoicesSuccessState extends VendorOrdersState {
  final GetMyInvoicesModel getMyInvoicesModel;

  GetMyInvoicesSuccessState({required this.getMyInvoicesModel});
}
final class GetMyInvoicesErrorState extends VendorOrdersState {
  final String error;

  GetMyInvoicesErrorState({required this.error});
}

final class GetMyTravelsLoadingState extends VendorOrdersState {}
final class GetMyTravelsSuccessState extends VendorOrdersState {
  final GetMyTravelsModel getMyTravelsModel;

  GetMyTravelsSuccessState({required this.getMyTravelsModel});
}
final class GetMyTravelsErrorState extends VendorOrdersState {
  final String error;

  GetMyTravelsErrorState({required this.error});
}

final class GetSingleOrderLoadingState extends VendorOrdersState {}
final class GetSingleOrderSuccessState extends VendorOrdersState {}
final class GetSingleOrderErrorState extends VendorOrdersState {
  final String error;

  GetSingleOrderErrorState({required this.error});
}
final class WaitMinutesLoadingState extends VendorOrdersState {}
final class WaitMinutesSuccessState extends VendorOrdersState {}
final class WaitMinutesErrorState extends VendorOrdersState {
  final String error;

  WaitMinutesErrorState({required this.error});
}

final class ChangeOrderStatusLoadingState extends VendorOrdersState {}
final class ChangeOrderStatusSuccessState extends VendorOrdersState {}
final class ChangeOrderStatusErrorState extends VendorOrdersState {
  final String error;

  ChangeOrderStatusErrorState({required this.error});
}


final class RateUserLoadingState extends VendorOrdersState {}
final class RateUserSuccessState extends VendorOrdersState {}
final class RateUserErrorState extends VendorOrdersState {
  final String error;

  RateUserErrorState({required this.error});
}

final class AddMarker extends VendorOrdersState {
  final LatLng? latLng;

  AddMarker({required this.latLng});
}
