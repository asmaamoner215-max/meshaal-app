import 'package:equatable/equatable.dart';
import 'package:weam/core/models/base_response_model.dart';

class GetServicesModel extends BaseResponseModel <List<ServiceDataModel>?>{
  const GetServicesModel({required super.status, required super.message,super.data,});


  factory GetServicesModel.fromJson(Map<String, dynamic> json) {
    return GetServicesModel(
      status: json['status'],
      message: json['msg'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [status, data];
}

class ServiceDataModel extends Equatable {
  final int? id;
  final String? icon;
  final String? titleAr;
  final String? titleEn;
  final String? descAr;
  final String? descEn;
  final String? image;
  final String? active;
  final String? createdAt;
  final String? updatedAt;
  final String? title;
  final String? imageUrl;
  final String? titleWeb;
  final List<ServiceSubModel>? subs;

  const ServiceDataModel({
    this.id,
    this.icon,
    this.titleAr,
    this.titleEn,
    this.descAr,
    this.descEn,
    this.image,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.imageUrl,
    this.titleWeb,
    this.subs,
  });

  factory ServiceDataModel.fromJson(Map<String, dynamic> json) {
    try {
      return ServiceDataModel(
        id: json['id'] as int?,
        icon: json['icon']?.toString(),
        titleAr: json['title_ar'] as String?,
        titleEn: json['title_en'] as String?,
        descAr: json['desc_ar'] as String?,
        descEn: json['desc_en'] as String?,
        image: json['image']?.toString(),
        active: json['active']?.toString(),
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        title: json['title'] as String?,
        imageUrl: json['image_url']?.toString(),
        titleWeb: json['title_web'] as String?,
        subs: (json['servicesubs'] as List<dynamic>?)
            ?.map((e) => ServiceSubModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Object?> get props => [
    id,
    icon,
    titleAr,
    titleEn,
    descAr,
    descEn,
    image,
    active,
    createdAt,
    updatedAt,
    title,
    imageUrl,
    titleWeb,
    subs,
  ];
}

class ServiceSubModel extends Equatable {
  final int? id;
  final String? price;
  final int? serviceId;
  final String? image;
  final String? nameAr;
  final String? nameEn;
  final String? specializationShorteAr;
  final String? specializationAr;
  final String? cityId;
  final String? aboutAr;
  final String? experienceAr;
  final String? subspecialtiesAr;
  final String? fromTime;
  final String? toTime;
  final String? specializationShorteEn;
  final String? specializationEn;
  final String? aboutEn;
  final String? experienceEn;
  final String? subspecialtiesEn;
  final String? active;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? nameWeb;
  final String? specializationShorte;
  final String? specialization;
  final String? imageUrl;
  final String? about;
  final String? experience;
  final String? subspecialties;

  const ServiceSubModel({
    this.id,
    this.price,
    this.serviceId,
    this.image,
    this.nameAr,
    this.nameEn,
    this.specializationShorteAr,
    this.specializationAr,
    this.cityId,
    this.aboutAr,
    this.experienceAr,
    this.subspecialtiesAr,
    this.fromTime,
    this.toTime,
    this.specializationShorteEn,
    this.specializationEn,
    this.aboutEn,
    this.experienceEn,
    this.subspecialtiesEn,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.nameWeb,
    this.specializationShorte,
    this.specialization,
    this.imageUrl,
    this.about,
    this.experience,
    this.subspecialties,
  });

  factory ServiceSubModel.fromJson(Map<String, dynamic> json) {
    return ServiceSubModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      price: json['price']?.toString(),
      serviceId: json['service_id'] != null ? int.parse(json['service_id'].toString()) : null,
      image: json['image']?.toString(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      specializationShorteAr: json['specialization_shorte_ar'] as String?,
      specializationAr: json['specialization_ar'] as String?,
      cityId: json['city_id']?.toString(),
      aboutAr: json['about_ar'] as String?,
      experienceAr: json['experience_ar'] as String?,
      subspecialtiesAr: json['subspecialties_ar'] as String?,
      fromTime: json['from_time'] as String?,
      toTime: json['to_time'] as String?,
      specializationShorteEn: json['specialization_shorte_en'] as String?,
      specializationEn: json['specialization_en'] as String?,
      aboutEn: json['about_en'] as String?,
      experienceEn: json['experience_en'] as String?,
      subspecialtiesEn: json['subspecialties_en'] as String?,
      active: json['active']?.toString(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      name: json['name'] as String?,
      nameWeb: json['name_web'] as String?,
      specializationShorte: json['specialization_shorte'] as String?,
      specialization: json['specialization'] as String?,
      imageUrl: json['image_url']?.toString(),
      about: json['about'] as String?,
      experience: json['experience'] as String?,
      subspecialties: json['subspecialties'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    id,
    price,
    serviceId,
    image,
    nameAr,
    nameEn,
    specializationShorteAr,
    specializationAr,
    cityId,
    aboutAr,
    experienceAr,
    subspecialtiesAr,
    fromTime,
    toTime,
    specializationShorteEn,
    specializationEn,
    aboutEn,
    experienceEn,
    subspecialtiesEn,
    active,
    createdAt,
    updatedAt,
    name,
    nameWeb,
    specializationShorte,
    specialization,
    imageUrl,
    about,
    experience,
    subspecialties,
  ];
}
