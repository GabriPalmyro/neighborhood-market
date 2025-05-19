import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/explore/domain/event/search_event.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/filter_cubit.dart';

abstract class FilterUpdateRepository {
  Stream<FilterState?> filterStream();
  Stream<SearchState?> searchStream();
  void updateFilter(FilterState filterUpdate);
}

@LazySingleton(as: FilterUpdateRepository)
class FilterUpdateRepositoryImpl implements FilterUpdateRepository {
  FilterUpdateRepositoryImpl(this.eventBus);

  final ReactiveListener eventBus;

  @override
  Stream<FilterState?> filterStream() => eventBus.subscribe<FilterState>();

  @override
  void updateFilter(FilterState filterUpdate) {
    eventBus.publish(filterUpdate);
  }
  
  @override
  Stream<SearchState?> searchStream() {
    return eventBus.subscribe<SearchState>();
  }
}
