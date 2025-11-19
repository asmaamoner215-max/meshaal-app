import 'package:weam/core/models/base_response_model.dart';

import 'order_model.dart';

class GetMyInvoicesModel extends BaseResponseModel<List<OrderModel>> {
  const GetMyInvoicesModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory GetMyInvoicesModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    List<OrderModel>? list;
    if (data is List) {
      list = data
          .where((e) => e is Map)
          .map((e) => OrderModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } else {
      list = const [];
    }
    return GetMyInvoicesModel(
      status: json["status"] == true || json["status"] == 1 || json["status"] == '1',
      message: json["msg"]?.toString(),
      data: list,
    );
  }
}
