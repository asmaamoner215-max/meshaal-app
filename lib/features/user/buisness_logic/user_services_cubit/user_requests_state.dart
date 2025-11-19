part of 'user_requests_cubit.dart';

@immutable
sealed class UserRequestsState {}

final class UserRequestsInitial extends UserRequestsState {}

final class AddMarker extends UserRequestsState {
  final LatLng? latLng;

  AddMarker({required this.latLng});
}

final class GetPickedImageSuccessState extends UserRequestsState {
  final File? image;

  GetPickedImageSuccessState({required this.image});
}

final class GetPickedImageErrorState extends UserRequestsState {}

final class GetLocationDescriptionLoading extends UserRequestsState {}

final class GetLocationDescriptionSuccess extends UserRequestsState {
  final String? details;

  GetLocationDescriptionSuccess({required this.details});
}

final class GetSearchedLocationsLoading extends UserRequestsState {}

final class ClearSearchedAddressList extends UserRequestsState {}

final class GetSearchedLocationsSuccess extends UserRequestsState {}

final class AnimateCameraToPosition extends UserRequestsState {}

class GetCurrentLocationLoading extends UserRequestsState {}

class GetCurrentLocationPositionSuccess extends UserRequestsState {}

class GetCurrentLocationPositionError extends UserRequestsState {}

class SendCarRequestLoadingState extends UserRequestsState {}

class SendCarRequestSuccessState extends UserRequestsState {
  final GetOrderModel? baseResponseModel;

  SendCarRequestSuccessState({required this.baseResponseModel});
}

class SendCarRequestErrorState extends UserRequestsState {
  final String error;
  SendCarRequestErrorState({required this.error});
}

class SendVisitRequestLoadingState extends UserRequestsState {}

class SendVisitRequestSuccessState extends UserRequestsState {
  final BaseResponseModel? baseResponseModel;

  SendVisitRequestSuccessState({required this.baseResponseModel});
}

class SendVisitRequestErrorState extends UserRequestsState {
  final String error;
  SendVisitRequestErrorState({required this.error});
}

class PayWithWalletSMSLoadingState extends UserRequestsState {}

class PayWithWalletSMSSuccessState extends UserRequestsState {
  final BaseResponseModel? baseResponseModel;

  PayWithWalletSMSSuccessState({required this.baseResponseModel});
}

class PayWithWalletSMSErrorState extends UserRequestsState {
  final String error;
  PayWithWalletSMSErrorState({required this.error});
}

class RequestPriceLoadingState extends UserRequestsState {}

class RequestPriceSuccessState extends UserRequestsState {
  final BaseResponseModel? baseResponseModel;

  RequestPriceSuccessState({required this.baseResponseModel});
}

class RequestPriceErrorState extends UserRequestsState {
  final String error;
  RequestPriceErrorState({required this.error});
}

class RequestChangeDestPriceLoadingState extends UserRequestsState {}

class RequestChangeDestPriceSuccessState extends UserRequestsState {
  final PriceModel? priceModel;

  RequestChangeDestPriceSuccessState({required this.priceModel});
}

class RequestChangeDestPriceErrorState extends UserRequestsState {
  final String error;
  RequestChangeDestPriceErrorState({required this.error});
}

class CheckPromoCodeLoadingState extends UserRequestsState {}

class CheckPromoCodeSuccessState extends UserRequestsState {
  final PromoModel? promoModel;

  CheckPromoCodeSuccessState({required this.promoModel});
}

class CheckPromoCodeErrorState extends UserRequestsState {
  final String error;
  CheckPromoCodeErrorState({required this.error});
}

class ChangeDestLoadingState extends UserRequestsState {}

class ChangeDestSuccessState extends UserRequestsState {}

class ChangeDestErrorState extends UserRequestsState {
  final String error;
  ChangeDestErrorState({required this.error});
}

class GetPolyLineLoadingState extends UserRequestsState {}

class GetPolyLineSuccessState extends UserRequestsState {}

class GetNationalityLoadingState extends UserRequestsState {}

class GetNationalitySuccessState extends UserRequestsState {
  final BaseResponseModel? baseResponseModel;

  GetNationalitySuccessState({required this.baseResponseModel});
}

class GetNationalityErrorState extends UserRequestsState {
  final String error;
  GetNationalityErrorState({required this.error});
}

final class GetSingleOrderLoadingState extends UserRequestsState {}

final class GetSingleOrderSuccessState extends UserRequestsState {}

final class GetSingleOrderErrorState extends UserRequestsState {
  final String error;

  GetSingleOrderErrorState({required this.error});
}

class GetRelationLoadingState extends UserRequestsState {}

class GetRelationSuccessState extends UserRequestsState {
  GetRelationSuccessState();
}

class GetRelationErrorState extends UserRequestsState {
  final String error;
  GetRelationErrorState({required this.error});
}
