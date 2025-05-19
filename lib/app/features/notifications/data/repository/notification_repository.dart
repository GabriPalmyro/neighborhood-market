import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/notifications/data/model/notification_model.dart';
import 'package:neighborhood_market/app/features/notifications/domain/boundary/notification_repository.dart';
import 'package:neighborhood_market/app/features/notifications/domain/entities/notification_entity.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({required this.provider});

  final NetworkProvider provider;

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    final network = await provider.getNetworkInstance();

    final response = await network.get('/notification');

    return (response.data as List<dynamic>)
        .map(
          (e) => NotificationModel.fromJson(e).toEntity(),
        )
        .toList();
  }
}
