import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/register/domain/repositories/register_repository.dart';
import 'package:neighborhood_market/app/features/register/utils/register_string.dart';

@LazySingleton(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl({
    required this.networkProvider,
  });

  final NetworkProvider networkProvider;

  @override
  Future<void> completeProfile({
    required String userId,
    required String username,
    required String fullName,
    required String birthDate,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String zip,
  }) async {
    final body = {
      'id': userId,
      'username': username,
      'name': fullName,
      'birthDate': birthDate,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
      'zipCode': zip,
    };

    final network = await networkProvider.getNoAuthNetworkInstance();

    await network.post(RegisterStrings.stepThreeEndpoint, data: body);
  }

  @override
  Future<void> registerUser({
    required String email,
    required String phoneNumber,
    required String password,
    required String timezone,
  }) async {
    final body = {
      'email': email,
      'phone': phoneNumber,
      'password': password,
      'timezone': timezone,
    };

    final network = await networkProvider.getNoAuthNetworkInstance();

    await network.post(RegisterStrings.stepOneEndpoint, data: body);
  }

  @override
  Future<void> resendOTPCode({
    required String userId,
  }) {
    // TODO: implement resendOTPCode
    throw UnimplementedError();
  }

  @override
  Future<String> verifyOTPCode({
    required String otpCode,
  }) async {
    final network = await networkProvider.getNoAuthNetworkInstance();
    final response = await network.post(RegisterStrings.stepTwoEndpoint + otpCode);
    final data = response.data as Map<String, dynamic>;
    return data['id'];
  }

  @override
  Future<String> getTimezone() async {
    try {
      final String timeZone = await FlutterTimezone.getLocalTimezone();
      return timeZone;
    } catch (e) {
      return 'America/Chicago';
    }
  }
}
