part of 'offer_cubit.dart';

sealed class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object> get props => [];
}

final class OfferInitial extends OfferState {
  const OfferInitial();

  @override
  List<Object> get props => [];
}

final class OfferLoading extends OfferState {
  const OfferLoading();

  @override
  List<Object> get props => [];
}

final class OfferAcceptLoading extends OfferState {
  const OfferAcceptLoading();

  @override
  List<Object> get props => [];
}

final class OfferDeclineLoading extends OfferState {
  const OfferDeclineLoading();

  @override
  List<Object> get props => [];
}

final class OfferSuccess extends OfferState {
  const OfferSuccess();

  @override
  List<Object> get props => [];
}

final class OfferFailure extends OfferState {
  const OfferFailure(this.message);
  final String message;

  @override
  List<Object> get props => [];
}
