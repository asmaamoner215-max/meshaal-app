import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weam/core/cache_helper/cache_keys.dart';
import 'package:weam/core/cache_helper/shared_pref_methods.dart';
import 'package:weam/core/models/base_response_model.dart';
import 'package:weam/features/user/data/models/get_my_invoices_model.dart';

import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import 'models/get_my_travels_model.dart';
import 'models/order_model.dart';

class UserOrdersDataSource {
  final DioHelper dioHelper;

  UserOrdersDataSource({
    required this.dioHelper,
  });

  Future<Either<ErrorException, GetMyInvoicesModel>> getMyInvoices() async {
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
        url: EndPoints.myInvoices,
      );

      // طباعة الاستجابة للتشخيص
      print('getMyInvoices response: ${response.data}');
      final elapsed = DateTime.now().difference(t0).inMilliseconds;
      print('getMyInvoices duration: ${elapsed}ms');

      return Right(GetMyInvoicesModel.fromJson(response.data));
    } catch (e) {
      print('getMyInvoices error: $e');
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

  Future<Either<ErrorException, GetMyTravelsModel>> myTravels() async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.myTravels,
      );
      return Right(GetMyTravelsModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        print(e);
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

  Future<Either<ErrorException, OrderModel>> getOrderData({required String orderId}) async {
    try {
      final response = await dioHelper.postData(
          url: EndPoints.orderData,
          data: FormData.fromMap({
            "order_id": orderId,
          }));
      return Right(OrderModel.fromJson(response.data["data"]));
    } catch (e) {
      if (e is DioException) {
        print(e);
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

  Future<Either<ErrorException, BaseResponseModel>> cancelOrder({required String orderId}) async {
    try {
      final response = await dioHelper.postData(
          url: "/cancel_order",
          data: FormData.fromMap({
            "order_id": orderId,
          }));
      print(response);
      return Right(BaseResponseModel.fromJson(response.data["data"]));
    } catch (e) {
      if (e is DioException) {
        print(e);
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
