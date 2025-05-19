import 'package:neighborhood_market/app/features/home/domain/entities/home_entity.dart';
import 'package:neighborhood_market/app/features/notifications/domain/entities/notification_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity> getData();
  Future<List<NotificationEntity>> getHasNotifications();
  Future<void> likeProduct(String id);
  Future<void> unlikeProduct(String id);
}
