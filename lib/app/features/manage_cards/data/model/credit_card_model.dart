import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/manage_cards/domain/entities/credit_card_entity.dart';

class CreditCardModel extends Equatable {
  const CreditCardModel({
    required this.finalDigits,
    required this.cardType,
  });

  factory CreditCardModel.fromJson(Map<String, dynamic> json) {
    return CreditCardModel(
      finalDigits: json['finalDigits'],
      cardType: json['cardType'],
    );
  }
  
  final String finalDigits;
  final String cardType;

  CreditCardEntity toEntity() {
    return CreditCardEntity(
      finalDigits: finalDigits,
      cardType: cardType,
    );
  }

  @override
  List<Object?> get props => [
        finalDigits,
        cardType,
      ];
}
