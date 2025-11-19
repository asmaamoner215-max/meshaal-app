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
      status: _boolFromJson(json["status"]),
      message: _stringFromJson(json["msg"] ?? json["message"]),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    status,
    message,
    data,
  ];
}

// Helpers for robust parsing across varied backend responses
bool? _boolFromJson(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is int) return value != 0;
  if (value is String) {
    final v = value.toLowerCase();
    if (v == 'true' || v == '1') return true;
    if (v == 'false' || v == '0') return false;
  }
  return null;
}

String? _stringFromJson(dynamic value) => value?.toString();
