import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/boundary/my_purchases_repository.dart';

part 'purchases_completed_state.dart';

@injectable
class PurchasesCompletedCubit extends Cubit<PurchasesCompletedState> {
  PurchasesCompletedCubit(
    this.repository,
  ) : super(const PurchasesCompletedInitial());

  final MyPurchasesRepository repository;

  static const int _pageSize = 10;
  static const int _initialPage = 1;

  Future<void> loadPurchases({
    int page = _initialPage,
    bool isLoadMore = false,
  }) async {
    try {
      if (isLoadMore) {
        final currentState = state;
        if (currentState is PurchasesCompletedLoaded && currentState.isLoadingMore) {
          return;
        }
        emit((state as PurchasesCompletedLoaded).copyWith(isLoadingMore: true));
      } else {
        emit(const PurchasesCompletedLoading());
      }

      final newPurchases = await repository.getCompletedPurchases(page: page);

      if (isLoadMore) {
        final currentState = state;
        if (currentState is PurchasesCompletedLoaded) {
          emit(
            currentState.copyWith(
              purchases: [...currentState.purchases, ...newPurchases],
              currentPage: page,
              hasReachedMax: newPurchases.length < _pageSize,
              isLoadingMore: false,
            ),
          );
        }
      } else {
        emit(
          PurchasesCompletedLoaded(
            purchases: newPurchases,
            currentPage: page,
            hasReachedMax: newPurchases.length < _pageSize,
          ),
        );
      }
    } catch (e) {
      if (isLoadMore) {
        final currentState = state;
        if (currentState is PurchasesCompletedLoaded) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } else {
        emit(PurchasesCompletedError(e.toString()));
      }
    }
  }

  void loadMorePurchases() {
    final currentState = state;
    if (currentState is PurchasesCompletedLoaded && !currentState.hasReachedMax) {
      loadPurchases(page: currentState.currentPage + 1, isLoadMore: true);
    }
  }
}
