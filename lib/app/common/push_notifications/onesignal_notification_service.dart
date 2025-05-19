import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/push_notifications/notifications_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/app_strings.dart';

@Singleton(as: NotificationsService)
class OnesignalNotificationService implements NotificationsService {
  OnesignalNotificationService() {
    init();
  }

  @override
  Future<void> init() async {
    log('Initializing OneSignal Notifications');

    if (kDebugMode) {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    }

    try {
      final oneSignalAppId = dotenv.get(AppStrings.oneSignalAppID);
      OneSignal.initialize(oneSignalAppId);
    } catch (e) {
      log('Error initializing OneSignal: $e');
    }
  }

  @override
  bool isPermissionGranted() {
    return OneSignal.Notifications.permission;
  }

  @override
  Future<void> requestPermissions() async {
    await OneSignal.Notifications.requestPermission(true);
  }

  @override
  Future<void> setExternalId(String userId) async {
    await OneSignal.login(userId);
  }

  @override
  Future<void> clearExternalId() {
    return OneSignal.logout();
  }
}
