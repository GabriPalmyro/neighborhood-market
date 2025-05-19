import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/following/data/model/following_model.dart';
import 'package:neighborhood_market/app/features/following/domain/boundary/following_repository.dart';
import 'package:neighborhood_market/app/features/following/domain/entities/following_entity.dart';
import 'package:neighborhood_market/app/features/following/domain/event/update_following_list_event.dart';

@Injectable(as: FollowingRepository)
class FollowingRepositoryImpl implements FollowingRepository {
  FollowingRepositoryImpl({required this.networkProvider, required this.eventBus});

  final NetworkProvider networkProvider;
  final ReactiveListener eventBus;

  @override
  Future<List<FollowingEntity>> getFollowings({
    int limit = 10,
    int page = 1,
    String? query,
  }) async {
    final network = await networkProvider.getNetworkInstance();

    final Map<String, dynamic> queryParameters = {
      'limit': limit,
      'page': page,
    };

    if (query != null) {
      queryParameters['query'] = query;
    }

    final response = await network.get(
      '/followers',
      queryParameters: queryParameters,
    );

    final followings = response.data['users'] as List<dynamic>;
    return followings
        .map(
          (e) => FollowingModel.fromJson(e).toEntity(),
        )
        .toList();
  }

  @override
  Future<void> followUser(String userId) async {
    final network = await networkProvider.getNetworkInstance();
    await network.post('/follow/$userId');
  }

  @override
  Future<void> unfollowUser(String userId) async {
    final network = await networkProvider.getNetworkInstance();
    await network.post('/unfollow/$userId');
  }

  @override
  Stream<UpdateFollowingListEvent> followingUpdateStream() {
    return eventBus.subscribe<UpdateFollowingListEvent>();
  }

  @override
  void emitFollowingUpdateEvent() {
    eventBus.publish(const UpdateFollowingListEvent());
  }
}
