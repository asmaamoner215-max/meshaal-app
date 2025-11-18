import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
      final response = await dioHelper.postData(
        url: EndPoints.myInvoices,
      );
      return Right(GetMyInvoicesModel.fromJson(response.data));
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

  Future<Either<ErrorException, GetMyTravelsModel>> myTravels() async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.myTravels,
      );
      return Right(GetMyTravelsModel.fromJson(response.data));
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
      return Right(BaseResponseModel.fromJson(response.data["data"]));
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
