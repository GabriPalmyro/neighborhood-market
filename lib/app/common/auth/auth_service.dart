import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/auth/auth_strings.dart';
import 'package:neighborhood_market/app/common/local_database/local_database.dart';
import 'package:neighborhood_market/app/common/network/network_strings.dart';

abstract class AuthService {
  Future<void> setAccessToken(String accessToken);
  Future<String?> getAccessToken();

  Future<void> setRefreshToken(String refreshToken);
  Future<String?> getRefreshToken();

  Future<void> clearTokens();

  Future<void> setUserId(String userId);
  Future<String?> getUserId();

  Future<void> setUserName(String userName);
  Future<String?> getUserName();

  Future<void> setUserBio(String bio);
  Future<String?> getUserBio();

  Future<void> setProfilePic(String profilePic);
  Future<String?> getProfilePic();

  Future<void> setBackgroundPic(String backgroundPic);
  Future<String?> getBackgroundPic();

  Future<void> setUserIsMaster(bool isMaster);
  Future<bool?> getUserIsMaster();

  Future<void> setIsActive(bool isActive);
  Future<bool?> getIsActive();
}

@Singleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  AuthServiceImpl({
    @Named('SecurePreferencesLocalStorage') required this.storage,
  });

  final LocalStorage storage;

  @override
  Future<void> setAccessToken(String accessToken) async {
    await storage.saveData<String>(NetworkStrings.accessToken, accessToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return storage.getData<String>(NetworkStrings.accessToken);
  }

  @override
  Future<void> setRefreshToken(String refreshToken) async {
    await storage.saveData<String>(NetworkStrings.refreshToken, refreshToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return storage.getData<String>(NetworkStrings.refreshToken);
  }

  @override
  Future<void> setUserId(String userId) async {
    await storage.saveData<String>(AuthStrings.userIdKey, userId);
  }

  @override
  Future<String?> getUserId() async {
    return storage.getData<String>(AuthStrings.userIdKey);
  }

  @override
  Future<void> setUserName(String userName) async {
    await storage.saveData<String>(AuthStrings.userNameKey, userName);
  }

  @override
  Future<String?> getUserName() async {
    return storage.getData<String>(AuthStrings.userNameKey);
  }

  @override
  Future<String?> getProfilePic() async {
    return storage.getData<String>(AuthStrings.userPhotoKey);
  }

  @override
  Future<void> setProfilePic(String profilePic) async {
    await storage.saveData<String>(AuthStrings.userPhotoKey, profilePic);
  }

  @override
  Future<void> clearTokens() async {
    Future.wait([
      storage.removeData(NetworkStrings.accessToken),
      storage.removeData(NetworkStrings.refreshToken),
      storage.removeData(AuthStrings.userIdKey),
      storage.removeData(AuthStrings.userNameKey),
      storage.removeData(AuthStrings.userPhotoKey),
      storage.removeData(AuthStrings.userBackgroundPhotKey),
      storage.removeData(AuthStrings.userBioKey),
      storage.removeData(AuthStrings.userIsMasterKey),
    ]);
  }
  
  @override
  Future<String?> getUserBio() {
    return storage.getData<String>(AuthStrings.userBioKey);
  }
  
  @override
  Future<void> setUserBio(String bio) async {
    await storage.saveData<String>(AuthStrings.userBioKey, bio);
  }
  
  @override
  Future<bool?> getUserIsMaster() {
    return storage.getData<bool>(AuthStrings.userIsMasterKey);
  }
  
  @override
  Future<void> setUserIsMaster(bool isMaster) {
    return storage.saveData<bool>(AuthStrings.userIsMasterKey, isMaster);
  }
  
  @override
  Future<String?> getBackgroundPic() {
    return storage.getData<String>(AuthStrings.userBackgroundPhotKey);
  }
  
  @override
  Future<void> setBackgroundPic(String backgroundPic) {
    return storage.saveData<String>(AuthStrings.userBackgroundPhotKey, backgroundPic);
  }

  @override
  Future<bool?> getIsActive() {
    return storage.getData<bool>(AuthStrings.isActiveKey);
  }

  @override
  Future<void> setIsActive(bool isActive) {
    return storage.saveData<bool>(AuthStrings.isActiveKey, isActive);
  }
}
