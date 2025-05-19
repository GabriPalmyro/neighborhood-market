import 'package:neighborhood_market/app/features/my_profile/domain/entities/my_profile_entity.dart';

abstract class MyProfileRepository {
  Future<MyProfileEntity> getMyProfile();

  Future<void> saveMyProfile({
    required String id,
    String? name,
    String? username,
    String? biography,
  });

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<String> updateProfilePicture({
    required String profilePicture,
  });

  Future<String> updateBackgroundPicture({
    required String backgroundPicture,
  });

  Future<void> deactivateAccount();

  Future<void> deleteAccount();

  void sentProfileUpdateEvent();

  Future<void> reactivateAccount();
}
