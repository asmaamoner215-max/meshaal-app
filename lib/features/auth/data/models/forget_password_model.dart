import 'package:weam/core/models/base_response_model.dart';

class ForgetPasswordModel extends BaseResponseModel<int>{
  final int code;

  const ForgetPasswordModel({required super.status, required super.message,required super.data,required this.code});

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      status: json["status"],
      message: json["msg"],
      data: json["data"],
      code: json["code"],
    );
  }

}
