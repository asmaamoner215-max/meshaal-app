import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/cache_helper/cache_keys.dart';
import '../../../../core/cache_helper/shared_pref_methods.dart';
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
      final t0 = DateTime.now();
      final response = await dioHelper.postData(
        url: EndPoints.login,
        data: FormData.fromMap(parameters.toJson()),
      );
      final elapsed = DateTime.now().difference(t0).inMilliseconds;
      print('login duration: ${elapsed}ms');
      print('login response: ${response.data}');
      return Right(LoginModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        // e.response can be null on timeouts / network errors
        if (e.response?.data != null) {
          print('login error response: ${e.response!.data}');
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
              message: e.message ?? 'فشل الاتصال بالخادم، حاول لاحقاً',
              status: false,
            ),
          ),
        );
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
              message: 'حدث خطأ غير متوقع أثناء تسجيل الدخول: ${e.toString()}',
              status: false,
            ),
          ),
        );
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
      // التحقق من وجود التوكن قبل إرسال الطلب
      final token = CacheHelper.getData(key: CacheKeys.token);
      if (token == null || token.toString().isEmpty) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
              message: "لا يوجد توكن صالح، يرجى تسجيل الدخول مرة أخرى",
              status: false,
            ),
          ),
        );
      }

      final t0 = DateTime.now();
      final response = await dioHelper.getData(
        url: EndPoints.getSettings,
      );

      // طباعة الاستجابة للتشخيص
      print('getAppSettings response: ${response.data}');
      final elapsed = DateTime.now().difference(t0).inMilliseconds;
      print('getAppSettings duration: ${elapsed}ms');

      return Right(GetAppSettingModel.fromJson(response.data));
    } catch (e) {
      print('getAppSettings error: $e');
      if (e is DioException) {
        // التحقق من أن الاستجابة تحتوي على بيانات
        if (e.response?.data != null) {
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        } else {
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(
                message: "حدث خطأ في الاتصال بالخادم: ${e.message}",
                status: false,
              ),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
              message: "حدث خطأ غير متوقع: ${e.toString()}",
              status: false,
            ),
          ),
        );
      }
    }
  }

  Future<Either<ErrorException, String>> getAcknowledge() async {
    try {
      final t0 = DateTime.now();
      final response = await dioHelper.getData(
        url: EndPoints.acknowledgment,
      );
      final elapsed = DateTime.now().difference(t0).inMilliseconds;
      print('getAcknowledge duration: ${elapsed}ms');
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
      // التحقق من وجود التوكن قبل إرسال الطلب
      final token = CacheHelper.getData(key: CacheKeys.token);
      if (token == null || token.toString().isEmpty) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
              message: "لا يوجد توكن صالح، يرجى تسجيل الدخول مرة أخرى",
              status: false,
            ),
          ),
        );
      }

      final t0 = DateTime.now();
      final response = await dioHelper.postData(
        url: EndPoints.userData,
      );

      // طباعة الاستجابة للتشخيص
      print('getUserData response: ${response.data}');
      final elapsed = DateTime.now().difference(t0).inMilliseconds;
      print('getUserData duration: ${elapsed}ms');

      return Right(GetUserDatModel.fromJson(response.data));
    } catch (e) {
      print('getUserData error: $e');
      if (e is DioException) {
        // التحقق من أن الاستجابة تحتوي على بيانات
        if (e.response?.data != null) {
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        } else {
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(
                message: "حدث خطأ في الاتصال بالخادم: ${e.message}",
                status: false,
              ),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
              message: "حدث خطأ غير متوقع: ${e.toString()}",
              status: false,
            ),
          ),
        );
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
