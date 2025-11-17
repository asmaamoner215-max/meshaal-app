import 'package:equatable/equatable.dart';

import '../../../../core/models/base_response_model.dart';

class GetUserDatModel extends BaseResponseModel<UserDataModel> {
  const GetUserDatModel({
    required super.status,
    required super.message,
    super.data,
  });

  factory GetUserDatModel.fromJson(Map<String, dynamic> json) {
    return GetUserDatModel(
      status: json["status"],
      message: json["msg"],
      data: UserDataModel.fromJson(json["data"]),
    );
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
      id: json['id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      active: json['active'] as String?,
      phone: json['phone'] as String?,
      img: json['img'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      language: json['language'] as String?,
      latitude: json['latitude'] != null
          ? double.parse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.parse(json['longitude'].toString())
          : null,
      addressText: json['address_text'] as String?,
      gogleImage: json['gogle_image'] as String?,
      gogleName: json['gogle_name'] as String?,
      identityToken: json['identityToken'] as String?,
      userIdentifier: json['userIdentifier'] as String?,
      plateNum: json['plate_num'] as String?,
      countNotfy: json['count_notfy'] as int?,
      countWalet: json['count_walet'] as int?,
      imageUrl: json['image_url'] as String?,
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
}
