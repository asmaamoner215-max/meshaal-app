import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class RequestAmpParameters extends Equatable {
  final String? orderDate;
  final String? orderTime;
  final double? formLat;
  final double? formLong;
  final String? formAddress;
  final double? toLat;
  final double? toLong;
  final String? toAddress;
  final String? toAddressName;
  final String? makkah;
  final String? trip;
  final String? patientName;
  final String? sex;
  final String? bedorchair;
  final String? floor;
  final String? mesaad;
  final String? details;
  final String? natId;
  final String? relationId;
  final String? couponId;
  final String? saleTotal;
  final String? sale;
  final String? weight;
  final String? infectiousDiseases;
  final String? needsOxygen;
  final String? urinaryCatheter;
  final String? bookingFlight;
  final File? bookingImage;
  final String? doctor;
  final String? payMethod;
  final String? transactionId;
  final String? payData;
  final String? serviceId;
  final String? subServiceId;

  const RequestAmpParameters({
    this.orderDate,
    this.orderTime,
    this.serviceId,
    this.formLat,
    this.formLong,
    this.mesaad,
    this.formAddress,
    this.toLat,
    this.toLong,
    this.toAddress,
    this.details,
    this.floor,
    this.bedorchair,
    this.toAddressName,
    this.makkah,
    this.trip,
    this.sale,
    this.couponId,
    this.saleTotal,
    this.patientName,
    this.sex,
    this.natId,
    this.relationId,
    this.weight,
    this.subServiceId,
    this.infectiousDiseases,
    this.needsOxygen,
    this.urinaryCatheter,
    this.bookingFlight,
    this.bookingImage,
    this.doctor,
    this.payMethod,
    this.transactionId,
    this.payData,
  });

  @override
  List<Object?> get props => [
        orderDate,
        orderTime,
        formLat,
        formLong,
        formAddress,
        toLat,
        bedorchair,
        toLong,
        toAddress,
        toAddressName,
        makkah,
        trip,
        patientName,
        sex,
        natId,
        relationId,
        weight,
        infectiousDiseases,
        needsOxygen,
        urinaryCatheter,
        bookingFlight,
        bookingImage,
        doctor,
        subServiceId,
        serviceId,
        floor,
        payMethod,
        mesaad,
        transactionId,
        details,
        payData,
      ];

  factory RequestAmpParameters.fromJson(Map<String, dynamic> json) {
    return RequestAmpParameters(
      orderDate: json['order_date'],
      orderTime: json['order_time'],
      formLat: json['form_lat'],
      details: json['details'],
      formLong: json['form_long'],
      mesaad: json['mesaad'],
      formAddress: json['form_address'],
      toLat: json['to_lat'],
      toLong: json['to_long'],
      floor: json['floor'],
      toAddress: json['to_address'],
      toAddressName: json['to_address_name'],
      makkah: json['makkah'],
      couponId: json['coupon_id'],
      saleTotal: json["sale_total"],
      sale: json["sale"],
      trip: json['trip'],
      patientName: json['patient_name'],
      sex: json['sex'],
      natId: json['nat_id'],
      bedorchair: json['bedorchair'],
      relationId: json['relation_text'],
      weight: json['weight'],
      infectiousDiseases: json['infectious_diseases'],
      needsOxygen: json['needs_oxygen'],
      urinaryCatheter: json['urinary_catheter'],
      bookingFlight: json['booking_flight'],
      bookingImage: json['booking_image'],
      doctor: json['doctor'],
      payMethod: json['pay_method'],
      transactionId: json['transaction_id'],
      payData: json['pay_data'],
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      if (orderDate != null) 'order_date': orderDate,
      if (orderTime != null) 'order_time': orderTime,
      if (formLat != null) 'form_lat': formLat,
      if (formLong != null) 'form_long': formLong,
      if (formAddress != null) 'form_address': formAddress,
      if (toLat != null) 'to_lat': toLat,
      if (serviceId != null) 'service_id': serviceId,
      if (subServiceId != null) 'sub_service_id': subServiceId,
      if (toLong != null) 'to_long': toLong,
      if (toAddress != null) 'to_address': toAddress,
      if (toAddressName != null) 'to_address_name': toAddressName,
      if (makkah != null) 'makkah': makkah,
      if (trip != null) 'trip': trip,
      if (patientName != null) 'patient_name': patientName,
      if (sex != null) 'sex': sex,
      if (bedorchair != null) 'bedorchair': bedorchair,
      if (floor != null) 'floor': floor,
      if (mesaad != null) 'mesaad': mesaad,
      if (details != null) 'details': details,
      if (natId != null) 'nat_id': natId,
      if (sale != null) 'sale': sale,
      if (saleTotal != null) 'sale_total': saleTotal,
      if (couponId != null) 'coupon_id': couponId,
      if (relationId != null) 'relation_text': relationId,
      if (weight != null) 'weight': weight,
      if (infectiousDiseases != null) 'infectious_diseases': infectiousDiseases,
      if (needsOxygen != null) 'needs_oxygen': needsOxygen,
      if (urinaryCatheter != null) 'urinary_catheter': urinaryCatheter,
      if (bookingFlight != null) 'booking_flight': bookingFlight,
      if (bookingImage != null)
        "booking_image": await MultipartFile.fromFile(
          bookingImage!.path,
          filename: path.basename(bookingImage!.path),
        ),
      if (doctor != null) 'doctor': doctor,
      if (payMethod != null) 'pay_method': payMethod,
      if (transactionId != null) 'transaction_id': transactionId,
      if (payData != null) 'pay_data': payData,
      if (relationId != null) 'relation_id': relationId,
    };
  }
}
