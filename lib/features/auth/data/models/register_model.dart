import 'package:weam/core/models/base_response_model.dart';

class RegisterModel extends BaseResponseModel{
  final int? code;
  final String? phone;
  const RegisterModel({required super.status, required super.message,this.code, this.phone,});


  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json["status"],
      message: json["msg"],
      code: json["code"],
      phone: json["phone"],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [super.props,code,phone,];
}