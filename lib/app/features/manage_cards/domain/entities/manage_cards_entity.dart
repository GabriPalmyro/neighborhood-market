import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/manage_cards/domain/entities/billing_information_entity.dart';
import 'package:neighborhood_market/app/features/manage_cards/domain/entities/credit_card_entity.dart';

class ManageCardsEntity extends Equatable {
  const ManageCardsEntity({
    required this.billingInformation,
    required this.creditCards,
  });

  final BillingInformationEntity billingInformation;
  final List<CreditCardEntity> creditCards;

  @override
  List<Object?> get props => [
        billingInformation,
        creditCards,
      ];
}
