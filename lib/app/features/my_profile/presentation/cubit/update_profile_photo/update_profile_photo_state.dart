part of 'update_profile_photo_cubit.dart';

sealed class UpdateProfilePhotoState extends Equatable {
  const UpdateProfilePhotoState();

  @override
  List<Object> get props => [];
}

final class UpdateProfilePhotoInitial extends UpdateProfilePhotoState {
  const UpdateProfilePhotoInitial();

  @override
  List<Object> get props => [];
}

final class UpdateProfilePhotoLoading extends UpdateProfilePhotoState {
  const UpdateProfilePhotoLoading();

  @override
  List<Object> get props => [];
}

final class UpdateProfilePhotoSuccess extends UpdateProfilePhotoState {
  const UpdateProfilePhotoSuccess(this.newPath);
  final String newPath;

  @override
  List<Object> get props => [
        newPath,
      ];
}

final class UpdateProfilePhotoError extends UpdateProfilePhotoState {
  const UpdateProfilePhotoError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
