import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/auth/auth_service.dart';
import 'package:neighborhood_market/app/common/push_notifications/notifications_service.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/profile/domain/event/profile_update_event.dart';

abstract class ProfileInteractor {
  Future<String> getUserId();
  Future<String> getProfileName();
  Future<String> getProfileDescription();
  Future<String?> getProfileImage();
  Future<String?> getProfileBackground();
  Future<void> logout();
  Stream<ProfileUpdateEvent> profileUpdateStream();
}

@Injectable(as: ProfileInteractor)
class ProfileInteractorImpl implements ProfileInteractor {
  ProfileInteractorImpl(
    this._authService,
    this._notificationsService,
    this.reactiveListener,
  );

  final AuthService _authService;
  final NotificationsService _notificationsService;
  final ReactiveListener reactiveListener;

  @override
  Future<String> getUserId() async {
    return (await _authService.getUserId()) ?? '';
  }

  @override
  Future<String> getProfileName() async {
    return (await _authService.getUserName()) ?? '';
  }

  @override
  Future<String> getProfileDescription() async {
    return (await _authService.getUserBio()) ?? '';
  }

  @override
  Future<void> logout() async {
    _notificationsService.clearExternalId();
    _authService.clearTokens();
  }

  @override
  Future<String?> getProfileImage() async {
    try {
      return await _authService.getProfilePic();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> getProfileBackground() async {
    try {
      return await _authService.getBackgroundPic();
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<ProfileUpdateEvent> profileUpdateStream() => reactiveListener.subscribe<ProfileUpdateEvent>();
}
