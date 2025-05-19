import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/boundary/my_purchases_repository.dart';

@Injectable(as: MyPurchasesRepository)
class MyPurchasesRepositoryImpl implements MyPurchasesRepository {
  MyPurchasesRepositoryImpl(this.provider);
  final NetworkProvider provider;

  @override
  Future<List<ProductGalleryItemModel>> getCompletedPurchases({
    int page = 1,
  }) async {
    final network = await provider.getNetworkInstance();

    final response = await network.get(
      '/item/my/order',
      queryParameters: {
        'page': page,
        'type': 'completed',
      },
    );

    return (response.data['items'] as List<dynamic>).map((item) => ProductGalleryItemModel.fromJson(item)).toList();
  }

  @override
  Future<List<ProductGalleryItemModel>> getInProgressPurchases({
    int page = 1,
  }) async {
    final network = await provider.getNetworkInstance();

    final response = await network.get(
      '/item/my/order',
      queryParameters: {
        'page': page,
      },
    );

    return (response.data['items'] as List<dynamic>).map((item) => ProductGalleryItemModel.fromJson(item)).toList();
  }
}
