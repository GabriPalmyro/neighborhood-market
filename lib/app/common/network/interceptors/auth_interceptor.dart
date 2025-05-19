import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:neighborhood_market/app/common/auth/auth_service.dart';
import 'package:neighborhood_market/app/common/network/network_strings.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(
    this.authService,
    this.refreshTokenPath,
  );

  final AuthService authService;
  final String refreshTokenPath;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await authService.getAccessToken();
      if (accessToken != null) {
        options.headers[NetworkStrings.authorizationHeader] = 'Bearer $accessToken';
      }
    } finally {
      handler.next(options);
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Try to refresh the access token
      final refreshed = await _refreshAccessToken();
      if (refreshed) {
        // Retry the original request with the new access token
        final retryRequest = err.requestOptions;
        final accessToken = await authService.getAccessToken();
        if (accessToken != null) {
          retryRequest.headers[NetworkStrings.authorizationHeader] = 'Bearer $accessToken';
        }
        handler.resolve(await Dio().fetch(retryRequest));
        return;
      }
    } else if (err.response?.statusCode == 429) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: DioExceptionType.sendTimeout,
          error: 'Too many requests - please try again later.',
          message: 'Too many requests - please try again later.',
        ),
      );
    }
    handler.next(err);
  }

  Future<bool> _refreshAccessToken() async {
    final refreshToken = await authService.getAccessToken();
    if (refreshToken == null) {
      return false;
    }

    try {
      final dio = Dio();
      final response = await dio.post(
        refreshTokenPath,
        data: {NetworkStrings.accessToken: refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data[NetworkStrings.accessToken];
        final newRefreshToken = response.data[NetworkStrings.refreshToken];
        await authService.setAccessToken(newAccessToken);
        await authService.setRefreshToken(newRefreshToken);
        return true;
      }
    } catch (e) {
      log('Failed to refresh access token: $e');
    }
    return false;
  }
}
