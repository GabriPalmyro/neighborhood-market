import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/notifications/domain/boundary/notification_repository.dart';
import 'package:neighborhood_market/app/features/notifications/domain/entities/notification_entity.dart';

part 'notifications_state.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.repository) : super(const NotificationsInitial());

  final NotificationRepository repository;

  Future<void> getNotifications() async {
    emit(const NotificationsLoading());
    try {
      final notifications = await repository.getNotifications();
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }
}
