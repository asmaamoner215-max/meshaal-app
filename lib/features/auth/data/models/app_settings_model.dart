import 'package:equatable/equatable.dart';

import '../../../../core/models/base_response_model.dart';

class GetAppSettingModel extends BaseResponseModel<AppSettings> {
  const GetAppSettingModel({
    required super.status,
    required super.message,
    super.data,
  });

  factory GetAppSettingModel.fromJson(Map<String, dynamic> json) {
    final data = _mapFromJson(json["data"]);
    return GetAppSettingModel(
      status: _boolFromJson(json["status"]),
      message: _stringFromJson(json["msg"]),
      data: data != null ? AppSettings.fromJson(data) : null,
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
      email: _stringFromJson(json['email']),
      phone: _stringFromJson(json['phone']),
      watsapp: _stringFromJson(json['watsapp']),
      android: _stringFromJson(json['android']),
      ios: _stringFromJson(json['ios']),
      introTitle: _stringFromJson(json['intro_title']),
      introDesc: _stringFromJson(json['intro_desc']),
      abouts: _listFromJson(json['abouts'])
          ?.map((e) => Abouts.fromJson(e))
          .toList(),
      termsUser: _listFromJson(json['terms_user'])
          ?.map((e) => Terms.fromJson(e))
          .toList(),
      termsDelegate: _listFromJson(json['terms_delegate'])
          ?.map((e) => Terms.fromJson(e))
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
      id: _intFromJson(json['id']),
      titleAr: _stringFromJson(json['title_ar']),
      titleEn: _stringFromJson(json['title_en']),
      descAr: _stringFromJson(json['desc_ar']),
      descEn: _stringFromJson(json['desc_en']),
      image: _stringFromJson(json['image']),
      type: _stringFromJson(json['type']),
      user: _stringFromJson(json['user']),
      active: _stringFromJson(json['active']),
      createdAt: _stringFromJson(json['created_at']),
      updatedAt: _stringFromJson(json['updated_at']),
      name: _stringFromJson(json['name']),
      desc: _stringFromJson(json['desc']),
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
      id: _intFromJson(json['id']),
      titleAr: _stringFromJson(json['title_ar']),
      titleEn: _stringFromJson(json['title_en']),
      descAr: _stringFromJson(json['desc_ar']),
      descEn: _stringFromJson(json['desc_en']),
      image: _stringFromJson(json['image']),
      type: _stringFromJson(json['type']),
      user: _stringFromJson(json['user']),
      active: _stringFromJson(json['active']),
      createdAt: _stringFromJson(json['created_at']),
      updatedAt: _stringFromJson(json['updated_at']),
      name: _stringFromJson(json['name']),
      desc: _stringFromJson(json['desc']),
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

List<Map<String, dynamic>>? _listFromJson(dynamic value) {
  if (value == null) return null;
  if (value is List) {
    return value
        .where((e) => e is Map)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
  }
  return null;
}
