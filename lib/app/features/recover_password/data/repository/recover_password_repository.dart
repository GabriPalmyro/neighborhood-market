import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/recover_password/domain/boundary/recover_password_repository.dart';

@Injectable(as: RecoverPasswordRepository)
class RecoverPasswordRepositoryImpl implements RecoverPasswordRepository {
  RecoverPasswordRepositoryImpl({required this.provider});
  final NetworkProvider provider;

  @override
  Future<void> resetPassword(
    String email,
    String newPassword,
    String jwt,
  ) async {
    final network = await provider.getNoAuthNetworkInstance();

    try {
      await network.post(
        '/auth/password/reset',
        data: {
          'email': email,
          'password': newPassword,
          'jwt': jwt,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendCodeToEmail(String email) async {
    final network = await provider.getNoAuthNetworkInstance();

    try {
      await network.post(
        '/auth/password/reset/request',
        data: {
          'email': email,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> validateRecoveryCode(String code) async {
    final network = await provider.getNoAuthNetworkInstance();

    try {
      final response = await network.post('/account/validate/$code');
      return response.data['jwt'];
    } catch (e) {
      rethrow;
    }
  }
}
