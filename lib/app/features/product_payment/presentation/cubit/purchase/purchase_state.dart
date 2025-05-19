part of 'purchase_cubit.dart';

sealed class PurchaseState extends Equatable {
  const PurchaseState();

  @override
  List<Object?> get props => [];
}

final class PurchaseInitial extends PurchaseState {
  const PurchaseInitial();

  @override
  List<Object> get props => [];
}

final class PurchaseLoading extends PurchaseState {
  const PurchaseLoading();

  @override
  List<Object> get props => [];
}

final class PurchaseSuccess extends PurchaseState {
  const PurchaseSuccess();

  @override
  List<Object> get props => [];
}

final class PaymentIntentSuccess extends PurchaseState {
  const PaymentIntentSuccess(this.paymentData);
  final PaymentDataEntity paymentData;

  @override
  List<Object> get props => [
        paymentData,
      ];
}

final class PaymentConfirmed extends PurchaseState {
  const PaymentConfirmed(
    this.transactioDate,
    this.paymentMethod,
    this.delivery,
    this.product,
  );
  final DateTime transactioDate;
  final String paymentMethod;
  final ShippingMethodEntity? delivery;
  final ProductGalleryItemEntity? product;

  double get totalPrice => (product?.price ?? 0.0) + (delivery?.price ?? 0);
  
  @override
  List<Object?> get props => [
        transactioDate,
        paymentMethod,
        delivery,
        product,
      ];
}

final class PurchaseError extends PurchaseState {
  const PurchaseError(this.exception);
  final Exception exception;

  @override
  List<Object> get props => [
        exception,
      ];
}
