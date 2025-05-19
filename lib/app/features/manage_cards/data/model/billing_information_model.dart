import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/manage_cards/domain/entities/billing_information_entity.dart';

class BillingInformationModel extends Equatable {
  const BillingInformationModel({
    required this.renewDate,
    required this.renewPrice,
  });
  
  factory BillingInformationModel.fromJson(Map<String, dynamic> json) {
    return BillingInformationModel(
      renewDate: json['renewDate'],
      renewPrice: json['renewPrice'],
    );
  }

  final String renewDate;
  final String renewPrice;

  BillingInformationEntity toEntity() {
    return BillingInformationEntity(
      renewDate: renewDate,
      renewPrice: renewPrice,
    );
  }

  @override
  List<Object?> get props => [
        renewDate,
        renewPrice,
      ];
}
