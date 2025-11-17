import 'package:equatable/equatable.dart';
import 'package:weam/core/models/base_response_model.dart';

class GetOrderModel extends BaseResponseModel<OrderData>{

  const GetOrderModel({
    super.status,
    super.message,
    super.data,
  });

  factory GetOrderModel.fromJson(Map<String, dynamic> json) {
    return GetOrderModel(
      status: json['status'] as bool?,
      message: json['msg'] as String?,
      data: json['data'] != null
          ? OrderData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [super.props,];
}

class OrderData extends Equatable {
  final int? userId;
  final String? type;
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
  final Map? bookingImage;
  final String? doctor;
  final String? status;
  final String? payMethod;
  final String? pay;
  final String? transactionId;
  final String? payData;
  final String? tax;
  final int? active;
  final int? changeKm;
  final int? km;
  final int? price;
  final String? doctorPrice;
  final int? taxTotal;
  final int? total;
  final String? updatedAt;
  final String? createdAt;
  final int? id;
  final int? smsWallet;
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

  const OrderData({
    this.userId,
    this.type,
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
    this.status,
    this.payMethod,
    this.pay,
    this.transactionId,
    this.payData,
    this.tax,
    this.active,
    this.changeKm,
    this.km,
    this.price,
    this.doctorPrice,
    this.taxTotal,
    this.total,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.smsWallet,
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

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      userId: json['user_id'] as int?,
      type: json['type'] as String?,
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
      bookingImage: json['booking_image'],
      doctor: json['doctor'] as String?,
      status: json['status'] as String?,
      payMethod: json['pay_method'] as String?,
      pay: json['pay'] as String?,
      transactionId: json['transaction_id'],
      payData: json['pay_data'],
      tax: json['tax'] as String?,
      active: json['active'] as int?,
      changeKm: json['change_km'] as int?,
      km: json['km'] as int?,
      price: json['price'] as int?,
      doctorPrice: json['doctor_price'].toString() as String?,
      taxTotal: json['tax_total'] as int?,
      total: json['total'] as int?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
      smsWallet: json['sms_wallet'] as int?,
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

  @override
  List<Object?> get props => [
    userId,
    type,
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
    status,
    payMethod,
    pay,
    transactionId,
    payData,
    tax,
    active,
    changeKm,
    km,
    price,
    doctorPrice,
    taxTotal,
    total,
    updatedAt,
    createdAt,
    id,
    smsWallet,
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
  ];
}

class ClientData extends Equatable {
  final String? name;
  final String? phone;
  final String? image;

  const ClientData({
    this.name,
    this.phone,
    this.image,
  });

  factory ClientData.fromJson(Map<String, dynamic> json) {
    return ClientData(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
    );
  }

  @override
  List<Object?> get props => [name, phone, image];
}
