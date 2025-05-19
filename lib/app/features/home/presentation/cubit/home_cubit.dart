import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/explore/domain/entity/filter_entity.dart';
import 'package:neighborhood_market/app/features/explore/domain/event/search_event.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/filter_cubit.dart';
import 'package:neighborhood_market/app/features/home/domain/boundary/home_repository.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/home_state.dart';
import 'package:neighborhood_market/app/features/wishlist/data/repository/update_wishlist_repository.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository, this.eventBus) : super(const HomeInitial());

  final HomeRepository repository;
  final ReactiveListener eventBus;

  Future<void> getResult() async {
    try {
      emit(const HomeLoading());
      final result = await repository.getData();
      emit(HomeLoaded(result));
    } catch (_) {
      emit(const HomeError());
    }
  }

  void sendGender(String gender) {
    eventBus.publish(FiltersSelected(filters: FilterEntity(gender: gender)));
  }

  void sendCategory(String category) {
    eventBus.publish(FiltersSelected(filters: FilterEntity(category: category)));
  }

  void sendSortBy(String sortBy) {
    eventBus.publish(FiltersSelected(filters: FilterEntity(sortBy: sortBy)));
  }

  void changeTrendingItemLikedState(String id, bool status) {
    final currentState = state;

    if (currentState is HomeLoaded) {
      final updatedTrendingItems = currentState.entity.trending?.items.map((item) {
        if (item.id == id) {
          return item.copyWith(isLiked: status);
        }
        return item;
      }).toList();

      final updatedTrending = currentState.entity.trending?.copyWith(
        items: updatedTrendingItems,
      );

      emit(
        currentState.copyWith(
          entity: currentState.entity.copyWith(
            trending: updatedTrending,
          ),
        ),
      );
    }
  }

  void changeMostWantedItemLikedState(String id, bool status) {
    final currentState = state;

    if (currentState is HomeLoaded) {
      final updatedMostWantedItems = currentState.entity.mostWanted?.items.map((item) {
        if (item.id == id) {
          return item.copyWith(isLiked: status);
        }
        return item;
      }).toList();

      final updatedMostWanted = currentState.entity.mostWanted?.copyWith(
        items: updatedMostWantedItems,
      );

      emit(
        currentState.copyWith(
          entity: currentState.entity.copyWith(
            mostWanted: updatedMostWanted,
          ),
        ),
      );
    }
  }

  void changeFollowerItemLikedState(String id, bool status) {
    final currentState = state;

    if (currentState is HomeLoaded) {
      final updatedFollowedItems = currentState.entity.followedItems?.items.map((item) {
        if (item.id == id) {
          return item.copyWith(isLiked: status);
        }
        return item;
      }).toList();

      final updatedFollowed = currentState.entity.followedItems?.copyWith(
        items: updatedFollowedItems,
      );

      emit(
        currentState.copyWith(
          entity: currentState.entity.copyWith(
            followedItems: updatedFollowed,
          ),
        ),
      );
    }
  }

  void likeTrendingShop(String shopId, bool isLiked) {
    final currentState = state;

    if (currentState is HomeLoaded) {
      changeTrendingItemLikedState(shopId, !isLiked);
      changeMostWantedItemLikedState(shopId, !isLiked);
      changeFollowerItemLikedState(shopId, !isLiked);

      if (isLiked) {
        repository.unlikeProduct(shopId).then((_) {
          sendWidgetEvent();
        }).catchError((_) {
          changeTrendingItemLikedState(shopId, isLiked);
          changeMostWantedItemLikedState(shopId, isLiked);
          changeFollowerItemLikedState(shopId, isLiked);
        });
      } else {
        repository.likeProduct(shopId).then((_) {
          sendWidgetEvent();
        }).catchError((_) {
          changeTrendingItemLikedState(shopId, isLiked);
          changeMostWantedItemLikedState(shopId, isLiked);
          changeFollowerItemLikedState(shopId, isLiked);
        });
      }
    }
  }

  void likeMostWantedShop(String shopId, bool isLiked) {
    final currentState = state;

    if (currentState is HomeLoaded) {
      changeTrendingItemLikedState(shopId, !isLiked);
      changeMostWantedItemLikedState(shopId, !isLiked);
      changeFollowerItemLikedState(shopId, !isLiked);

      if (isLiked) {
        repository.unlikeProduct(shopId).then((_) {
          sendWidgetEvent();
        }).catchError((_) {
          changeTrendingItemLikedState(shopId, isLiked);
          changeMostWantedItemLikedState(shopId, isLiked);
          changeFollowerItemLikedState(shopId, isLiked);
        });
      } else {
        repository.likeProduct(shopId).then((_) {
          sendWidgetEvent();
        }).catchError((_) {
          changeTrendingItemLikedState(shopId, isLiked);
          changeMostWantedItemLikedState(shopId, isLiked);
          changeFollowerItemLikedState(shopId, isLiked);
        });
      }
    }
  }

  void sendWidgetEvent() {
    eventBus.publish(const UpdateWishlistEvent());
  }

  void sendSearchEvent() {
    eventBus.publish(const SearchState());
  }
}
