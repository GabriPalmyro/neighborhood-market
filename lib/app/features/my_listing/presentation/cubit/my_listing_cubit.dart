import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/my_listing/data/event/refresh_listing_event.dart';
import 'package:neighborhood_market/app/features/my_listing/domain/boundary/my_listing_repository.dart';
import 'package:neighborhood_market/app/features/my_listing/domain/entities/my_listing_type.dart';

part 'my_listing_state.dart';

@injectable
class MyListingCubit extends Cubit<MyListingState> {
  MyListingCubit(
    this.repository,
    this.eventBus,
  ) : super(const MyListingInitial());

  final MyListingRepository repository;
  final ReactiveListener eventBus;

  late final StreamSubscription<RefreshListingEvent?> _refreshStream;

  static const int _pageSize = 10;
  static const int _initialPage = 1;

  Future<void> getMyListing({
    required MyListingType type,
    int page = _initialPage,
    bool isLoadMore = false,
  }) async {
    try {
      if (isLoadMore) {
        final currentState = state;
        if (currentState is MyListingLoaded && currentState.isLoadingMore) {
          return;
        }
        emit((state as MyListingLoaded).copyWith(isLoadingMore: true));
      } else {
        emit(const MyListingLoading());
      }

      final purchases = await repository.getListOfListingItems(type: type, page: page);

      if (isLoadMore) {
        final currentState = state;
        if (currentState is MyListingLoaded) {
          emit(
            currentState.copyWith(
              list: [...currentState.list, ...purchases],
              currentPage: page,
              hasReachedMax: purchases.length < _pageSize,
              isLoadingMore: false,
            ),
          );
        }
      } else {
        emit(
          MyListingLoaded(
            list: purchases,
            currentPage: page,
            hasReachedMax: purchases.length < _pageSize,
          ),
        );
      }
    } catch (e) {
      if (isLoadMore) {
        final currentState = state;
        if (currentState is MyListingLoaded) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } else {
        emit(MyListingError(e.toString()));
      }
    }
  }

  void loadMore(MyListingType type) {
    final currentState = state;
    if (currentState is MyListingLoaded && !currentState.hasReachedMax) {
      getMyListing(type: type, page: currentState.currentPage + 1, isLoadMore: true);
    }
  }

  void initRefreshListener(MyListingType type) {
    if (type == MyListingType.published) {
      _refreshStream = eventBus.subscribe<RefreshListingEvent>().listen((_) {
        getMyListing(type: MyListingType.published);
      });
    }
  }

  @override
  Future<void> close() {
    _refreshStream.cancel();
    return super.close();
  }
}
