import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/home/domain/boundary/home_repository.dart';

part 'notifications_state.dart';

class NotificationsToReadEvent {
  const NotificationsToReadEvent();
}

class NotificationsEmptyEvent {
  const NotificationsEmptyEvent();
}

@injectable
class NotificationsHomeCubit extends Cubit<NotificationsHomeState> {
  NotificationsHomeCubit(this.repository, this.eventBus) : super(const NotificationsInitial());

  final HomeRepository repository;
  final ReactiveListener eventBus;

  Future<void> getNotifications() async {
    try {
      final notifications = await repository.getHasNotifications();

      final isAnyToRead = notifications.any((element) => !element.isRead);

      if (isAnyToRead) {
        eventBus.publish(const NotificationsToReadEvent());
        emit(const NotificationsToRead());
      } else {
        eventBus.publish(const NotificationsEmptyEvent());
        emit(const NotificationsEmpty());
      }
    } catch (_) {
      eventBus.publish(const NotificationsEmptyEvent());
      emit(const NotificationsEmpty());
    }
  }
}
