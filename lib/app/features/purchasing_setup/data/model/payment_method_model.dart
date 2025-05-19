import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/domain/entities/payment_method_entity.dart';

class PaymentMethodModel extends Equatable {
  const PaymentMethodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isEnabled,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isEnabled: json['isEnabled'],
    );
  }

  final String id;
  final String name;
  final String description;
  final bool isEnabled;

  PaymentMethodEntity get toEntity => PaymentMethodEntity(
        id: id,
        name: name,
        description: description,
        isEnabled: isEnabled,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        isEnabled,
      ];
}
