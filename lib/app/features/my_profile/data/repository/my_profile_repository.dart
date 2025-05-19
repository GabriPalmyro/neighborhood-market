import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/my_profile/data/model/my_profile_model.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/boundary/my_profile_repository.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/entities/my_profile_entity.dart';
import 'package:neighborhood_market/app/features/profile/domain/event/profile_update_event.dart';

@Injectable(as: MyProfileRepository)
class MyProfileRepositoryImpl implements MyProfileRepository {
  MyProfileRepositoryImpl({
    required this.provider,
    required this.reactiveListener,
  });

  final NetworkProvider provider;
  final ReactiveListener reactiveListener;

  @override
  Future<MyProfileEntity> getMyProfile() async {
    final network = await provider.getNetworkInstance();

    final response = await network.get('/user');

    return MyProfileModel.fromJson(response.data['data']).toEntity();
  }

  @override
  Future<void> saveMyProfile({
    required String id,
    String? name,
    String? username,
    String? biography,
  }) async {
    final network = await provider.getNetworkInstance();

    final body = {
      'id': id,
      'name': name,
      'username': username,
      'bio': biography,
    };

    await network.patch(
      '/user',
      data: body,
    );
  }

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final network = await provider.getNetworkInstance();

    final body = {
      'oldpassword': currentPassword,
      'newpassword': newPassword,
    };

    await network.put(
      '/user/password',
      data: body,
    );
  }

  @override
  Future<String> updateProfilePicture({
    required String profilePicture,
  }) async {
    final network = await provider.getNetworkInstance();

    final formData = FormData();

    final file = File(profilePicture);
    formData.files.add(
      MapEntry(
        'file',
        await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      ),
    );

    final response = await network.put(
      '/user/profile-pic',
      data: formData,
    );

    return response.data['profile_pic']['Location'];
  }

  @override
  Future<String> updateBackgroundPicture({required String backgroundPicture}) async {
    final network = await provider.getNetworkInstance();

    final formData = FormData();

    final file = File(backgroundPicture);
    formData.files.add(
      MapEntry(
        'file',
        await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      ),
    );

    final response = await network.put(
      '/user/background',
      data: formData,
    );

    return response.data['background']['Location'];
  }

  @override
  void sentProfileUpdateEvent() {
    reactiveListener.publish<ProfileUpdateEvent>(
      ProfileUpdateEvent(),
    );
  }

  @override
  Future<void> deactivateAccount() async {
    final network = await provider.getNetworkInstance();

    await network.post('/user/deactivate');
  }

  @override
  Future<void> deleteAccount() async {
    final network = await provider.getNetworkInstance();

    await network.delete('/user/self');
  }

  @override
  Future<void> reactivateAccount() async {
    final network = await provider.getNetworkInstance();

    await network.post('/user/activate');
  }
}
