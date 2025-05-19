import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_order_entity.dart';

class PurchaseOrderModel extends Equatable {
  const PurchaseOrderModel({
    required this.orderNumber,
    required this.deliveryAddress,
    required this.deliveryDate,
    required this.createdAt,
    required this.isDelivered,
    required this.product,
  });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) {
    return PurchaseOrderModel(
      orderNumber: json['orderNumber'],
      deliveryAddress: json['deliveryAddress'],
      deliveryDate: json['estimatedDelivery'],
      createdAt: DateTime.parse(json['createdAt']),
      isDelivered: json['isDelivered'] ?? false,
      product: ProductGalleryItemModel.fromJson(json['orderProduct']),
    );
  }

  final String? orderNumber;
  final String deliveryAddress;
  final String deliveryDate;
  final DateTime createdAt;
  final bool isDelivered;
  final ProductGalleryItemModel product;

  PurchaseOrderEntity toEntity() {
    return PurchaseOrderEntity(
      orderNumber: orderNumber,
      deliveryAddress: deliveryAddress,
      deliveryDate: deliveryDate,
      createdAt: createdAt,
      isDelivered: isDelivered,
      product: product,
    );
  }

  @override
  List<Object?> get props {
    return [
      orderNumber,
      deliveryAddress,
      deliveryDate,
      createdAt,
      isDelivered,
      product,
    ];
  }
}
