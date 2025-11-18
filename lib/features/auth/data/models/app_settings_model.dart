import 'package:equatable/equatable.dart';

import '../../../../core/models/base_response_model.dart';
class GetAppSettingModel extends BaseResponseModel<AppSettings>{
  const GetAppSettingModel({required super.status, required super.message,super.data,});

  factory GetAppSettingModel.fromJson(Map<String, dynamic> json) {
    return GetAppSettingModel(
      status: json["status"],
      message: json["msg"],
      data: AppSettings.fromJson(json["data"]),
    );
  }
}
class AppSettings extends Equatable {
  final String? email;
  final String? phone;
  final String? watsapp;
  final String? android;
  final String? ios;
  final String? introTitle;
  final String? introDesc;
  final List<Abouts>? abouts;
  final List<Terms>? termsUser;
  final List<Terms>? termsDelegate;

  const AppSettings({
    this.email,
    this.phone,
    this.watsapp,
    this.android,
    this.ios,
    this.introTitle,
    this.introDesc,
    this.abouts,
    this.termsUser,
    this.termsDelegate,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      watsapp: json['watsapp'] as String?,
      android: json['android'] as String?,
      ios: json['ios'] as String?,
      introTitle: json['intro_title'] as String?,
      introDesc: json['intro_desc'] as String?,
      abouts: (json['abouts'] as List<dynamic>?)
          ?.map((e) => Abouts.fromJson(e as Map<String, dynamic>))
          .toList(),
      termsUser: (json['terms_user'] as List<dynamic>?)
          ?.map((e) => Terms.fromJson(e as Map<String, dynamic>))
          .toList(),
      termsDelegate: (json['terms_delegate'] as List<dynamic>?)
          ?.map((e) => Terms.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    email,
    phone,
    watsapp,
    android,
    ios,
    introTitle,
    introDesc,
    abouts,
    termsUser,
    termsDelegate,
  ];
}

class Abouts extends Equatable {
  final int? id;
  final String? titleAr;
  final String? titleEn;
  final String? descAr;
  final String? descEn;
  final String? image;
  final String? type;
  final String? user;
  final String? active;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? desc;

  const Abouts({
    this.id,
    this.titleAr,
    this.titleEn,
    this.descAr,
    this.descEn,
    this.image,
    this.type,
    this.user,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.desc,
  });

  factory Abouts.fromJson(Map<String, dynamic> json) {
    return Abouts(
      id: json['id'] as int?,
      titleAr: json['title_ar'] as String?,
      titleEn: json['title_en'] as String?,
      descAr: json['desc_ar'] as String?,
      descEn: json['desc_en'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      user: json['user'] as String?,
      active: json['active'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    id,
    titleAr,
    titleEn,
    descAr,
    descEn,
    image,
    type,
    user,
    active,
    createdAt,
    updatedAt,
    name,
    desc,
  ];
}

class Terms extends Equatable {
  final int? id;
  final String? titleAr;
  final String? titleEn;
  final String? descAr;
  final String? descEn;
  final String? image;
  final String? type;
  final String? user;
  final String? active;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? desc;

  const Terms({
    this.id,
    this.titleAr,
    this.titleEn,
    this.descAr,
    this.descEn,
    this.image,
    this.type,
    this.user,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.desc,
  });

  factory Terms.fromJson(Map<String, dynamic> json) {
    return Terms(
      id: json['id'] as int?,
      titleAr: json['title_ar'] as String?,
      titleEn: json['title_en'] as String?,
      descAr: json['desc_ar'] as String?,
      descEn: json['desc_en'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      user: json['user'] as String?,
      active: json['active'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    id,
    titleAr,
    titleEn,
    descAr,
    descEn,
    image,
    type,
    user,
    active,
    createdAt,
    updatedAt,
    name,
    desc,
  ];
}
