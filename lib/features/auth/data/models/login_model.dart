import 'package:equatable/equatable.dart';
import '../../../../core/models/base_response_model.dart';

class LoginModel extends BaseResponseModel<LoginDataModel> {
  const LoginModel({required super.status, required super.message, super.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final data = _mapFromJson(json["data"]);
    return LoginModel(
      status: _boolFromJson(json["status"]),
      message: _stringFromJson(json["msg"] ?? json["message"]),
      data: data != null ? LoginDataModel.fromJson(data) : null,
    );
  }
}
class LoginDataModel extends Equatable {
  final int? id;
  final String? type;
  final String? name;
  final String? email;
  final String? active;
  final String? phone;
  final String? img;
  final DateTime? createdAt;
  final String? language;
  final double? latitude;
  final double? longitude;
  final String? addressText;
  final String? gogleImage;
  final String? gogleName;
  final String? identityToken;
  final String? userIdentifier;
  final String? plateNum;
  final String? token;
  final int? countNotfy;
  final int? ordersCount;
  final int? countWalet;
  final String? imageUrl;

  const LoginDataModel({
    this.id,
    this.type,
    this.name,
    this.email,
    this.active,
    this.phone,
    this.img,
    this.createdAt,
    this.language,
    this.latitude,
    this.longitude,
    this.addressText,
    this.gogleImage,
    this.gogleName,
    this.identityToken,
    this.userIdentifier,
    this.plateNum,
    this.token,
    this.countNotfy,
    this.ordersCount,
    this.countWalet,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    name,
    email,
    active,
    phone,
    img,
    createdAt,
    language,
    latitude,
    longitude,
    addressText,
    gogleImage,
    gogleName,
    identityToken,
    userIdentifier,
    plateNum,
    token,
    countNotfy,
    ordersCount,
    countWalet,
    imageUrl,
  ];

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      id: _intFromJson(json['id']),
      type: _stringFromJson(json['type']),
      name: _stringFromJson(json['name']),
      email: _stringFromJson(json['email']),
      active: _stringFromJson(json['active']),
      phone: _stringFromJson(json['phone']),
      img: _stringFromJson(json['img']),
      createdAt: _parseDate(json['created_at']),
      language: _stringFromJson(json['language']),
      latitude: json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null,
      longitude: json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null,
      addressText: _stringFromJson(json['address_text']),
      gogleImage: _stringFromJson(json['gogle_image']),
      gogleName: _stringFromJson(json['gogle_name']),
      identityToken: _stringFromJson(json['identityToken']),
      userIdentifier: _stringFromJson(json['userIdentifier']),
      plateNum: _stringFromJson(json['plate_num']),
      token: _stringFromJson(json['token']),
      countNotfy: _intFromJson(json['count_notfy']),
      ordersCount: _intFromJson(json['orders_count']),
      countWalet: _intFromJson(json['count_walet']),
      imageUrl: _stringFromJson(json['image_url']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'email': email,
      'active': active,
      'phone': phone,
      'img': img,
      'created_at': createdAt?.toIso8601String(),
      'language': language,
      'latitude': latitude,
      'longitude': longitude,
      'address_text': addressText,
      'gogle_image': gogleImage,
      'gogle_name': gogleName,
      'identityToken': identityToken,
      'userIdentifier': userIdentifier,
      'plate_num': plateNum,
      'token': token,
      'count_notfy': countNotfy,
      'orders_count': ordersCount,
      'count_walet': countWalet,
      'image_url': imageUrl,
    };
  }
}

// Helpers
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

int? _intFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

Map<String, dynamic>? _mapFromJson(dynamic value) {
  if (value == null) return null;
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return null;
}

DateTime? _parseDate(dynamic value) {
  final s = _stringFromJson(value);
  if (s == null || s.isEmpty) return null;
  try {
    return DateTime.parse(s);
  } catch (_) {
    return null;
  }
}
