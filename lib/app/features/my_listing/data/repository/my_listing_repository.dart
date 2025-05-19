import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/my_listing/domain/boundary/my_listing_repository.dart';
import 'package:neighborhood_market/app/features/my_listing/domain/entities/my_listing_type.dart';

@Injectable(as: MyListingRepository)
class MyListingRepositoryImpl implements MyListingRepository {
  MyListingRepositoryImpl(this.provider);
  final NetworkProvider provider;

  @override
  Future<List<ProductGalleryItemModel>> getListOfListingItems({
    required MyListingType type,
    required int page,
  }) async {
    final network = await provider.getNetworkInstance();

    final Map<String, dynamic> queryParameters = {};

    if (type != MyListingType.published) {
      queryParameters['type'] = type.path;
    }

    queryParameters['page'] = page;

    final response = await network.get(
      '/item/my/listings',
      queryParameters: queryParameters,
    );

    return (response.data['items'] as List<dynamic>)
        .map(
          (item) => ProductGalleryItemModel.fromJson(item),
        )
        .toList();
  }

  @override
  Future<void> deleteListingItem({required String id}) async {
    final network = await provider.getNetworkInstance();
    await network.delete('/item/$id');
  }
}
