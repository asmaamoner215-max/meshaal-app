part of 'user_orders_cubit.dart';

@immutable
sealed class UserOrdersState {}

final class UserOrdersInitial extends UserOrdersState {}

final class Loading extends UserOrdersState {}
final class Success extends UserOrdersState {}
final class Error extends UserOrdersState {}

final class GetMyInvoicesLoadingState extends UserOrdersState {}
final class GetMyInvoicesSuccessState extends UserOrdersState {
  final GetMyInvoicesModel getMyInvoicesModel;

  GetMyInvoicesSuccessState({required this.getMyInvoicesModel});
}
final class GetMyInvoicesErrorState extends UserOrdersState {
  final String error;

  GetMyInvoicesErrorState({required this.error});
}

final class GetMyTravelsLoadingState extends UserOrdersState {}
final class GetMyTravelsSuccessState extends UserOrdersState {
  final GetMyTravelsModel getMyTravelsModel;

  GetMyTravelsSuccessState({required this.getMyTravelsModel});
}
final class GetMyTravelsErrorState extends UserOrdersState {
  final String error;

  GetMyTravelsErrorState({required this.error});
}

final class CancelOrderLoadingState extends UserOrdersState {}
final class CancelOrderSuccessState extends UserOrdersState {}
final class CancelOrderErrorState extends UserOrdersState {
  final String error;

  CancelOrderErrorState({required this.error});
}

final class AddMarker extends UserOrdersState {
  final LatLng? latLng;

  AddMarker({required this.latLng});
}