import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/explore/data/repository/filter_update_repository.dart';
import 'package:neighborhood_market/app/features/explore/domain/boundary/explore_repository.dart';
import 'package:neighborhood_market/app/features/explore/domain/entity/filter_entity.dart';
import 'package:neighborhood_market/app/features/explore/domain/event/search_event.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/explore_state.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/filter_cubit.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/domain/entities/product_gallery_entity.dart';
import 'package:neighborhood_market/app/features/wishlist/data/repository/update_wishlist_repository.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(
    this.repository,
    this.filterUpdate,
    this.updateWishlistRepository,
  ) : super(const ExploreState());

  final ExploreRepository repository;
  final FilterUpdateRepository filterUpdate;
  final UpdateWishlistRepository updateWishlistRepository;

  final FocusNode searchFocusNode = FocusNode();

  late final StreamSubscription<FilterState?> _filterStream;
  late final StreamSubscription<SearchState?> _searchStream;

  static const _postLimit = 20;
  static const _initialPage = 1;

  bool hasAnyFilters() {
    return state.filters.conditions.isNotEmpty ||
        state.filters.category != null ||
        state.filters.sortBy != null ||
        state.filters.minPrice != null ||
        state.filters.maxPrice != null ||
        state.filters.search != null;
  }

  Future<void> getProducts({
    bool refresh = false,
    bool search = false,
    FilterEntity? filters,
  }) async {
    if (state.hasReachedMax && !refresh && !search) {
      return;
    }

    try {
      if (refresh) {
        emit(
          const ExploreState(
            status: ExploreStatus.loading,
            products: [],
            page: _initialPage,
            hasReachedMax: false,
          ),
        );
      } else if (search) {
        emit(
          state.copyWith(
            status: ExploreStatus.loading,
            products: [],
            page: _initialPage,
            hasReachedMax: false,
          ),
        );
      } else if (state.page == 0) {
        emit(state.copyWith(status: ExploreStatus.loading));
      }

      final entity = await repository.getExploreItems(
        limit: _postLimit,
        page: state.page,
        filters: filters,
      );

      final items = entity.items;

      final newItems = List.of(state.products)..addAll(items);

      if (items.isEmpty || items.length < _postLimit) {
        emit(state.copyWith(hasReachedMax: true));
      }

      emit(
        state.copyWith(
          status: ExploreStatus.success,
          products: newItems,
          page: state.page + 1,
          tags: filters?.conditions,
          category: filters?.category,
          sortBy: filters?.sortBy,
          searchQuery: filters?.search,
          minPrice: filters?.minPrice,
          maxPrice: filters?.maxPrice,
          adBanner: entity.adBanner,
          gender: filters?.gender,
          clothingSize: filters?.clothingSize,
          shoeSize: filters?.shoeSize,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ExploreStatus.failure,
        ),
      );
    }
  }

  Future<void> getMoreProducts() async {
    final filters = state.filters;
    final entity = await repository.getExploreItems(
      limit: _postLimit,
      page: state.page,
      filters: filters,
    );

    final items = entity.items;

    final newItems = List.of(state.products)..addAll(items);

    if (items.isEmpty || items.length < _postLimit) {
      emit(state.copyWith(hasReachedMax: true));
    }

    emit(
      state.copyWith(
        status: ExploreStatus.success,
        products: newItems,
        page: state.page + 1,
        tags: filters.conditions,
        category: filters.category,
        sortBy: filters.sortBy,
        clothingSize: filters.clothingSize,
        shoeSize: filters.shoeSize,
        gender: filters.gender,
        searchQuery: filters.search,
        minPrice: filters.minPrice,
        maxPrice: filters.maxPrice,
        hasReachedMax: items.isEmpty || items.length < _postLimit,
        adBanner: entity.adBanner,
      ),
    );
  }

  void changeProductLike(String id, bool isLiked) {
    final products = state.products.map<ProductGalleryItemEntity>((product) {
      if (product.id == id) {
        return product.copyWith(isLiked: isLiked);
      }
      return product;
    }).toList();

    emit(
      state.copyWith(
        products: products,
      ),
    );
  }

  void likeProduct(String id) {
    changeProductLike(id, true);

    repository.likeProduct(id).then((_) {
      updateWishlistRepository.updateWishlist();
    }).catchError((_) {
      changeProductLike(id, false);
    });
  }

  void unlikeProduct(String id) {
    changeProductLike(id, false);

    repository.unlikeProduct(id).then((_) {
      updateWishlistRepository.updateWishlist();
    }).catchError((_) {
      changeProductLike(id, true);
    });
  }

  void listenToFilterEvents() {
    _searchStream = filterUpdate.searchStream().listen((event) {
      searchFocusNode.requestFocus();
    });

    _filterStream = filterUpdate.filterStream().listen((event) {
      if (event is FiltersSelected) {
        final conditions = event.filters.conditions;
        final sortBy = event.filters.sortBy;
        final category = event.filters.category;
        final double? minPrice = event.filters.minPrice;
        final double? maxPrice = event.filters.maxPrice;
        final gender = event.filters.gender;
        final clothingSize = event.filters.clothingSize;
        final shoeSize = event.filters.shoeSize;

        final filter = FilterEntity(
          conditions: conditions,
          sortBy: sortBy,
          category: category,
          minPrice: minPrice,
          maxPrice: maxPrice,
          gender: gender,
          clothingSize: clothingSize,
          shoeSize: shoeSize,
        );

        getProducts(search: true, filters: filter);
      }
    });
  }

  @override
  Future<void> close() {
    _filterStream.cancel();
    _searchStream.cancel();
    return super.close();
  }
}
