import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/my_listing/domain/entities/my_listing_type.dart';

abstract class MyListingRepository {
  Future<List<ProductGalleryItemModel>> getListOfListingItems({
    required MyListingType type,
    required int page,
  });
  Future<void> deleteListingItem({
    required String id,
  });
}
