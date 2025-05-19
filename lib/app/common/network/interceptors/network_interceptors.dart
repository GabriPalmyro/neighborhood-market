import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/auth/auth_service.dart';
import 'package:neighborhood_market/app/common/network/interceptors/auth_interceptor.dart';
import 'package:neighborhood_market/app/common/network/network_strings.dart';
import 'package:neighborhood_market/app/common/xdebugging/external/debugging_settings.dart';

abstract class NetworkInterceptors {
  List<Interceptor> interceptors();
  AuthInterceptor authInterceptor();
}

@Injectable(as: NetworkInterceptors)
class NetworkInterceptorsImpl implements NetworkInterceptors {
  NetworkInterceptorsImpl(this.authService);
  final AuthService authService;

  @override
  List<Interceptor> interceptors() {
    return [
      LogInterceptor(responseBody: true, requestBody: true),
      DebuggingSettings.instance.interceptor,
    ];
  }

  @override
  AuthInterceptor authInterceptor() {
    return AuthInterceptor(
      authService,
      NetworkStrings.refreshTokenPath,
    );
  }
}
