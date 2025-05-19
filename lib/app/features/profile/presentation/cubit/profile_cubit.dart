import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/Profile/presentation/cubit/Profile_state.dart';
import 'package:neighborhood_market/app/features/profile/domain/event/profile_update_event.dart';
import 'package:neighborhood_market/app/features/profile/domain/profile_interactor.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.interactor) : super(const ProfileInitial());

  final ProfileInteractor interactor;

  late final Stream<ProfileUpdateEvent> _profileUpdateStream;

  Future<void> logout() async {
    await interactor.logout();
  }

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    try {
      final id = await interactor.getUserId();
      final name = await interactor.getProfileName();
      final description = await interactor.getProfileDescription();
      final image = await interactor.getProfileImage();
      final background = await interactor.getProfileBackground();
      emit(ProfileLoaded(id, name, description, image, background));
    } catch (e) {
      emit(const ProfileError());
    }
  }

  void subscribeToProfileUpdates() {
    _profileUpdateStream = interactor.profileUpdateStream()
      ..listen((_) {
        loadProfile();
      });
  }

  @override
  Future<void> close() {
    _profileUpdateStream.drain();
    return super.close();
  }
}
