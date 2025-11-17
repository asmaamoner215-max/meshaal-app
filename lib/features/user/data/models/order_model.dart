import 'package:equatable/equatable.dart';

import 'client_model.dart';

class OrderModel extends Equatable {
  final int? id;
  final String? serviceId;
  final String? subServiceId;
  final String? type;
  final String? userId;
  final String? driverId;
  final String? doctorId;
  final String? payMethod;
  final String? pay;
  final String? transactionId;
  final String? payData;
  final String? platNum;
  final String? saleTotal;
  final String? taxTotal;
  final String? sale;
  final String? tax;
  final String? total;
  final String? status;
  final String? orderDate;
  final String? orderTime;
  final String? formLat;
  final String? formLong;
  final String? formAddres;
  final String? toLat;
  final String? toLong;
  final String? toAddres;
  final String? toAddresName;
  final String? makkah;
  final String? trip;
  final String? patientName;
  final String? sex;
  final String? natId;
  final String? relationText;
  final String? weight;
  final String? infectiousDiseases;
  final String? needsOxygen;
  final String? urinaryCatheter;
  final String? bookingFlight;
  final String? bookingImage;
  final String? doctor;
  final String? waitMinutes;
  final String? waitMinutesBack;
  final String? waitMinutesPrice;
  final String? waitMinutesBackPrice;
  final String? km;
  final String? changeKm;
  final String? changeKmPrice;
  final String? smsWallet;
  final String? price;
  final String? doctorPrice;
  final String? changeTaxPrice;
  final String? changeLat;
  final String? changeLong;
  final String? changeAddres;
  final String? changeAddresName;
  final String? active;
  final String? createdAt;
  final String? updatedAt;
  final String? code;
  final String? statusName;
  final String? date;
  final String? method;
  final String? time;
  final String? fatoraName;
  final String? driverName;
  final ClientData? clientData;
  final String? serviceName;
  final String? subServiceName;

  const OrderModel({
    this.id,
    this.serviceId,
    this.subServiceId,
    this.type,
    this.userId,
    this.driverId,
    this.doctorId,
    this.platNum,
    this.payMethod,
    this.pay,
    this.transactionId,
    this.payData,
    this.saleTotal,
    this.taxTotal,
    this.sale,
    this.tax,
    this.total,
    this.status,
    this.orderDate,
    this.orderTime,
    this.formLat,
    this.formLong,
    this.formAddres,
    this.toLat,
    this.toLong,
    this.toAddres,
    this.toAddresName,
    this.makkah,
    this.trip,
    this.patientName,
    this.sex,
    this.natId,
    this.relationText,
    this.weight,
    this.infectiousDiseases,
    this.needsOxygen,
    this.urinaryCatheter,
    this.bookingFlight,
    this.bookingImage,
    this.doctor,
    this.waitMinutes,
    this.waitMinutesBack,
    this.waitMinutesPrice,
    this.waitMinutesBackPrice,
    this.km,
    this.changeKm,
    this.changeKmPrice,
    this.smsWallet,
    this.price,
    this.doctorPrice,
    this.changeTaxPrice,
    this.changeLat,
    this.changeLong,
    this.changeAddres,
    this.changeAddresName,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.statusName,
    this.date,
    this.method,
    this.time,
    this.fatoraName,
    this.driverName,
    this.clientData,
    this.serviceName,
    this.subServiceName,
  });

