import 'package:equatable/equatable.dart';

class BaseErrorModel extends Equatable {
  final String message;
  final bool status;
  const BaseErrorModel({
    required this.message,
    required this.status,
  });

  factory BaseErrorModel.fromJson(Map<String, dynamic> json) {
    return BaseErrorModel(
      message: _stringFromJson(json['message'] ?? json['msg']) ?? 'حدث خطأ غير معروف',
      status: _boolFromJson(json['status']) ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "msg": message,
      "status": status,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        message,
        status,
      ];
}

// Helpers for defensive parsing of error payloads
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
