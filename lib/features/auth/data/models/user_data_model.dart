import 'package:equatable/equatable.dart';

import '../../../../core/models/base_response_model.dart';

class GetUserDatModel extends BaseResponseModel<UserDataModel> {
  const GetUserDatModel({
    required super.status,
    required super.message,
    super.data,
  });

  factory GetUserDatModel.fromJson(Map<String, dynamic> json) {
    final data = _mapFromJson(json["data"]);
    return GetUserDatModel(
      status: _boolFromJson(json["status"]),
      message: _stringFromJson(json["msg"]),
      data: data != null ? UserDataModel.fromJson(data) : null,
    );
  }

  static bool? _boolFromJson(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) {
      final lower = value.toLowerCase();
      if (lower == '1' || lower == 'true') return true;
      if (lower == '0' || lower == 'false') return false;
    }
    return null;
  }

  static String? _stringFromJson(dynamic value) {
    return value?.toString();
  }

  static Map<String, dynamic>? _mapFromJson(dynamic value) {
    if (value == null) return null;
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return null;
  }
}

class UserDataModel extends Equatable {
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
  final int? countNotfy;
  final int? countWalet;
  final String? imageUrl;

  const UserDataModel({
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
    this.countNotfy,
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
        countNotfy,
        countWalet,
        imageUrl,
      ];

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
        id: _intFromJson(json['id']),
        type: _stringFromJson(json['type']),
        name: _stringFromJson(json['name']),
        email: _stringFromJson(json['email']),
        active: _stringFromJson(json['active']),
        phone: _stringFromJson(json['phone']),
        img: _stringFromJson(json['img']),
        createdAt: _dateTimeFromJson(json['created_at']),
        language: _stringFromJson(json['language']),
        latitude: _doubleFromJson(json['latitude']),
        longitude: _doubleFromJson(json['longitude']),
        addressText: _stringFromJson(json['address_text']),
        gogleImage: _stringFromJson(json['gogle_image']),
        gogleName: _stringFromJson(json['gogle_name']),
        identityToken: _stringFromJson(json['identityToken']),
        userIdentifier: _stringFromJson(json['userIdentifier']),
        plateNum: _stringFromJson(json['plate_num']),
        countNotfy: _intFromJson(json['count_notfy']),
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
      'count_notfy': countNotfy,
      'count_walet': countWalet,
      'image_url': imageUrl,
    };
  }

  static String? _stringFromJson(dynamic value) {
    return value?.toString();
  }

  static int? _intFromJson(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static double? _doubleFromJson(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    return double.tryParse(value.toString());
  }

  static DateTime? _dateTimeFromJson(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    final data = value.toString();
    final parsed = DateTime.tryParse(data);
    if (parsed != null) return parsed;
    final numeric = int.tryParse(data);
    if (numeric == null) return null;
    final isSeconds = data.length <= 10;
    return DateTime.fromMillisecondsSinceEpoch(
      isSeconds ? numeric * 1000 : numeric,
    );
  }
}
