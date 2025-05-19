import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';

abstract class MyPurchasesRepository {
  Future<List<ProductGalleryItemModel>> getInProgressPurchases({
    int page = 1,
  });
  Future<List<ProductGalleryItemModel>> getCompletedPurchases({
    int page = 1,
  });
}
