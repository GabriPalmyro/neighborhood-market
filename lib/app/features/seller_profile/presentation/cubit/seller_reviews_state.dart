part of 'seller_reviews_cubit.dart';

sealed class SellerReviewsState extends Equatable {
  const SellerReviewsState();

  @override
  List<Object> get props => [];
}

final class SellerReviewsInitial extends SellerReviewsState {
  const SellerReviewsInitial();

  @override
  List<Object> get props => [];
}

final class SellerReviewsLoading extends SellerReviewsState {
  const SellerReviewsLoading();

  @override
  List<Object> get props => [];
}

final class SellerReviewsLoaded extends SellerReviewsState {
  const SellerReviewsLoaded(this.sellerReview);
  final SellerReviewEntity sellerReview;

  @override
  List<Object> get props => [sellerReview];
}

final class SellerReviewsError extends SellerReviewsState {
  const SellerReviewsError(
    this.message,
    this.sellerId,
  );
  final String message;
  final String sellerId;

  @override
  List<Object> get props => [message, sellerId];
}
