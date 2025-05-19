import 'package:equatable/equatable.dart';

class BillingInformationEntity extends Equatable {
  const BillingInformationEntity({
    required this.renewDate,
    required this.renewPrice,
  });

  final String renewDate;
  final String renewPrice;

  @override
  List<Object?> get props => [
        renewDate,
        renewPrice,
      ];
}
