import 'package:neighborhood_market/app/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<ProductEntity> getProductDetails(String id);
  Future<bool> getShowShareButton();
  Future<void> likeProduct(String productId);
  Future<void> unlikeProduct(String productId);
  Future<void> makeOffer(String productId, double price);
  Future<void> makeCounterOffer(String productId, double price);
  Future<void> acceptOffer(String offerId);
  Future<void> declineOffer(String offerId);
  Future<void> declineCountOffer(String offerId);
  Future<void> acceptCounterOffer(String counterOfferId);
  Future<void> followSeller(String sellerId);
  Future<void> unfollowSeller(String sellerId);
}