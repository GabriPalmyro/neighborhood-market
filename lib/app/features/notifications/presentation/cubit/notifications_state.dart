part of 'notifications_cubit.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();

  @override
  List<Object> get props => [];
}

final class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();

  @override
  List<Object> get props => [];
}

final class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded(this.notifications);
  final List<NotificationEntity> notifications;

  @override
  List<Object> get props => [notifications];
}

final class NotificationsError extends NotificationsState {
  const NotificationsError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
