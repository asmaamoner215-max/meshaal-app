import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weam/core/models/base_response_model.dart';
import 'package:weam/features/user/data/models/get_my_invoices_model.dart';
import 'package:weam/features/user/data/models/order_model.dart';

import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../user/data/models/get_my_travels_model.dart';

class VendorOrdersDataSource {
  final DioHelper dioHelper;

  VendorOrdersDataSource({
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

  Future<Either<ErrorException, GetMyTravelsModel>> providerOrders() async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.providerOrders,
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

  Future<Either<ErrorException, BaseResponseModel>> waitMinutes(
      {required String orderId, required String minutes}) async {
    try {
      final response = await dioHelper.postData(
          url: "/wait_minutes",
          data: FormData.fromMap({
            "order_id": orderId,
            "minutes": minutes,
          }));
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

  Future<Either<ErrorException, OrderModel>> changeStatus(
      {required String orderId, required String status}) async {
    try {
      final response = await dioHelper.postData(
          url: EndPoints.changeStatus,
          data: FormData.fromMap({
            "order_id": orderId,
            "status": status,
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

  Future<Either<ErrorException, BaseResponseModel>> rateUser({
    required String orderId,
    required String comment,
    required String rate,
  }) async {
    try {
      final response = await dioHelper.postData(
          url: "/rate_user",
          data: FormData.fromMap({
            "order_id": orderId,
            "rate": rate,
            "comment": comment,
          }));
      return Right(BaseResponseModel.fromJson(response.data));
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
