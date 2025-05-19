part of 'splash_cubit_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();

  @override
  List<Object> get props => [];
}

final class SplashAuthenticated extends SplashState {
  const SplashAuthenticated();

  @override
  List<Object> get props => [];
}

final class SplashDeactivated extends SplashState {
  const SplashDeactivated();

  @override
  List<Object> get props => [];
}

final class SplashUnauthenticated extends SplashState {
  const SplashUnauthenticated();

  @override
  List<Object> get props => [];
}
