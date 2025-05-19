part of 'review_product_cubit.dart';

sealed class ReviewProductState extends Equatable {
  const ReviewProductState();

  @override
  List<Object> get props => [];
}

final class ReviewProductInitial extends ReviewProductState {
  const ReviewProductInitial();

  @override
  List<Object> get props => [];
}

final class ReviewProductLoading extends ReviewProductState {
  const ReviewProductLoading();

  @override
  List<Object> get props => [];
}

final class ReviewProductLoaded extends ReviewProductState {
  const ReviewProductLoaded();

  @override
  List<Object> get props => [];
}

final class ReviewProductError extends ReviewProductState {
  const ReviewProductError(this.message);
  final String message;

  @override
  List<Object> get props => [
    message,
  ];
}
