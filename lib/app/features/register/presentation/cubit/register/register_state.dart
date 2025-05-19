import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();

  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();

  @override
  List<Object> get props => [];
}

class ZipCodeNotProvidedFailure extends RegisterState {
  const ZipCodeNotProvidedFailure();

  @override
  List<Object> get props => [];
}

class RegisterFailure extends RegisterState {
  const RegisterFailure(this.error);
  final String? error;

  @override
  List<Object> get props => [];
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess();

  @override
  List<Object> get props => [];
}
