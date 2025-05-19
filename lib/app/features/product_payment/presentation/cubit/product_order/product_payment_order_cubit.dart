import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/domain/entities/product_gallery_entity.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/boundary/product_payment_order_repository.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/purchase_type_enum.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/shipping_method_entity.dart';

part 'product_payment_order_state.dart';

@injectable
class ProductPaymentOrderCubit extends Cubit<ProductPaymentOrderState> {
  ProductPaymentOrderCubit(this.repository) : super(const ProductPaymentOrderInitial());

  final ProductPaymentOrderRepository repository;

  Future<void> getProductPaymentOrder(
    String productId,
    PurchaseType purchaseType,
    String? offerId,
    double? productOfferPrice,
  ) async {
    emit(const ProductPaymentOrderLoading());
    try {
      ProductGalleryItemEntity entity = await repository.getProductPaymentOrder(productId);

      double? price;

      if (purchaseType != PurchaseType.buy) {
        price = productOfferPrice;
        entity = entity.copyWith(
          price: productOfferPrice,
        );
      } else {
        price = entity.price;
      }

      emit(
        ProductPaymentOrderLoaded(
          entity,
          price: price,
          offerId: offerId,
          purchaseType: purchaseType,
        ),
      );
    } catch (e) {
      emit(const ProductPaymentOrderError());
    }
  }

  void setPaymentMethod(String paymentMethod) {
    final currentState = state;
    if (currentState is ProductPaymentOrderLoaded) {
      emit(
        currentState.copyWith(
          entity: currentState.entity,
          paymentMethod: paymentMethod,
        ),
      );
    }
  }

  void setShippingMethod(ShippingMethodEntity shippingMethod) {
    final currentState = state;
    if (currentState is ProductPaymentOrderLoaded) {
      emit(
        currentState.copyWith(
          entity: currentState.entity,
          shippingMethod: shippingMethod,
        ),
      );
    }
  }
}
