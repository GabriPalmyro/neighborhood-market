import 'package:neighborhood_market/app/features/wishlist/domain/entities/wishlist_entity.dart';

abstract class WishlistRepository {
  Future<WishlistEntity> getData();
  Future<void> likeProduct(String id);
  Future<void> unlikeProduct(String id);
}
