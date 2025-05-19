import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/auth/auth_service.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/common/push_notifications/notifications_service.dart';
import 'package:neighborhood_market/app/features/login/domain/repositories/login_repository.dart';
import 'package:neighborhood_market/app/features/login/utils/errors/login_errors.dart';
import 'package:neighborhood_market/app/features/login/utils/login_strings.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required this.networkProvider,
    required this.authService,
    required this.notificationsService,
  });

  final NetworkProvider networkProvider;
  final AuthService authService;
  final NotificationsService notificationsService;

  @override
  Future<void> login({required String email, required String password}) async {
    final body = {
      'email': email,
      'password': password,
    };

    final network = await networkProvider.getNoAuthNetworkInstance();

    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await network.post(LoginStrings.loginEndpoint, data: body);
      final data = response.data as Map<String, dynamic>;

      final accessToken = data['token'] as String;
      final userId = data['accounts'][0]['user_id'] as String;
      final userImage = data['profile_pic'] as String?;
      final backgroundImage = data['background'] as String?;
      final userName = data['name'] as String?;
      final userBio = data['bio'] as String?;
      final userIsMaster = data['permission'] == 'master';
      final isActive = data['active'] as bool? ?? true;

      if (!notificationsService.isPermissionGranted()) {
        await notificationsService.requestPermissions();
      }

      await Future.wait([
        authService.setAccessToken(accessToken),
        authService.setUserId(userId),
        authService.setUserIsMaster(userIsMaster),
        userName != null ? authService.setUserName(userName) : Future<void>.value(),
        userImage != null ? authService.setProfilePic(userImage) : Future<void>.value(),
        backgroundImage != null ? authService.setBackgroundPic(backgroundImage) : Future<void>.value(),
        userBio != null ? authService.setUserBio(userBio) : Future<void>.value(),
        notificationsService.setExternalId(userId),
        authService.setIsActive(isActive),
      ]);

      if (!isActive) {
        throw const AccountDeactivated();
      }

    } on DioException catch (e) {
      if (e.response?.statusCode == 402) {
        throw const PaymentRequired();
      } else if (e.response?.statusCode == 403) {
        throw const UserNotValidated();
      } else {
        rethrow;
      }
    }
  }
}
