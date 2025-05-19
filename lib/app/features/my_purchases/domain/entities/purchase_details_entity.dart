import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_delivery_item_entity.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_order_entity.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_status_enum.dart';

class PurchaseDetailsEntity extends Equatable {
  const PurchaseDetailsEntity({
    required this.status,
    required this.order,
    required this.deliveryItems,
    required this.hasBeenReviewed,
    this.sellerId,
  });

  final PurchaseStatusEnum status;
  final bool hasBeenReviewed;
  final String? sellerId;
  final PurchaseOrderEntity order;
  final List<PurchaseDeliveryItemEntity> deliveryItems;

  PurchaseDetailsEntity copyWith({
    PurchaseStatusEnum? status,
    bool? hasBeenReviewed,
    String? sellerId,
    PurchaseOrderEntity? order,
    List<PurchaseDeliveryItemEntity>? deliveryItems,
  }) {
    return PurchaseDetailsEntity(
      status: status ?? this.status,
      hasBeenReviewed: hasBeenReviewed ?? this.hasBeenReviewed,
      sellerId: sellerId ?? this.sellerId,
      order: order ?? this.order,
      deliveryItems: deliveryItems ?? this.deliveryItems,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      hasBeenReviewed,
      sellerId,
      order,
      deliveryItems,
    ];
  }
}