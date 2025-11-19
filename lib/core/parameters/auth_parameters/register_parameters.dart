import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class RegisterParameters extends Equatable {
  final String? name;
  final String? phone;
  final File? image;
  final String? password;
  final String email;
  final String? type;
  final String? plateId;
  final String? deviceToken;
  final String? idNumber;

  const RegisterParameters({
    required this.name,
    this.image,
    required this.phone,
    required this.plateId,
    required this.deviceToken,
    required this.email,
    this.idNumber,
    required this.password,
    required this.type,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      "name": name,
      "phone": phone,
      if (password != null) "password": password,
      if (type != null) "type": type,
      "email": email,
      if (image != null)
        "image": await MultipartFile.fromFile(
          image!.path,
          filename: path.basename(
            image!.path,
          ),
        ),
      if (deviceToken != null) "device_token": deviceToken,
      if (plateId != null) "plate_num": plateId,
      if (idNumber != null) 'id_number': idNumber,
    };
  }

  @override
  List<Object?> get props => [
        name,
        phone,
        password,
        type,
      ];
}
