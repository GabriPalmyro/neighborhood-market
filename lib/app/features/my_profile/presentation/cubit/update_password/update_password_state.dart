part of 'update_password_cubit.dart';

sealed class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

final class UpdatePasswordInitial extends UpdatePasswordState {
  const UpdatePasswordInitial();

  @override
  List<Object> get props => [];
}

final class UpdatePasswordLoading extends UpdatePasswordState {
  const UpdatePasswordLoading();

  @override
  List<Object> get props => [];
}

final class UpdatePasswordSuccess extends UpdatePasswordState {
  const UpdatePasswordSuccess();

  @override
  List<Object> get props => [];
}

final class UpdatePasswordFailure extends UpdatePasswordState {
  const UpdatePasswordFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
