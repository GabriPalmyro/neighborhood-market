part of 'purchase_details_cubit.dart';

sealed class PurchaseDetailsState extends Equatable {
  const PurchaseDetailsState();

  @override
  List<Object> get props => [];
}

final class PurchaseDetailsInitial extends PurchaseDetailsState {
  const PurchaseDetailsInitial();

  @override
  List<Object> get props => [];
}

final class PurchaseDetailsLoading extends PurchaseDetailsState {
  const PurchaseDetailsLoading();

  @override
  List<Object> get props => [];
}

final class PurchaseDetailsLoaded extends PurchaseDetailsState {
  const PurchaseDetailsLoaded(this.purchase);
  final PurchaseDetailsEntity purchase;

  @override
  List<Object> get props => [purchase];
}

final class PurchaseDetailsError extends PurchaseDetailsState {
  const PurchaseDetailsError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
