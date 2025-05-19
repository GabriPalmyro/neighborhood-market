part of 'purchases_completed_cubit.dart';

sealed class PurchasesCompletedState extends Equatable {
  const PurchasesCompletedState();

  @override
  List<Object> get props => [];
}

final class PurchasesCompletedInitial extends PurchasesCompletedState {
  const PurchasesCompletedInitial();

  @override
  List<Object> get props => [];
}

final class PurchasesCompletedLoading extends PurchasesCompletedState {
  const PurchasesCompletedLoading();

  @override
  List<Object> get props => [];
}

final class PurchasesCompletedLoaded extends PurchasesCompletedState {
  const PurchasesCompletedLoaded({
    required this.purchases,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  final List<ProductGalleryItemModel> purchases;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoadingMore;

  PurchasesCompletedLoaded copyWith({
    List<ProductGalleryItemModel>? purchases,
    int? currentPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return PurchasesCompletedLoaded(
      purchases: purchases ?? this.purchases,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [purchases, currentPage, hasReachedMax, isLoadingMore];
}

final class PurchasesCompletedError extends PurchasesCompletedState {
  const PurchasesCompletedError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
