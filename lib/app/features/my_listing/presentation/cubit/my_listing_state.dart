part of 'my_listing_cubit.dart';

sealed class MyListingState extends Equatable {
  const MyListingState();

  @override
  List<Object> get props => [];
}

final class MyListingInitial extends MyListingState {
  const MyListingInitial();

  @override
  List<Object> get props => [];
}

final class MyListingLoading extends MyListingState {
  const MyListingLoading();

  @override
  List<Object> get props => [];
}

final class MyListingLoaded extends MyListingState {
  const MyListingLoaded({
    required this.list,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  final List<ProductGalleryItemModel> list;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoadingMore;

  MyListingLoaded copyWith({
    List<ProductGalleryItemModel>? list,
    int? currentPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return MyListingLoaded(
      list: list ?? this.list,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [
        list,
        currentPage,
        hasReachedMax,
        isLoadingMore,
      ];
}

final class MyListingError extends MyListingState {
  const MyListingError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
