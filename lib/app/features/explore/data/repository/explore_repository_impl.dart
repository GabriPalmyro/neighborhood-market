import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/explore/data/model/explore_model.dart';
import 'package:neighborhood_market/app/features/explore/domain/boundary/explore_repository.dart';
import 'package:neighborhood_market/app/features/explore/domain/entity/explore_entity.dart';
import 'package:neighborhood_market/app/features/explore/domain/entity/filter_entity.dart';

@LazySingleton(as: ExploreRepository)
class ExploreRepositoryImpl implements ExploreRepository {
  ExploreRepositoryImpl({
    required this.networkProvider,
  });

  final NetworkProvider networkProvider;

  @override
  Future<ExploreEntity> getExploreItems({
    int limit = 20,
    int page = 1,
    FilterEntity? filters,
  }) async {
    final network = await networkProvider.getNetworkInstance();

    final Map<String, dynamic> queryParams = filters?.toJson() ?? {};

    queryParams['limit'] = limit;

    queryParams['page'] = page;

    final response = await network.get(
      '/item',
      queryParameters: queryParams,
    );

    return ExploreModel.fromJson(response.data).toEntity();
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
}
