import 'package:equatable/equatable.dart';

class CreditCardEntity extends Equatable {
  const CreditCardEntity({
    required this.finalDigits,
    required this.cardType,
  });
  
  final String finalDigits;
  final String cardType;

  @override
  List<Object?> get props => [
        finalDigits,
        cardType,
      ];
}
