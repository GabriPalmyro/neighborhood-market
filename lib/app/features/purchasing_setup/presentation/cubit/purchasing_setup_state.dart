part of 'purchasing_setup_cubit.dart';

sealed class PurchasingSetupState extends Equatable {
  const PurchasingSetupState();

  @override
  List<Object> get props => [];
}

final class PurchasingSetupInitial extends PurchasingSetupState {
  const PurchasingSetupInitial();

  @override
  List<Object> get props => [];
}

final class PurchasingSetupLoading extends PurchasingSetupState {
  const PurchasingSetupLoading();

  @override
  List<Object> get props => [];
}

final class PurchasingSetupLoaded extends PurchasingSetupState {
  const PurchasingSetupLoaded(this.paymentMethods);
  final List<PaymentMethodEntity> paymentMethods;

  @override
  List<Object> get props => [
    paymentMethods,
  ];
}

final class PurchasingSetupError extends PurchasingSetupState {
  const PurchasingSetupError();

  @override
  List<Object> get props => [];
}
