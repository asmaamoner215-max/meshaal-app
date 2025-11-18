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
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "msg": message,
      "status": status,
    };
  }

  @override

  List<Object?> get props => [
        message,
        status,
      ];
}
