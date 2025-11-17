import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/models/base_response_model.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../features/auth/data/models/login_model.dart';

import '../../../../core/error/error_exception.dart';
import '../../../../core/network/api_end_points.dart';
import '../../../../core/network/error_message_model.dart';
import '../../../../core/parameters/auth_parameters/login_parameters.dart';
import '../../../../core/parameters/auth_parameters/register_parameters.dart';
import '../models/app_settings_model.dart';
import '../models/forget_password_model.dart';
import '../models/register_model.dart';
import '../models/user_data_model.dart';

class AuthRemoteDataSource {
  final DioHelper dioHelper;

  AuthRemoteDataSource({required this.dioHelper});

  Future<Either<ErrorException, LoginModel>> login({
    required LoginParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.login,
        data: FormData.fromMap(
          parameters.toJson(),
        ),
      );
      return Right(LoginModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  // Future<Either<ErrorException, BaseResponseModel>> sendOtp({
  //   required String otpCode,
  // }) async {
  //   try {
  //     final response = await dioHelper.postData(
  //       url: EndPoints.cities,
  //       data: FormData.fromMap(
  //         {
  //           "code": otpCode,
  //         },
  //       ),
  //     );
  //     print(response);
  //     return Right(
  //       BaseResponseModel.fromJson(
  //         response.data,
  //       ),
  //     );
  //   } catch (e) {
  //     if (e is DioException) {
  //       print(e);
  //       return Left(
  //         ErrorException(
  //           baseErrorModel: BaseErrorModel.fromJson(
  //             e.response!.data,
  //           ),
  //         ),
  //       );
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  Future<Either<ErrorException, RegisterModel>> register({
    required RegisterParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.register,
        data: FormData.fromMap(
          await parameters.toJson(),
        ),
      );
      return Right(RegisterModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, RegisterModel>> changeForgetPassword({
    required String userId,
    required String password,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.register,
        data: FormData.fromMap({
          "user_id": userId,
          "password": password,
        }),
      );
      return Right(RegisterModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, BaseResponseModel>> updateUserData({
    required RegisterParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.updateData,
        data: FormData.fromMap(
          await parameters.toJson(),
        ),
      );
      return Right(BaseResponseModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, GetAppSettingModel>> getAppSettings() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.getSettings,
      );
      return Right(GetAppSettingModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, String>> getAcknowledge() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.acknowledgment,
      );
      final ack = response.data['data']['acknowledgment'] as String;
      return Right(ack);
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, GetUserDatModel>> getUserData() async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.userData,
      );
      return Right(GetUserDatModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, ForgetPasswordModel>> checkForget({
    String? phone,
  }) async {
    try {
      final response = await dioHelper.postData(
          url: "/check_forget",
          data: FormData.fromMap({
            "phone": phone,
          }));
      return Right(ForgetPasswordModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }
}
