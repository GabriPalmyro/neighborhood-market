import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/product_entity.dart';
import 'package:neighborhood_market/app/features/product/domain/product_interactor.dart';

part 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(
    this._productInteractor,
  ) : super(const ProductDetailsInitial());

  final ProductInteractor _productInteractor;

  Future<void> getProductDetails(String id) async {
    try {
      emit(const ProductDetailsLoading());
      final product = await _productInteractor.getProductDetails(id);
      final showShareItem = await _showShareProductLink();
      emit(ProductDetailsLoaded(product, showShareButton: showShareItem));
    } catch (e) {
      emit(const ProductDetailsError());
    }
  }

  Future<bool> _showShareProductLink() {
    return _productInteractor.showShareProductLink();
  }

  Future<String> generateShareProductLink(String productId) async {
    return await _productInteractor.createProductDynamicLink(productId);
  }

  Future<void> followSeller() async {
    final currentState = state;
    if (currentState is ProductDetailsLoaded) {
      final product = currentState.product;
      final updatedSeller = product.seller?.copyWith(
        isFollowing: true,
      );

      final updatedProduct = product.copyWith(
        seller: updatedSeller,
      );

      emit(ProductDetailsLoaded(updatedProduct));

      _productInteractor.changeFollowStatus(true, product.seller?.id ?? '').then((_) {
        _productInteractor.emitFollowingUpdateEvent();
      });
    }
  }

  Future<void> unfollowSeller() async {
    final currentState = state;
    if (currentState is ProductDetailsLoaded) {
      final product = currentState.product;
      final updatedSeller = product.seller?.copyWith(
        isFollowing: false,
      );

      final updatedProduct = product.copyWith(
        seller: updatedSeller,
      );

      emit(ProductDetailsLoaded(updatedProduct));

      _productInteractor.changeFollowStatus(false, product.seller?.id ?? '').then((_) {
        _productInteractor.emitFollowingUpdateEvent();
      });
    }
  }

  Future<void> changeLikeStatus({
    required Function(bool) onSuccess,
    required VoidCallback onError,
  }) async {
    try {
      final currentState = state;
      if (currentState is ProductDetailsLoaded) {
        final product = currentState.product;
        final updatedProduct = product.copyWith(
          isLiked: !product.isLiked,
        );

        emit(
          ProductDetailsLoaded(
            updatedProduct,
            showShareButton: currentState.showShareButton,
          ),
        );

        await _productInteractor.changeLikeStatus(
          updatedProduct.isLiked,
          updatedProduct.id,
        );

        onSuccess(updatedProduct.isLiked);
      }
    } catch (e) {
      onError();

      final currentState = state;

      if (currentState is ProductDetailsLoaded) {
        emit(
          ProductDetailsLoaded(
            currentState.product.copyWith(
              isLiked: !currentState.product.isLiked,
            ),
            showShareButton: currentState.showShareButton,
          ),
        );
      }
    }
  }

  void initUpdateProjectStream(String id) {
    _productInteractor.updateProductStream().listen((event) {
      getProductDetails(id);
    });
  }
}
