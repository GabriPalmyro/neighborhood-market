import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/core/app_strings.dart';

abstract class FeatureFlagService {
  Future<bool> getBool(String key);
  Future<String> getString(String key);
  Future<int> getInt(String key);
}

@Singleton(as: FeatureFlagService)
class FeatureFlagServiceImpl implements FeatureFlagService {
  FeatureFlagServiceImpl() {
    initialize();
  }

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    try {
      // Define valores padrão para as flags
      await _remoteConfig.setDefaults(<String, dynamic>{
        AppStrings.enableShareLinkKey: false,
        AppStrings.deeplinkSharePrefixKey: AppStrings.firebaseUrlPrefix,
        AppStrings.defaultFallbackUrlKey: AppStrings.deeplinkFallbackUrl,
      });

      await _remoteConfig.fetch();
      await _remoteConfig.activate();
    } catch (e) {
      log('There was an error fetching remote config: $e');
    }
  }

  @override
  Future<bool> getBool(String key) async {
    return _remoteConfig.getBool(key);
  }

  @override
  Future<int> getInt(String key) async {
    return _remoteConfig.getInt(key);
  }

  @override
  Future<String> getString(String key) async {
    return _remoteConfig.getString(key);
  }
}
