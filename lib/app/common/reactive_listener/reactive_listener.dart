import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';

abstract class ReactiveListener {
  Stream<T> subscribe<T>();
  void publish<T>(T content);
  void dispose();
}

@Singleton(as: ReactiveListener)
class ReactiveListenerImpl implements ReactiveListener {
  final EventBus _eventBus = EventBus();

  @override
  void dispose() {
    _eventBus.destroy();
  }

  @override
  void publish<T>(T content) {
    _eventBus.fire(content);
  }

  @override
  Stream<T> subscribe<T>() {
    return _eventBus.on<T>();
  }
}
