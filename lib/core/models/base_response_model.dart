import 'package:equatable/equatable.dart';

class BaseResponseModel<T> extends Equatable {
  final bool? status;
  final String? message;
  final T? data;

  const BaseResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      status: json["status"],
      message: json["msg"],
    );
  }

  @override

  List<Object?> get props => [
    status,
    message,
    data,
  ];
}
