part of 'purchases_in_progress_cubit.dart';

sealed class PurchasesInProgressState extends Equatable {
  const PurchasesInProgressState();

  @override
  List<Object> get props => [];
}

final class PurchasesInProgressInitial extends PurchasesInProgressState {
  const PurchasesInProgressInitial();

  @override
  List<Object> get props => [];
}

final class PurchasesInProgressLoading extends PurchasesInProgressState {
  const PurchasesInProgressLoading();

  @override
  List<Object> get props => [];
}

final class PurchasesInProgressLoaded extends PurchasesInProgressState {
  const PurchasesInProgressLoaded({
    required this.purchases,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  final List<ProductGalleryItemModel> purchases;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoadingMore;

  PurchasesInProgressLoaded copyWith({
    List<ProductGalleryItemModel>? purchases,
    int? currentPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return PurchasesInProgressLoaded(
      purchases: purchases ?? this.purchases,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [
        purchases,
        currentPage,
        hasReachedMax,
        isLoadingMore,
      ];
}

final class PurchasesInProgressError extends PurchasesInProgressState {
  const PurchasesInProgressError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
