import 'package:equatable/equatable.dart';

class PaymentDataEntity extends Equatable {
  const PaymentDataEntity({
    required this.clientSecret,
    required this.paymentIntentId,
  });

  final String clientSecret;
  final String paymentIntentId;

  @override
  List<Object?> get props => [
        clientSecret,
        paymentIntentId,
      ];
}
