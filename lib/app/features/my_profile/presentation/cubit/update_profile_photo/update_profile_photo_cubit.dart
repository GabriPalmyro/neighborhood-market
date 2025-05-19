import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/boundary/my_profile_repository.dart';

part 'update_profile_photo_state.dart';

@injectable
class UpdateProfilePhotoCubit extends Cubit<UpdateProfilePhotoState> {
  UpdateProfilePhotoCubit(
    this.repository,
  ) : super(const UpdateProfilePhotoInitial());

  final MyProfileRepository repository;

  Future<XFile> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      throw Exception('No image selected');
    }

    return image;
  }

  Future<void> updateProfilePhoto() async {
    emit(const UpdateProfilePhotoLoading());

    try {
      final XFile image = await pickImage();
      final newPath = await repository.updateProfilePicture(
        profilePicture: image.path,
      );
      emit(UpdateProfilePhotoSuccess(newPath));
    } catch (e) {
      emit(UpdateProfilePhotoError(e.toString()));
    }
  }

  Future<void> updateBackgroundPhoto() async {
    emit(const UpdateProfilePhotoLoading());

    try {
      final XFile image = await pickImage();
      final newPath = await repository.updateBackgroundPicture(
        backgroundPicture: image.path,
      );
      emit(UpdateProfilePhotoSuccess(newPath));
    } catch (e) {
      emit(UpdateProfilePhotoError(e.toString()));
    }
  }
}
