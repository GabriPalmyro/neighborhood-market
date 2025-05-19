abstract class NotificationsService {
  Future<void> init();
  bool isPermissionGranted();
  Future<void> requestPermissions();
  Future<void> setExternalId(String userId);
  Future<void> clearExternalId();
}