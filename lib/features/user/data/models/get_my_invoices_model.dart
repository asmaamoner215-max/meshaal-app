import 'package:weam/core/models/base_response_model.dart';

import 'order_model.dart';

class GetMyInvoicesModel extends BaseResponseModel<List<OrderModel>> {
  const GetMyInvoicesModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory GetMyInvoicesModel.fromJson(Map<String, dynamic> json) {
    return GetMyInvoicesModel(
      status: json["status"],
      message: json["msg"],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => OrderModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
