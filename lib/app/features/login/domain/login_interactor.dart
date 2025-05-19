import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/login/domain/repositories/login_repository.dart';
import 'package:neighborhood_market/app/utils/errors/exceptions.dart';

abstract class LoginInteractor {
  Future<void> login({required String email, required String password});
}

@LazySingleton(as: LoginInteractor)
class LoginInteractorImpl implements LoginInteractor {
  LoginInteractorImpl(this.repository);
  final LoginRepository repository;

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await repository.login(email: email, password: password);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const UnauthorizedException();
      } else {
        throw BadRequestException(
          e.response?.data['message'] as String,
        );
      }
    }
  }
}
