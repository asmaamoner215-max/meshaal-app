part of 'services_cubit.dart';

@immutable
sealed class ServicesState {}

final class ServicesInitial extends ServicesState {}

// Services States
class GetServicesLoadingState extends ServicesState {}
class GetServicesSuccessState extends ServicesState {
  final GetServicesModel? getServicesModel;

  GetServicesSuccessState({required this.getServicesModel});
}
class GetServicesErrorState extends ServicesState {
  final String error;
  GetServicesErrorState({required this.error});
}

// Nationality States
class GetNationalityLoadingState extends ServicesState {}
class GetNationalitySuccessState extends ServicesState {
  final BaseResponseModel? baseResponseModel;

  GetNationalitySuccessState({required this.baseResponseModel});
}
class GetNationalityErrorState extends ServicesState {
  final String error;
  GetNationalityErrorState({required this.error});
}
