import 'dart:developer';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/environment/domain/entities/env_type.dart';

abstract class EnvironmentChannel {
  void setEnvironment(EnvType environment);
  String getEnvironment();
  EnvType getEnvType();
}

@Singleton(as: EnvironmentChannel)
class EnvironmentChannelImpl implements EnvironmentChannel {
  EnvType _envType = EnvType.dev;

  @override
  String getEnvironment() {
    switch (_envType) {
      case EnvType.dev:
        return 'http://98.85.112.215:8080/api';
      case EnvType.remote:
        return Platform.isAndroid ? 'http://192.168.15.131:3001' : 'http://127.0.0.1:3001';
      case EnvType.localApi:
        return 'http://192.168.15.131:8080/api';
      case EnvType.prod:
        return 'https://api.neighborhoodmarket.com';
    }
  }

  @override
  void setEnvironment(EnvType environment) {
    log('Environment Changed to: $environment');
    _envType = environment;
  }

  @override
  EnvType getEnvType() {
    return _envType;
  }
}
