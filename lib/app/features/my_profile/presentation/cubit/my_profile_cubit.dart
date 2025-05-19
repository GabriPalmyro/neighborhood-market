import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/auth/auth_service.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/boundary/my_profile_repository.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/entities/my_profile_entity.dart';

part 'my_profile_state.dart';

@injectable
class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit(this.repository, this.authService) : super(const MyProfileInitial());

  final MyProfileRepository repository;
  final AuthService authService;

  Future<void> getMyProfile() async {
    try {
      emit(const MyProfileLoading());
      final entity = await repository.getMyProfile(); 
      
      if (entity.image?.isNotEmpty == true) {
        authService.setProfilePic(entity.image ?? '');
      }

      if (entity.background?.isNotEmpty == true) {
        authService.setBackgroundPic(entity.background ?? '');
      }

      repository.sentProfileUpdateEvent();
      emit(MyProfileLoaded(entity));
    } catch (e) {
      emit(MyProfileError(e.toString()));
    }
  }

  Future<void> saveMyProfile({
    String? name,
    String? username,
    String? biography,
  }) async {
    final oldEntity = (state as MyProfileLoaded).entity;
    try {
      emit(const MyProfileLoading());

      final userId = await authService.getUserId();

      await repository.saveMyProfile(
        id: userId ?? '',
        name: name,
        username: username,
        biography: biography,
      );

      final entity = await repository.getMyProfile();
      authService.setUserName(entity.username ?? '');
      authService.setUserBio(entity.biography ?? '');

      if (entity.image?.isNotEmpty == true) {
        authService.setProfilePic(entity.image ?? '');
      }

      if (entity.background?.isNotEmpty == true) {
        authService.setBackgroundPic(entity.background ?? '');
      }

      repository.sentProfileUpdateEvent();
      emit(
        MyProfileLoaded(
          entity,
          isSaved: true,
        ),
      );
    } catch (e) {
      emit(
        MyProfileLoaded(
          oldEntity,
          isSaved: true,
          isError: true,
        ),
      );
    }
  }

  Future<void> updateProfilePicture(String newPath) async {
    if (state is! MyProfileLoaded) {
      return;
    }

    final currentState = state as MyProfileLoaded;
    final updatedEntity = currentState.entity.copyWith(image: newPath);

    emit(currentState.copyWith(entity: updatedEntity));

    try {
      authService.setProfilePic(newPath);
      repository.sentProfileUpdateEvent();
    } catch (e) {
      emit(currentState.copyWith(isError: true));
    }
  }

  Future<void> updateBackgroundPicture(String newPath) async {
    if (state is! MyProfileLoaded) {
      return;
    }

    final currentState = state as MyProfileLoaded;
    final updatedEntity = currentState.entity.copyWith(
      background: newPath,
    );

    emit(currentState.copyWith(entity: updatedEntity));

    try {
      authService.setBackgroundPic(newPath);
      repository.sentProfileUpdateEvent();
    } catch (e) {
      emit(currentState.copyWith(isError: true));
    }
  }
}
