import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/manage_cards/data/model/billing_information_model.dart';
import 'package:neighborhood_market/app/features/manage_cards/data/model/credit_card_model.dart';
import 'package:neighborhood_market/app/features/manage_cards/domain/entities/manage_cards_entity.dart';

class ManageCardsModel extends Equatable {
  const ManageCardsModel({
    required this.billingInformation,
    required this.creditCards,
  });

  factory ManageCardsModel.fromJson(Map<String, dynamic> json) {
    return ManageCardsModel(
      billingInformation: BillingInformationModel.fromJson(json['billing']),
      creditCards: List<CreditCardModel>.from(
        (json['cards'] as List<dynamic>).map(
          (item) => CreditCardModel.fromJson(item),
        ),
      ),
    );
  }

  final BillingInformationModel billingInformation;
  final List<CreditCardModel> creditCards;

  ManageCardsEntity toEntity() {
    return ManageCardsEntity(
      billingInformation: billingInformation.toEntity(),
      creditCards: creditCards.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        billingInformation,
        creditCards,
      ];
}
