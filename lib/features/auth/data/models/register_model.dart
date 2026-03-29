import 'package:weam/core/models/base_response_model.dart';
import 'package:weam/features/auth/data/models/login_model.dart';

class RegisterModel extends BaseResponseModel {
  final int? code;
  final String? phone;
  final LoginDataModel? data;
  const RegisterModel({
    required super.status,
    required super.message,
    this.code,
    this.phone,
    this.data,
  });


  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json["status"],
      message: json["msg"],
      code: json["code"],
      phone: json["phone"],
      data: json["data"] != null ? LoginDataModel.fromJson(json["data"]) : null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        super.props,
        code,
        phone,
        data,
      ];
}