part of 'my_profile_cubit.dart';

sealed class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object> get props => [];
}

final class MyProfileInitial extends MyProfileState {
  const MyProfileInitial();

  @override
  List<Object> get props => [];
}

final class MyProfileLoading extends MyProfileState {
  const MyProfileLoading();

  @override
  List<Object> get props => [];
}

final class MyProfileLoaded extends MyProfileState {
  const MyProfileLoaded(
    this.entity, {
    this.isSaved = false,
    this.isError = false,
  });

  final MyProfileEntity entity;
  final bool isSaved;
  final bool isError;

  MyProfileLoaded copyWith({
    MyProfileEntity? entity,
    bool? isSaved,
    bool? isError,
  }) {
    return MyProfileLoaded(
      entity ?? this.entity,
      isSaved: isSaved ?? this.isSaved,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props => [entity, isSaved, isError];
}

final class MyProfileError extends MyProfileState {
  const MyProfileError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}
