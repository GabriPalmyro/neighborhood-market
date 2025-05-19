import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/wishlist/data/model/wishlist_model.dart';
import 'package:neighborhood_market/app/features/wishlist/domain/boundary/wishlist_repository.dart';
import 'package:neighborhood_market/app/features/wishlist/domain/entities/wishlist_entity.dart';

@LazySingleton(as: WishlistRepository)
class WishlistRepositoryImpl implements WishlistRepository {
  WishlistRepositoryImpl({
    required this.networkProvider,
  });

  final NetworkProvider networkProvider;

  @override
  Future<WishlistEntity> getData() async {
    final network = await networkProvider.getNetworkInstance();

    final response = await network.get('/wishlist');

    return WishlistModel.fromJson(response.data).toEntity();
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