  @override
  List<Object?> get props => [
    id,
    serviceId,
    subServiceId,
    type,
    userId,
    driverId,
    doctorId,
    payMethod,
    pay,
    transactionId,
    payData,
    saleTotal,
    taxTotal,
    sale,
    tax,
    total,
    status,
    orderDate,
    orderTime,
    formLat,
    formLong,
    formAddres,
    toLat,
    toLong,
    toAddres,
    toAddresName,
    makkah,
    trip,
    patientName,
    sex,
    natId,
    relationText,
    weight,
    infectiousDiseases,
    needsOxygen,
    urinaryCatheter,
    bookingFlight,
    bookingImage,
    doctor,
    waitMinutes,
    waitMinutesBack,
    waitMinutesPrice,
    waitMinutesBackPrice,
    km,
    changeKm,
    changeKmPrice,
    smsWallet,
    price,
    doctorPrice,
    changeTaxPrice,
    changeLat,
    changeLong,
    changeAddres,
    changeAddresName,
    active,
    createdAt,
    updatedAt,
    code,
    statusName,
    date,
    method,
    time,
    fatoraName,
    driverName,
    clientData,
    serviceName,
    subServiceName,
    platNum,
  ];

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int?,
      serviceId: json['service_id'] as String?,
      subServiceId: json['sub_service_id'] as String?,
      type: json['type'] as String?,
      userId: json['user_id'] as String?,
      driverId: json['driver_id'] as String?,
      doctorId: json['doctor_id'] as String?,
      payMethod: json['pay_method'] as String?,
      pay: json['pay'] as String?,
      transactionId: json['transaction_id'] as String?,
      payData: json['pay_data'] as String?,
      saleTotal: json['sale_total'] as String?,
      taxTotal: json['tax_total'] as String?,
      sale: json['sale'] as String?,
      platNum: json['plat_num'] as String?,
      tax: json['tax'] as String?,
      total: json['total'] as String?,
      status: json['status'] as String?,
      orderDate: json['order_date'] as String?,
      orderTime: json['order_time'] as String?,
      formLat: json['form_lat'] as String?,
      formLong: json['form_long'] as String?,
      formAddres: json['form_addres'] as String?,
      toLat: json['to_lat'] as String?,
      toLong: json['to_long'] as String?,
      toAddres: json['to_addres'] as String?,
      toAddresName: json['to_addres_name'] as String?,
      makkah: json['makkah'] as String?,
      trip: json['trip'] as String?,
      patientName: json['patient_name'] as String?,
      sex: json['sex'] as String?,
      natId: json['nat_id'] as String?,
      relationText: json['relation_text'] as String?,
      weight: json['weight'] as String?,
      infectiousDiseases: json['infectious_diseases'] as String?,
      needsOxygen: json['needs_oxygen'] as String?,
      urinaryCatheter: json['urinary_catheter'] as String?,
      bookingFlight: json['booking_flight'] as String?,
      bookingImage: json['booking_image'] as String?,
      doctor: json['doctor'] as String?,
      waitMinutes: json['wait_minutes'] as String?,
      waitMinutesBack: json['wait_minutes_back'] as String?,
      waitMinutesPrice: json['wait_minutes_price'] as String?,
      waitMinutesBackPrice: json['wait_minutes_back_price'] as String?,
      km: json['km'] as String?,
      changeKm: json['change_km'] as String?,
      changeKmPrice: json['change_km_price'] as String?,
      smsWallet: json['sms_wallet'] as String?,
      price: json['price'] as String?,
      doctorPrice: json['doctor_price'] as String?,
      changeTaxPrice: json['change_tax_price'] as String?,
      changeLat: json['change_lat'] as String?,
      changeLong: json['change_long'] as String?,
      changeAddres: json['change_addres'] as String?,
      changeAddresName: json['change_addres_name'] as String?,
      active: json['active'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      code: json['code'] as String?,
      statusName: json['status_name'] as String?,
      date: json['date'] as String?,
      method: json['method'] as String?,
      time: json['time'] as String?,
      fatoraName: json['fatora_name'] as String?,
      driverName: json['driver_name'] as String?,
      clientData: json['client_data'] != null
          ? ClientData.fromJson(json['client_data'] as Map<String, dynamic>)
          : null,
      serviceName: json['service_name'] as String?,
      subServiceName: json['sub_service_name'] as String?,
    );
  }
}


