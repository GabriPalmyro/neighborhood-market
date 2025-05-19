import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';

class PurchaseOrderEntity extends Equatable {
  const PurchaseOrderEntity({
    required this.orderNumber,
    required this.deliveryAddress,
    required this.deliveryDate,
    required this.createdAt,
    required this.isDelivered,
    required this.product,
  });

  final String? orderNumber;
  final String deliveryAddress;
  final String deliveryDate;
  final DateTime createdAt;
  final bool isDelivered;
  final ProductGalleryItemModel product;

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
