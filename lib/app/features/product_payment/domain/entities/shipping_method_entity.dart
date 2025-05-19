import 'package:equatable/equatable.dart';

class ShippingMethodEntity extends Equatable {
  const ShippingMethodEntity({
    required this.type,
    required this.name,
    required this.price,
    required this.deliveryTime,
  });

  final String type;
  final String name;
  final double price;
  final String deliveryTime;

  @override
  List<Object?> get props => [
        type,
        name,
        price,
        deliveryTime,
      ];
}
