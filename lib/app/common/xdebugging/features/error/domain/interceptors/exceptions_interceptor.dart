import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/error/di/error_module.dart';

import '../../../../core/data/repository/shared_preferences_repository.dart';
import '../../data/models/exception_catch.dart';

class ExceptionInterceptor {
  late final SharedPreferencesRepository _repository = ExceptionModule().repository;
  late DateTime _exceptionTime;

  /// Save exceptions to a repository or log them
  Future<void> saveException({
    required DateTime exceptionTime,
    required String exceptionMessage,
    required String stackTrace,
    required String contextInfo,
  }) async {
    try {
      // Replace with your repository save logic
      final exceptionCatch = ExceptionCatch(
        timestamp: exceptionTime,
        errorMessage: exceptionMessage,
        stackTrace: stackTrace,
        errorType: contextInfo,
      );

      // Example: Save to SharedPreferences (adjust as needed)
      await _repository.save(exceptionCatch);
    } catch (_) {}
  }

  /// Intercept Flutter framework errors
  void initialize() {
    FlutterError.onError = (FlutterErrorDetails details) async {
      _exceptionTime = DateTime.now();
      await saveException(
        exceptionTime: _exceptionTime,
        exceptionMessage: details.exceptionAsString(),
        stackTrace: details.stack.toString(),
        contextInfo: details.context?.toString() ?? 'No context available',
      );
      FlutterError.presentError(details); // Optionally display the error
    };
  }

  /// Capture asynchronous errors
  void captureAsyncErrors(void Function() appRunner) {
    runZonedGuarded(
      appRunner,
      (error, stackTrace) async {
        _exceptionTime = DateTime.now();
        await saveException(
          exceptionTime: _exceptionTime,
          exceptionMessage: error.toString(),
          stackTrace: stackTrace.toString(),
          contextInfo: 'Unhandled asynchronous error',
        );
      },
    );
  }
}
