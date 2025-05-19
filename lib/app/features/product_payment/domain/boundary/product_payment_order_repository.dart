import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/domain/entities/product_gallery_entity.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/shipping_informations_entity.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/shipping_method_entity.dart';

abstract class ProductPaymentOrderRepository {
  Future<ProductGalleryItemEntity> getProductPaymentOrder(String id);
  Future<ShippingInformationsEntity> getShippingInformations();
  Future<List<ShippingMethodEntity>> getShippingMethods();
}