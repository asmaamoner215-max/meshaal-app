// ClientData model
import 'package:equatable/equatable.dart';

class ClientData extends Equatable {
  final String? name;
  final String? phone;
  final String? email;
  final String? image;

  const ClientData({this.name, this.phone, this.email, this.image});

  @override
  List<Object?> get props => [name, phone, email, image];

  factory ClientData.fromJson(Map<String, dynamic> json) {
    return ClientData(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
    );
  }
}
