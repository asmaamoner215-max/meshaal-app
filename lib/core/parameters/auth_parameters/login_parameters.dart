import 'package:equatable/equatable.dart';

class LoginParameters extends Equatable {
  final String? deviceToken;
  final String? mobileNumber;
  final String? password;

  const LoginParameters({
    this.deviceToken,
    this.mobileNumber,
    this.password,
  });

  Map<String, dynamic> toJson()  {
    return {
      if(deviceToken!=null)"device_token": deviceToken,
      "phone": mobileNumber,
      "password": password,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    deviceToken,
    mobileNumber,
    password,
  ];
}
