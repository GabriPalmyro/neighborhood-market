import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/my_purchases/data/model/purchase_delivery_item_model.dart';
import 'package:neighborhood_market/app/features/my_purchases/data/model/purchase_order_model.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_details_entity.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_status_enum.dart';

class PurchaseDetailsModel extends Equatable {
  const PurchaseDetailsModel({
    required this.status,
    required this.order,
    required this.deliveryItems,
    required this.hasBeenReviewed,
    this.sellerId,
  });

  factory PurchaseDetailsModel.fromJson(Map<String, dynamic> json) {
    return PurchaseDetailsModel(
      status: PurchaseStatusEnum.fromString(json['status']),
      hasBeenReviewed: json['hasBeenReviewed'] ?? false,
      sellerId: json['sellerId'] as String?,
      order: PurchaseOrderModel.fromJson(json['order']),
      deliveryItems: List<PurchaseDeliveryItemModel>.from(
        (json['delivery'] as List<dynamic>).map(
          (x) => PurchaseDeliveryItemModel.fromJson(x),
        ),
      ),
    );
  }

  final PurchaseStatusEnum status;
  final bool hasBeenReviewed;
  final String? sellerId;
  final PurchaseOrderModel order;
  final List<PurchaseDeliveryItemModel> deliveryItems;

  PurchaseDetailsEntity toEntity() {
    return PurchaseDetailsEntity(
      status: status,
      hasBeenReviewed: hasBeenReviewed,
      sellerId: sellerId,
      order: order.toEntity(),
      deliveryItems: deliveryItems
          .map(
            (x) => x.toEntity(),
          )
          .toList(),
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
