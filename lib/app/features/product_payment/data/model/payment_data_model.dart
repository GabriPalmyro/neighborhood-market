import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/payment_data_entity.dart';

class PaymentDataModel extends Equatable {
  const PaymentDataModel({
    required this.clientSecret,
    required this.paymentIntentId,
  });

  factory PaymentDataModel.fromJson(Map<String, dynamic> json) {
    return PaymentDataModel(
      clientSecret: json['clientSecret'] as String,
      paymentIntentId: json['paymentIntentId'] as String,
    );
  }

  final String clientSecret;
  final String paymentIntentId;

  PaymentDataEntity get toEntity => PaymentDataEntity(
        clientSecret: clientSecret,
        paymentIntentId: paymentIntentId,
      );

  @override
  List<Object?> get props => [
        clientSecret,
        paymentIntentId,
      ];
}
