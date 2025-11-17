import 'package:equatable/equatable.dart';

class PromoModel extends Equatable {
  final bool? status;
  final String? msg;
  final String? totalReq;
  final String? deliveryTotalReq;
  final String? sale;
  final double? salePrice;
  final double? total;
  final int? promoId;

  const PromoModel({
    this.status,
    this.msg,
    this.totalReq,
    this.deliveryTotalReq,
    this.sale,
    this.salePrice,
    this.total,
    this.promoId,
  });

  // fromJson method
  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel(
      status: json['status'] as bool?,
      msg: json['msg'] as String?,
      totalReq: json['total_req'] as String?,
      deliveryTotalReq: json['delivery_total_req'] as String?,
      sale: json['sale'] as String?,
      salePrice: (json['sale_price'] as num?)?.toDouble(),
      total:(json['total'] as num?)?.toDouble(),
      promoId: json['promo_id'] as int?,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'total_req': totalReq,
      'delivery_total_req': deliveryTotalReq,
      'sale': sale,
      'sale_price': salePrice,
      'total': total,
      'promo_id': promoId,
    };
  }

  @override
  List<Object?> get props => [
    status,
    msg,
    totalReq,
    deliveryTotalReq,
    sale,
    salePrice,
    total,
    promoId,
  ];
}
