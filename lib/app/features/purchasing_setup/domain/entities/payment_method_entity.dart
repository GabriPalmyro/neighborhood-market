import 'package:equatable/equatable.dart';

class PaymentMethodEntity extends Equatable {
  const PaymentMethodEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.isEnabled,
  });

  final String id;
  final String name;
  final String description;
  final bool isEnabled;

  PaymentMethodEntity copyWith({
    String? id,
    String? name,
    String? description,
    bool? isEnabled,
  }) {
    return PaymentMethodEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        isEnabled,
      ];
}
