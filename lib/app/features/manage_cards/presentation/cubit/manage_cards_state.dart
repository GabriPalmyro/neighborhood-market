part of 'manage_cards_cubit.dart';

sealed class ManageCardsState extends Equatable {
  const ManageCardsState();

  @override
  List<Object> get props => [];
}

final class ManageCardsInitial extends ManageCardsState {
  const ManageCardsInitial();

  @override
  List<Object> get props => [];
}

final class ManageCardsLoading extends ManageCardsState {
  const ManageCardsLoading();

  @override
  List<Object> get props => [];
}

final class ManageCardsLoaded extends ManageCardsState {
  const ManageCardsLoaded(this.entity);
  final ManageCardsEntity entity;

  @override
  List<Object> get props => [
    entity,
  ];
}

final class ManageCardsError extends ManageCardsState {
  const ManageCardsError();

  @override
  List<Object> get props => [];
}
