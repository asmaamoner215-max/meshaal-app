import 'package:equatable/equatable.dart';
import 'package:weam/core/models/base_response_model.dart';
class GetNationalityModel extends BaseResponseModel<List<Nationality>?>{
  const GetNationalityModel({required super.status, required super.message,required super.data,});


  factory GetNationalityModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"] as List?;
    return GetNationalityModel(
      status: _boolFromJson(json["status"]),
      message: _stringFromJson(json["msg"] ?? json["message"]),
      data: data != null
          ? data
              .whereType<Map>()
              .map((e) => Nationality.fromJson(Map<String, dynamic>.from(e)))
              .toList()
          : null,
    );
  }

}

class Nationality extends Equatable {
  final int id;
  final String icon;
  final int active;
  final String groupName;
  final String name;
  final String iconUrl;
  final String createdAt;
  final String updatedAt;
  final String nameWeb;

  const Nationality({
    required this.id,
    required this.icon,
    required this.active,
    required this.groupName,
    required this.name,
    required this.iconUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.nameWeb,
  });

  @override
  List<Object?> get props => [
    id,
    icon,
    active,
    groupName,
    name,
    iconUrl,
    createdAt,
    updatedAt,
    nameWeb,
  ];

  factory Nationality.fromJson(Map<String, dynamic> json) {
    return Nationality(
      id: _intFromJson(json['id']) ?? 0,
      icon: _stringFromJson(json['icon']) ?? '',
      active: _intFromJson(json['active']) ?? 0,
      groupName: _stringFromJson(json['group_name']) ?? '',
      name: _stringFromJson(json['name']) ?? '',
      iconUrl: _stringFromJson(json['icon_url']) ?? '',
      createdAt: _stringFromJson(json['created_at']) ?? '',
      updatedAt: _stringFromJson(json['updated_at']) ?? '',
      nameWeb: _stringFromJson(json['name_web']) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'active': active,
      'group_name': groupName,
      'name': name,
      'icon_url': iconUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name_web': nameWeb,
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
