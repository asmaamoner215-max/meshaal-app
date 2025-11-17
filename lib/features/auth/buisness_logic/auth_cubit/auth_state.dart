part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class GetPickedImageSuccessState extends AuthState {
  final File? pickedImage;

  GetPickedImageSuccessState({
    required this.pickedImage,
  });
}

class GetPickedImageErrorState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final LoginModel? loginDataModel;

  LoginSuccessState({this.loginDataModel});
}

class LoginSuccessWithWrongCredState extends AuthState {
  final BaseErrorModel? baseErrorModel;

  LoginSuccessWithWrongCredState({this.baseErrorModel});
}

class LoginErrorState extends AuthState {
  final String error;
  LoginErrorState({required this.error});
}

class SendOtpLoadingState extends AuthState {}

class SendOtpSuccessState extends AuthState {}

class SendOtpErrorState extends AuthState {
  final String error;
  SendOtpErrorState({required this.error});
}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final RegisterModel? registerModel;

  RegisterSuccessState({required this.registerModel});
}

class RegisterErrorState extends AuthState {
  final String error;
  RegisterErrorState({required this.error});
}

class ChangeForgetPasswordLoadingState extends AuthState {}

class ChangeForgetPasswordSuccessState extends AuthState {}

class ChangeForgetPasswordErrorState extends AuthState {
  final String error;
  ChangeForgetPasswordErrorState({required this.error});
}

class CheckForgetPasswordLoadingState extends AuthState {}

class CheckForgetPasswordSuccessState extends AuthState {
  final ForgetPasswordModel forgetPasswordModel;

  CheckForgetPasswordSuccessState({required this.forgetPasswordModel});
}

class CheckForgetPasswordErrorState extends AuthState {
  final String error;
  CheckForgetPasswordErrorState({required this.error});
}

class UpdateUserDataLoadingState extends AuthState {}

class UpdateUserDataSuccessState extends AuthState {}

class UpdateUserDataErrorState extends AuthState {
  final String error;
  UpdateUserDataErrorState({required this.error});
}

class GetUserDataLoadingState extends AuthState {}

class GetUserDataSuccessState extends AuthState {
  final GetUserDatModel getUserDatModel;

  GetUserDataSuccessState({required this.getUserDatModel});
}

class GetUserDataErrorState extends AuthState {
  final String error;
  GetUserDataErrorState({required this.error});
}

class GetSettingsLoadingState extends AuthState {}

class GetSettingsSuccessState extends AuthState {}

class GetSettingsErrorState extends AuthState {
  final String error;
  GetSettingsErrorState({required this.error});
}

class GetAcknowledgeLoadingState extends AuthState {}

class GetAcknowledgeSuccessState extends AuthState {
  final String data;

  GetAcknowledgeSuccessState({required this.data});
}

class GetAcknowledgeErrorState extends AuthState {
  final String error;
  GetAcknowledgeErrorState({required this.error});
}
