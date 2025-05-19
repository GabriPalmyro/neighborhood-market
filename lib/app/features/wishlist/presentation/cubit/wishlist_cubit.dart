import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/wishlist/data/repository/update_wishlist_repository.dart';
import 'package:neighborhood_market/app/features/wishlist/domain/boundary/wishlist_repository.dart';
import 'package:neighborhood_market/app/features/wishlist/presentation/cubit/wishlist_state.dart';

@injectable
class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(
    this.repository,
    this.updateWishlistRepository,
  ) : super(const WishlistInitial());

  final WishlistRepository repository;
  final UpdateWishlistRepository updateWishlistRepository;

  late final StreamSubscription<void> _updateWithlist;

  Future<void> getResult() async {
    try {
      emit(const WishlistLoading());
      final result = await repository.getData();
      emit(WishlistLoaded(result));
    } catch (_) {
      emit(const WishlistError());
    }
  }

  void removeLikedItem(String id) {
    final wishlist = (state as WishlistLoaded).entity.items;
    final updatedWishlist = wishlist.where((element) => element.id != id).toList();
    emit(WishlistLoaded((state as WishlistLoaded).entity.copyWith(items: updatedWishlist)));
  }

  void unlikeProduct(String id) {
    removeLikedItem(id);
    repository.unlikeProduct(id);
  }

  void listenToWishlistEvents() {
    _updateWithlist = updateWishlistRepository
      .wishlistUpdateStream()
      .listen((_) {
        getResult();
      });
  }

  @override
  Future<void> close() {
    _updateWithlist.cancel();
    return super.close();
  }
}
