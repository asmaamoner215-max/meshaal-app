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
      id: json['id'] is int ? json['id'] as int? : int.tryParse(json['id']?.toString() ?? ''),
      serviceId: json['service_id']?.toString(),
      subServiceId: json['sub_service_id']?.toString(),
      type: json['type']?.toString(),
      userId: json['user_id']?.toString(),
      driverId: json['driver_id']?.toString(),
      doctorId: json['doctor_id']?.toString(),
      payMethod: json['pay_method']?.toString(),
      pay: json['pay']?.toString(),
      transactionId: json['transaction_id']?.toString(),
      payData: json['pay_data']?.toString(),
      saleTotal: json['sale_total']?.toString(),
      taxTotal: json['tax_total']?.toString(),
      sale: json['sale']?.toString(),
      platNum: json['plat_num']?.toString(),
      tax: json['tax']?.toString(),
      total: json['total']?.toString(),
      status: json['status']?.toString(),
      orderDate: json['order_date']?.toString(),
      orderTime: json['order_time']?.toString(),
      formLat: json['form_lat']?.toString(),
      formLong: json['form_long']?.toString(),
      formAddres: json['form_addres']?.toString(),
      toLat: json['to_lat']?.toString(),
      toLong: json['to_long']?.toString(),
      toAddres: json['to_addres']?.toString(),
      toAddresName: json['to_addres_name']?.toString(),
      makkah: json['makkah']?.toString(),
      trip: json['trip']?.toString(),
      patientName: json['patient_name']?.toString(),
      sex: json['sex']?.toString(),
      natId: json['nat_id']?.toString(),
      relationText: json['relation_text']?.toString(),
      weight: json['weight']?.toString(),
      infectiousDiseases: json['infectious_diseases']?.toString(),
      needsOxygen: json['needs_oxygen']?.toString(),
      urinaryCatheter: json['urinary_catheter']?.toString(),
      bookingFlight: json['booking_flight']?.toString(),
      bookingImage: json['booking_image']?.toString(),
      doctor: json['doctor']?.toString(),
      waitMinutes: json['wait_minutes']?.toString(),
      waitMinutesBack: json['wait_minutes_back']?.toString(),
      waitMinutesPrice: json['wait_minutes_price']?.toString(),
      waitMinutesBackPrice: json['wait_minutes_back_price']?.toString(),
      km: json['km']?.toString(),
      changeKm: json['change_km']?.toString(),
      changeKmPrice: json['change_km_price']?.toString(),
      smsWallet: json['sms_wallet']?.toString(),
      price: json['price']?.toString(),
      doctorPrice: json['doctor_price']?.toString(),
      changeTaxPrice: json['change_tax_price']?.toString(),
      changeLat: json['change_lat']?.toString(),
      changeLong: json['change_long']?.toString(),
      changeAddres: json['change_addres']?.toString(),
      changeAddresName: json['change_addres_name']?.toString(),
      active: json['active']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      code: json['code']?.toString(),
      statusName: json['status_name']?.toString(),
      date: json['date']?.toString(),
      method: json['method']?.toString(),
      time: json['time']?.toString(),
      fatoraName: json['fatora_name']?.toString(),
      driverName: json['driver_name']?.toString(),
      clientData: json['client_data'] != null
          ? ClientData.fromJson(json['client_data'] as Map<String, dynamic>)
          : null,
      serviceName: json['service_name']?.toString(),
      subServiceName: json['sub_service_name']?.toString(),
    );
  }
}


