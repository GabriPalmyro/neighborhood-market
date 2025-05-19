import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/shipping_method_entity.dart';

class ShippingMethodModel extends Equatable {
  const ShippingMethodModel({
    required this.type,
    required this.name,
    required this.price,
    required this.deliveryTime,
  });

  factory ShippingMethodModel.fromJson(Map<String, dynamic> json) {
    return ShippingMethodModel(
      type: json['type'],
      name: json['name'],
      price: (json['shipping'] as num).toDouble(),
      deliveryTime: json['prizes'],
    );
  }

  final String type;
  final String name;
  final double price;
  final String deliveryTime;

  ShippingMethodEntity toEntity() {
    return ShippingMethodEntity(
      type: type,
      name: name,
      price: price,
      deliveryTime: deliveryTime,
    );
  }

  @override
  List<Object?> get props => [
        type,
        name,
        price,
        deliveryTime,
      ];
}