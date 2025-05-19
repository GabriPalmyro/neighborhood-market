import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/following/domain/boundary/following_repository.dart';
import 'package:neighborhood_market/app/features/following/domain/entities/following_entity.dart';
import 'package:neighborhood_market/app/features/following/domain/event/update_following_list_event.dart';

part 'followings_state.dart';

@injectable
class FollowingsCubit extends Cubit<FollowingsState> {
  FollowingsCubit(this.repository) : super(const FollowingsInitial());

  final FollowingRepository repository;

  static const kMaxFollowings = 25;

  int _currentPage = 1;
  bool _hasReachedMax = false;
  String _currentQuery = '';

  static const _initialPage = 1;

  late final StreamSubscription<UpdateFollowingListEvent?> _updateEvent;

  Future<void> getFollowings({
    int limit = kMaxFollowings,
    int page = _initialPage,
    String query = '',
  }) async {
    if (state is FollowingsLoading) {
      return;
    }

    final isInitialLoad = page == _initialPage;
    if (isInitialLoad) {
      emit(const FollowingsLoading());
    } else {
      emit(FollowingsLoadingMore((state as FollowingsLoaded).followings));
    }

    try {
      final followings = await repository.getFollowings(
        limit: limit,
        page: page,
        query: query,
      );

      if (followings.isEmpty || followings.length < limit) {
        _hasReachedMax = true;
        emit(FollowingsLoaded(followings));
      } else {
        _currentPage = page;
        _currentQuery = query;
        final updatedFollowings = isInitialLoad ? followings : List<FollowingEntity>.of((state as FollowingsLoadingMore).followings)
          ..addAll(followings);
        emit(FollowingsLoaded(updatedFollowings));
      }
    } catch (e) {
      emit(FollowingsError(e.toString()));
    }
  }

  Future<void> loadMoreFollowings() async {
    if (_hasReachedMax) {
      return;
    }

    await getFollowings(
      limit: kMaxFollowings,
      page: _currentPage + 1,
      query: _currentQuery,
    );
  }

  Future<void> searchFollowings(String query) async {
    _hasReachedMax = false;
    await getFollowings(
      limit: kMaxFollowings,
      page: _initialPage,
      query: query,
    );
  }

  Future<void> followUser(String userId) async {
    final currentState = state;
    if (currentState is FollowingsLoaded) {
      final updatedFollowings = currentState.followings
          .map(
            (e) => e.id == userId ? e.copyWith(isFollowing: true) : e,
          )
          .toList();
      emit(FollowingsLoaded(updatedFollowings));
      await repository.followUser(userId);
    }
  }

  Future<void> unfollowUser(String userId) async {
    final currentState = state;
    if (currentState is FollowingsLoaded) {
      final updatedFollowings = currentState.followings
          .map(
            (e) => e.id == userId ? e.copyWith(isFollowing: false) : e,
          )
          .toList();
      emit(FollowingsLoaded(updatedFollowings));
      await repository.unfollowUser(userId);
    }
  }

  void listenToUpdateEvents() {
    _updateEvent = repository.followingUpdateStream().listen((_) {
      getFollowings();
    });
  }

  void emitFollowingUpdateEvent() {
    repository.emitFollowingUpdateEvent();
  }

  @override
  Future<void> close() {
    _updateEvent.cancel();
    return super.close();
  }
}
