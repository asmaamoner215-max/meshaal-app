import 'package:equatable/equatable.dart';
import 'package:weam/core/models/base_response_model.dart';

class RequestPriceModel extends BaseResponseModel<PriceModel> {
  const RequestPriceModel({
    required super.status,
    required super.message,
    super.data,
  });

  factory RequestPriceModel.fromJson(Map<String, dynamic> json) {
    return RequestPriceModel(
      status: json["status"],
      message: json["msg"],
      data: PriceModel.fromJson(json["data"]),
    );
  }
}

class PriceModel extends Equatable {
  final String? km;
  final String? price;
  final String? doctor;
  final String? taxTotal;
  final String? total;

  const PriceModel({
    this.km,
    this.price,
    this.doctor,
    this.taxTotal,
    this.total,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      km: json['km'].toString(),
      price: json['price'].toString(),
      doctor: json['doctor'].toString(),
      taxTotal: json['tax_total'].toString(),
      total: json['total'].toString(),
    );
  }

  @override
  List<Object?> get props => [
        km,
        price,
        doctor,
        taxTotal,
        total,
      ];
}
