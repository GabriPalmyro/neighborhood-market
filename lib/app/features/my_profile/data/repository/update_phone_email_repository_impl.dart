import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/boundary/update_phone_email_repository.dart';

@Injectable(as: UpdatePhoneEmailRepository)
class UpdatePhoneEmailRepositoryImpl implements UpdatePhoneEmailRepository {
  UpdatePhoneEmailRepositoryImpl({required this.provider});

  final NetworkProvider provider;

  @override
  Future<void> sendCodeToNewEmail(String newEmail) async {
    final network  = await provider.getNetworkInstance();

    final body = {
      'type': 'email',
      'email': newEmail,
    };

    await network.post(
      '/user/email-or-phone',
      data: body,
    );
  }

  @override
  Future<void> sendCodeToNewPhone(String newPhone) async {
    final network  = await provider.getNetworkInstance();

    final body = {
      'type': 'phone',
      'phone': newPhone,
    };

    await network.post(
      '/user/email-or-phone',
      data: body,
    );
  }

  @override
  Future<void> verifyCode(String verifyCode) async {
    final network  = await provider.getNetworkInstance();

    await network.post('/user/email-or-phone/$verifyCode');
  }
  
}