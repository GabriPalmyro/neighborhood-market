import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/home/data/model/home_model.dart';
import 'package:neighborhood_market/app/features/home/domain/boundary/home_repository.dart';
import 'package:neighborhood_market/app/features/home/domain/entities/home_entity.dart';
import 'package:neighborhood_market/app/features/notifications/data/model/notification_model.dart';
import 'package:neighborhood_market/app/features/notifications/domain/entities/notification_entity.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required this.networkProvider,
  });

  final NetworkProvider networkProvider;

  @override
  Future<HomeEntity> getData() async {
    final network = await networkProvider.getNetworkInstance();

    final response = await network.get('/item/page/home');

    if (response.statusCode == 200) {
      return HomeModel.fromJson(response.data).toEntity();
    } else {
      throw Exception('Failed to load data');
    }
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
  Future<List<NotificationEntity>> getHasNotifications() async {
    final network = await networkProvider.getNetworkInstance();

    final response = await network.get('/notification');

    return (response.data as List<dynamic>)
        .map(
          (e) => NotificationModel.fromJson(e).toEntity(),
        )
        .toList();
  }
}
