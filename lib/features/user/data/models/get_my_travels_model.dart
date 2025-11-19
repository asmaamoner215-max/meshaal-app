import 'package:weam/core/models/base_response_model.dart';

import 'order_model.dart';

class GetMyTravelsModel extends BaseResponseModel<List<OrderModel>> {
  final List<OrderModel>? previous;
  const GetMyTravelsModel({
    required super.status,
    required super.message,
    required this.previous,
    required super.data,
  });

  factory GetMyTravelsModel.fromJson(Map<String, dynamic> json) {
    return GetMyTravelsModel(
      status: json["status"],
      message: json["msg"],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => OrderModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      previous: (json['previous'] as List<dynamic>?)
          ?.map((item) => OrderModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
