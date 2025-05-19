part of 'account_management_cubit.dart';

sealed class AccountManagementState extends Equatable {
  const AccountManagementState();

  @override
  List<Object> get props => [];
}

final class AccountManagementInitial extends AccountManagementState {
  const AccountManagementInitial();

  @override
  List<Object> get props => [];
}

final class AccountManagementLoading extends AccountManagementState {
  const AccountManagementLoading();

  @override
  List<Object> get props => [];
}

final class AccountDeactivateSuccess extends AccountManagementState {
  const AccountDeactivateSuccess();

  @override
  List<Object> get props => [];
}

final class AccountDeleteSuccess extends AccountManagementState {
  const AccountDeleteSuccess();

  @override
  List<Object> get props => [];
}

final class AccountActivatedSuccess extends AccountManagementState {
  const AccountActivatedSuccess();

  @override
  List<Object> get props => [];
}

final class AccountManagementError extends AccountManagementState {
  const AccountManagementError(this.message);

  final String message;

  @override
  List<Object> get props => [
    message,
  ];
}
