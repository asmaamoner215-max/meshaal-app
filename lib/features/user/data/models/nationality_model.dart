import 'package:equatable/equatable.dart';
import 'package:weam/core/models/base_response_model.dart';
class GetNationalityModel extends BaseResponseModel<List<Nationality>?>{
  const GetNationalityModel({required super.status, required super.message,required super.data,});


  factory GetNationalityModel.fromJson(Map<String, dynamic> json) {
    return GetNationalityModel(
      status: json["status"],
      message: json["msg"], data: json["data"]!=null?List<Nationality>.from(json["data"].map((e) => Nationality.fromJson(e)),): null,
    );
  }

}

class Nationality extends Equatable {
  final int id;
  final String icon;
  final String active;
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
      id: json['id'],
      icon: json['icon'],
      active: json['active'],
      groupName: json['group_name'],
      name: json['name'],
      iconUrl: json['icon_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      nameWeb: json['name_web'],
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
