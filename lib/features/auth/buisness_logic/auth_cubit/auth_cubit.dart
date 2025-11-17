import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:weam/core/cache_helper/cache_keys.dart';
import 'package:weam/core/cache_helper/shared_pref_methods.dart';
import 'package:weam/features/auth/data/models/login_model.dart';

import '../../../../core/network/error_message_model.dart';
import '../../../../core/parameters/auth_parameters/login_parameters.dart';
import '../../../../core/parameters/auth_parameters/register_parameters.dart';
import '../../../../core/services/services_locator.dart';
import '../../data/data_source/auth_data_source.dart';
import '../../data/models/app_settings_model.dart';
import '../../data/models/forget_password_model.dart';
import '../../data/models/register_model.dart';
import '../../data/models/user_data_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource _authRemoteDataSource = sl();

  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  BaseErrorModel? baseErrorModel;

  final _picker = ImagePicker();

  File? profileImage;

  ForgetPasswordModel? forgetPasswordModel;
  Future<void> getImagePick() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      emit(GetPickedImageSuccessState(pickedImage: File(pickedFile.path)));
    } else {
      emit(GetPickedImageErrorState());
    }
  }

  void login({
    required LoginParameters loginParameters,
  }) async {
    emit(LoginLoadingState());
    final response = await _authRemoteDataSource.login(
      parameters: loginParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(LoginErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        if (r.status == true && r.data != null) {
          // Save data to cache first
          await handleCache(
            token: r.data!.token ?? "",
            userType: r.data!.type ?? "",
          );
          emit(
            LoginSuccessState(loginDataModel: r),
          );
        } else {
          emit(
            LoginSuccessWithWrongCredState(
              baseErrorModel: BaseErrorModel(
                message: r.message ?? "فشل تسجيل الدخول",
                status: r.status ?? false,
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> handleCache({
    String? token,
    String? userType,
  }) async {
    await CacheHelper.saveData(key: CacheKeys.token, value: token);
    await CacheHelper.saveData(key: CacheKeys.userType, value: userType);
  }

  // void sendOtp({
  //   required String code,
  // }) async {
  //   emit(SendOtpLoadingState());
  //   final response = await _authRemoteDataSource.sendOtp(
  //     otpCode: code,
  //   );
  //   response.fold(
  //     (l) {
  //       baseErrorModel = l.baseErrorModel;
  //       emit(
  //         SendOtpErrorState(error: l.baseErrorModel.message),
  //       );
  //     },
  //     (r) async {
  //       emit(
  //         SendOtpSuccessState(),
  //       );
  //     },
  //   );
  // }

  void register({
    required RegisterParameters registerParameters,
  }) async {
    emit(RegisterLoadingState());

    final response = await _authRemoteDataSource.register(
      parameters: registerParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          RegisterErrorState(error: l.baseErrorModel.message),
        );
      },
      (r) async {
        emit(
          RegisterSuccessState(registerModel: r),
        );
      },
    );
  }

  void changeForgetPassword({required String password, required String userId}) async {
    emit(ChangeForgetPasswordLoadingState());

    final response =
        await _authRemoteDataSource.changeForgetPassword(userId: userId, password: password);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          ChangeForgetPasswordErrorState(error: l.baseErrorModel.message),
        );
      },
      (r) async {
        emit(
          ChangeForgetPasswordSuccessState(),
        );
      },
    );
  }

  void checkForget({
    required String phoneNumber,
  }) async {
    emit(CheckForgetPasswordLoadingState());

    final response = await _authRemoteDataSource.checkForget(
      phone: phoneNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          CheckForgetPasswordErrorState(error: l.baseErrorModel.message),
        );
      },
      (r) async {
        forgetPasswordModel = r;
        emit(
          CheckForgetPasswordSuccessState(forgetPasswordModel: r),
        );
      },
    );
  }

  void updateUserData({
    required RegisterParameters registerParameters,
  }) async {
    emit(UpdateUserDataLoadingState());

    final response = await _authRemoteDataSource.updateUserData(
      parameters: registerParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          UpdateUserDataErrorState(error: l.baseErrorModel.message),
        );
      },
      (r) async {
        emit(
          UpdateUserDataSuccessState(),
        );
      },
    );
  }

  bool getUserDataLoading = false;

  void getUserData() async {
    getUserDataLoading = true;
    emit(GetUserDataLoadingState());

    final response = await _authRemoteDataSource.getUserData();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getUserDataLoading = false;
        emit(
          GetUserDataErrorState(error: l.baseErrorModel.message),
        );
      },
      (r) async {
        getUserDataLoading = false;
        emit(
          GetUserDataSuccessState(getUserDatModel: r),
        );
      },
    );
  }

  bool getAppSettingsLoading = false;

  GetAppSettingModel? getAppSettingModel;

  void getAppSettings() async {
    getAppSettingsLoading = true;
    emit(GetSettingsLoadingState());

    final response = await _authRemoteDataSource.getAppSettings();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getAppSettingsLoading = false;
        emit(GetSettingsErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        getAppSettingModel = r;
        getAppSettingsLoading = false;
        emit(GetSettingsSuccessState());
      },
    );
  }

  void getAcknowledge() async {
    getAppSettingsLoading = true;
    emit(GetAcknowledgeLoadingState());

    final response = await _authRemoteDataSource.getAcknowledge();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetAcknowledgeErrorState(error: l.baseErrorModel.message));
      },
      (r) async {
        emit(GetAcknowledgeSuccessState(data: r));
      },
    );
  }
}
