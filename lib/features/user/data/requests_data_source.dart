import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weam/features/user/data/models/relation_model.dart';

import '../../../core/models/base_response_model.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/parameters/requests_parameters/car_request_parameter.dart';
import 'models/get_order_model.dart';
import 'models/nationality_model.dart';
import 'models/order_model.dart';
import 'models/promo_code_model.dart';
import 'models/request_price_model.dart';

class RequestsDataSource {
  final DioHelper dioHelper;

  RequestsDataSource({required this.dioHelper});

  Future<Either<ErrorException, GetOrderModel>> sendCarRequest({
    required RequestAmpParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.postCarOrder,
        data: FormData.fromMap(
          await parameters.toJson(),
        ),
      );
      return Right(GetOrderModel.fromJson(response.data));
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

  Future<Either<ErrorException, BaseResponseModel>> sendVisitRequest({
    required RequestAmpParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.postOrdersServices,
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

  Future<Either<ErrorException, BaseResponseModel>> payWithWalletSMS({
    required String orderId,
    required String orderSMSCode,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.payWithWalletSMS,
        data: FormData.fromMap({
          "order_id": orderId,
          "code": orderSMSCode,
        }),
      );
      return Right(GetOrderModel.fromJson(response.data));
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

  Future<Either<ErrorException, RequestPriceModel>> requestPrice({
    required RequestAmpParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.requestPrice,
        data: FormData.fromMap(
          await parameters.toJson(),
        ),
      );
      return Right(RequestPriceModel.fromJson(response.data));
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

  Future<Either<ErrorException, RequestPriceModel>> changeDestPrice({
    required String orderId,
    required String lat,
    required String long,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: "/get_change_dest_price",
        data: FormData.fromMap(
          {
            "order_id": orderId,
            "lat": lat,
            "long": long,
          },
        ),
      );
      return Right(RequestPriceModel.fromJson(response.data));
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

  Future<Either<ErrorException, PromoModel>> addPromoCode({
    required String coupon,
    required String total,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: "/check_coupon",
        data: FormData.fromMap(
          {
            "coupon": coupon,
            "total": total,
          },
        ),
      );
      return Right(PromoModel.fromJson(response.data));
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

  Future<Either<ErrorException, RequestPriceModel>> changeDestination({
    required String orderId,
    required String lat,
    required String long,
    required String addressName,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.changeDestination,
        data: FormData.fromMap(
          {
            "order_id": orderId,
            "lat": lat,
            "long": long,
            "addres_text": addressName,
            "addres_name": addressName,
          },
        ),
      );
      return Right(RequestPriceModel.fromJson(response.data));
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

  Future<Either<ErrorException, GetNationalityModel>> getNationality() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.getNationality,
      );
      return Right(GetNationalityModel.fromJson(response.data));
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

  Future<Either<ErrorException, List<RelationModel>>> getRelationList() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.relationData,
      );
      final data = response.data;
      List<RelationModel> list = List.from(data['data'].map((e) => RelationModel.fromJson(e)));
      return Right(list);
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
