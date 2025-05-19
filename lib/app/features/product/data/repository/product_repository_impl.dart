import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/feature_flags/feature_flag_service.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/core/app_strings.dart';
import 'package:neighborhood_market/app/features/product/data/model/product_model.dart';
import 'package:neighborhood_market/app/features/product/domain/boundaries/product_repository.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/product_entity.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(
    this.networkProvider,
    this.featureFlagService,
  );

  final NetworkProvider networkProvider;
  final FeatureFlagService featureFlagService;

  @override
  Future<ProductEntity> getProductDetails(String id) async {
    final network = await networkProvider.getNetworkInstance();

    final response = await network.get('/item/product/$id');

    return ProductModel.fromJson(response.data['item']).toEntity();
  }

  @override
  Future<void> makeOffer(String productId, double price) async {
    final network = await networkProvider.getNetworkInstance();

    final body = {
      'id': productId,
      'value': price,
    };

    await network.post('/offer', data: body);
  }

  @override
  Future<void> makeCounterOffer(String productId, double price) async {
    final network = await networkProvider.getNetworkInstance();

    await network.post(
      '/offer/counter',
      data: {
        'id': productId,
        'value': price,
      },
    );
  }

  @override
  Future<void> acceptOffer(String offerId) async {
    final network = await networkProvider.getNetworkInstance();

    await network.post(
      '/offer/accept',
      data: {
        'id': offerId,
      },
    );
  }

  @override
  Future<void> declineOffer(String offerId) async {
    final network = await networkProvider.getNetworkInstance();

    await network.post(
      '/offer/deny',
      data: {
        'id': offerId,
      },
    );
  }

  @override
  Future<void> declineCountOffer(String offerId) async {
    final network = await networkProvider.getNetworkInstance();

    await network.post(
      '/offer/counter/deny',
      data: {
        'id': offerId,
      },
    );
  }

  @override
  Future<void> likeProduct(String id) async {
    final network = await networkProvider.getNetworkInstance();
    await network.post('/wishlist', data: {'itemId': id});
  }

  @override
  Future<void> unlikeProduct(String id) async {
    final network = await networkProvider.getNetworkInstance();
    await network.delete('/wishlist/$id');
  }

  @override
  Future<void> acceptCounterOffer(String counterOfferId) async {
    final network = await networkProvider.getNetworkInstance();

    await network.post(
      '/offer/counter/accept',
      data: {
        'id': counterOfferId,
      },
    );
  }

  @override
  Future<bool> getShowShareButton() {
    return featureFlagService.getBool(AppStrings.enableShareLinkKey);
  }

  @override
  Future<void> followSeller(String sellerId) async {
    final network = await networkProvider.getNetworkInstance();
    await network.post('/follow/$sellerId');
  }

  @override
  Future<void> unfollowSeller(String sellerId) async {
    final network = await networkProvider.getNetworkInstance();
    await network.post('/unfollow/$sellerId');
  }
}
