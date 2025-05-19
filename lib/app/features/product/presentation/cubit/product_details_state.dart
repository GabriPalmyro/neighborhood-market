part of 'product_details_cubit.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();
}

final class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading();
}

final class ProductDetailsLoaded extends ProductDetailsState {
  const ProductDetailsLoaded(this.product, {this.showShareButton = false});
  final ProductEntity product;
  final bool showShareButton;

  ProductDetailsLoaded copyWith({
    ProductEntity? product,
    bool? showShareButton,
  }) {
    return ProductDetailsLoaded(
      product ?? this.product,
      showShareButton: showShareButton ?? this.showShareButton,
    );
  }

  @override
  List<Object> get props => [product, showShareButton];
}

final class ProductDetailsError extends ProductDetailsState {
  const ProductDetailsError();
}
