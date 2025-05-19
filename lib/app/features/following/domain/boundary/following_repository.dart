import 'package:neighborhood_market/app/features/following/domain/entities/following_entity.dart';
import 'package:neighborhood_market/app/features/following/domain/event/update_following_list_event.dart';

abstract class FollowingRepository {
  Future<List<FollowingEntity>> getFollowings({
    int limit = 10,
    int page = 1,
    String? query,
  });
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Stream<UpdateFollowingListEvent> followingUpdateStream();
  void emitFollowingUpdateEvent();
}
