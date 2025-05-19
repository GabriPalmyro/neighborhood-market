part of 'product_payment_order_cubit.dart';

sealed class ProductPaymentOrderState extends Equatable {
  const ProductPaymentOrderState();

  @override
  List<Object?> get props => [];
}

class ProductPaymentOrderInitial extends ProductPaymentOrderState {
  const ProductPaymentOrderInitial();

  @override
  List<Object> get props => [];
}

class ProductPaymentOrderLoading extends ProductPaymentOrderState {
  const ProductPaymentOrderLoading();

  @override
  List<Object> get props => [];
}

class ProductPaymentOrderLoaded extends ProductPaymentOrderState {
  const ProductPaymentOrderLoaded(
    this.entity, {
    this.purchaseType = PurchaseType.buy,
    this.price,
    this.offerId,
    this.shippingMethod,
    this.paymentMethod,
  });

  final ProductGalleryItemEntity entity;
  final PurchaseType purchaseType;
  final double? price;
  final String? offerId;
  final ShippingMethodEntity? shippingMethod;
  final String? paymentMethod;

  ProductPaymentOrderLoaded copyWith({
    ProductGalleryItemEntity? entity,
    PurchaseType? purchaseType,
    double? price,
    String? offerId,
    ShippingMethodEntity? shippingMethod,
    String? paymentMethod,
  }) {
    return ProductPaymentOrderLoaded(
      entity ?? this.entity,
      purchaseType: purchaseType ?? this.purchaseType,
      price: price ?? this.price,
      offerId: offerId ?? this.offerId,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  double get totalPrice => (price ?? 0.0) + (shippingMethod?.price ?? 0.0);

  @override
  List<Object?> get props => [
        entity,
        purchaseType,
        price,
        offerId,
        shippingMethod,
        paymentMethod,
      ];
}

final class ProductPaymentOrderError extends ProductPaymentOrderState {
  const ProductPaymentOrderError();

  @override
  List<Object> get props => [];
}
