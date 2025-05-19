import 'package:neighborhood_market/app/features/explore/domain/entity/explore_entity.dart';
import 'package:neighborhood_market/app/features/explore/domain/entity/filter_entity.dart';

abstract class ExploreRepository {
  Future<ExploreEntity> getExploreItems({
    int limit,
    int page,
    FilterEntity? filters,
  });
  Future<void> likeProduct(String id);
  Future<void> unlikeProduct(String id);
}
