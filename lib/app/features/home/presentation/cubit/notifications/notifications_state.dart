part of 'notifications_cubit.dart';

sealed class NotificationsHomeState extends Equatable {
  const NotificationsHomeState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsHomeState {
  const NotificationsInitial();

  @override
  List<Object> get props => [];
}

final class NotificationsEmpty extends NotificationsHomeState {
  const NotificationsEmpty();

  @override
  List<Object> get props => [];
}

final class NotificationsToRead extends NotificationsHomeState {
  const NotificationsToRead();

  @override
  List<Object> get props => [];
}