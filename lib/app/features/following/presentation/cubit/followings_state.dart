part of 'followings_cubit.dart';

sealed class FollowingsState extends Equatable {
  const FollowingsState();

  @override
  List<Object> get props => [];
}

final class FollowingsInitial extends FollowingsState {
  const FollowingsInitial();

  @override
  List<Object> get props => [];
}

final class FollowingsLoading extends FollowingsState {
  const FollowingsLoading();

  @override
  List<Object> get props => [];
}

final class FollowingsLoadingMore extends FollowingsState {
  const FollowingsLoadingMore(this.followings);

  final List<FollowingEntity> followings;

  @override
  List<Object> get props => [followings];
}

final class FollowingsLoaded extends FollowingsState {
  const FollowingsLoaded(this.followings);

  final List<FollowingEntity> followings;

  @override
  List<Object> get props => [followings];
}

final class FollowingsError extends FollowingsState {
  const FollowingsError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}