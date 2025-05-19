import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/auth/auth_service.dart';
import 'package:neighborhood_market/app/common/network/interceptors/auth_interceptor.dart';
import 'package:neighborhood_market/app/common/network/interceptors/network_interceptors.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/network/channel/environment_channel.dart';

abstract class NetworkProvider {
  Future<Dio> getNetworkInstance();
  Future<Dio> getNoAuthNetworkInstance();
}

@LazySingleton(as: NetworkProvider)
class NetworkProviderImlp implements NetworkProvider {
  NetworkProviderImlp({
    required this.authService,
    required this.environmentChannel,
    required this.networkInterceptors,
  }) {
    _interceptors = networkInterceptors.interceptors();
    _authInterceptor = networkInterceptors.authInterceptor();
  }

  final AuthService authService;
  final EnvironmentChannel environmentChannel;
  final NetworkInterceptors networkInterceptors;

  late final List<Interceptor> _interceptors;
  late final AuthInterceptor _authInterceptor;

  @override
  Future<Dio> getNetworkInstance() async {
    final Dio newInstance = _provideDio(environmentChannel.getEnvironment());
    return newInstance;
  }

  @override
  Future<Dio> getNoAuthNetworkInstance() async {
    final Dio newInstance = _provideUnathorizedDio(environmentChannel.getEnvironment());
    return newInstance;
  }

  Dio _provideDio(String url) {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.addAll(_interceptors);
    dio.interceptors.add(_authInterceptor);
    return dio;
  }

  Dio _provideUnathorizedDio(String url) {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.addAll(_interceptors);
    return dio;
  }
}
