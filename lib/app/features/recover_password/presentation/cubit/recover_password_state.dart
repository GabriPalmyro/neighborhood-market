import 'package:equatable/equatable.dart';

sealed class RecoverPasswordState extends Equatable {
  const RecoverPasswordState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class RecoverPasswordInitial extends RecoverPasswordState {
  const RecoverPasswordInitial();

  @override
  List<Object?> get props => [];
}

/// Loading state for asynchronous operations
class RecoverPasswordLoading extends RecoverPasswordState {
  const RecoverPasswordLoading({this.email});
  final String? email;

  @override
  List<Object?> get props => [
        email,
      ];
}

/// State when code is sent to the email
class RecoverPasswordCodeSent extends RecoverPasswordState {
  const RecoverPasswordCodeSent(this.email);
  final String email;

  @override
  List<Object?> get props => [email];
}

/// State when code validation is successful
class RecoverPasswordCodeValidated extends RecoverPasswordState {
  const RecoverPasswordCodeValidated(this.email, this.jwt);
  final String email;
  final String jwt;

  @override
  List<Object?> get props => [
        email,
        jwt,
      ];
}

/// State when password is successfully reset
class RecoverPasswordSuccess extends RecoverPasswordState {
  const RecoverPasswordSuccess(this.email);
  final String email;

  @override
  List<Object?> get props => [
        email,
      ];
}

/// State when an error occurs
class RecoverPasswordError extends RecoverPasswordState {
  const RecoverPasswordError({required this.message, this.email, this.jwt});
  final String? email;
  final String? jwt;
  final String message;

  @override
  List<Object?> get props => [message, email, jwt];
}
