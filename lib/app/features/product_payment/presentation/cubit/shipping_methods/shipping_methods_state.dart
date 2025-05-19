part of 'shipping_methods_cubit.dart';

sealed class ShippingMethodsState extends Equatable {
  const ShippingMethodsState();

  @override
  List<Object> get props => [];
}

final class ShippingMethodsInitial extends ShippingMethodsState {
  const ShippingMethodsInitial();

  @override
  List<Object> get props => [];
}

final class ShippingMethodsLoading extends ShippingMethodsState {
  const ShippingMethodsLoading();

  @override
  List<Object> get props => [];
}

final class ShippingMethodsLoaded extends ShippingMethodsState {
  const ShippingMethodsLoaded(
    this.shippingMethods,
  );

  final List<ShippingMethodEntity> shippingMethods;

  ShippingMethodsLoaded copyWith({
    List<ShippingMethodEntity>? shippingMethods,
  }) {
    return ShippingMethodsLoaded(
      shippingMethods ?? this.shippingMethods,
    );
  }

  @override
  List<Object> get props => [
        shippingMethods,
      ];
}

final class ShippingMethodsFailure extends ShippingMethodsState {
  const ShippingMethodsFailure(this.error);

  final String error;

  @override
  List<Object> get props => [
        error,
      ];
}
