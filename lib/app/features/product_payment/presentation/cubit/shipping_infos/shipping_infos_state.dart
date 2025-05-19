part of 'shipping_infos_cubit.dart';

sealed class ShippingInfosState extends Equatable {
  const ShippingInfosState();

  @override
  List<Object> get props => [];
}

final class ShippingInfosInitial extends ShippingInfosState {
  const ShippingInfosInitial();

  @override
  List<Object> get props => [];
}

final class ShippingInfosLoading extends ShippingInfosState {
  const ShippingInfosLoading();

  @override
  List<Object> get props => [];
}

final class ShippingInfosLoaded extends ShippingInfosState {
  const ShippingInfosLoaded(
    this.shippingInfos, {
    this.enableEditing = false,
  });

  final ShippingInformationsEntity shippingInfos;
  final bool enableEditing;

  ShippingInfosLoaded copyWith({
    ShippingInformationsEntity? shippingInfos,
    bool? enableEditing,
  }) {
    return ShippingInfosLoaded(
      shippingInfos ?? this.shippingInfos,
      enableEditing: enableEditing ?? this.enableEditing,
    );
  }

  @override
  List<Object> get props => [shippingInfos, enableEditing];
}