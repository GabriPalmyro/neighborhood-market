part of 'delete_listing_cubit.dart';

sealed class DeleteListingState extends Equatable {
  const DeleteListingState();

  @override
  List<Object> get props => [];
}

final class DeleteListingInitial extends DeleteListingState {
  const DeleteListingInitial();

  @override
  List<Object> get props => [];
}

final class DeleteListingLoading extends DeleteListingState {
  const DeleteListingLoading();

  @override
  List<Object> get props => [];
}

final class DeleteListingSuccess extends DeleteListingState {
  const DeleteListingSuccess();

  @override
  List<Object> get props => [];
}

final class DeleteListingFailure extends DeleteListingState {
  const DeleteListingFailure(this.message);
  final String message;

  @override
  List<Object> get props => [];
}
