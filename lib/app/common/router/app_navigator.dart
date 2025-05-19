import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/router/router_config.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AppNavigator {
  Future<void> pushRoute(
    Routes route, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? arguments,
  });
  Future<void> pushToUrl(
    Uri url, {
    LaunchMode? mode,
  });
  Future<void> pushReplacementNamed(
    Routes route, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? arguments,
  });
  Future<void> pushNamedAndRemoveUntil(
    Routes route, {
    Routes? until,
    Object? arguments,
  });
  void popAndPushNamed(Routes route);
  void pop<T>([T? result]);
  void popUntilRoute(Routes route, {bool checkIfInStack = false});
  bool checkIfRouteIsInStack(Routes route);
  bool canPop();
}

@LazySingleton(as: AppNavigator)
class AppNavigatorImpl implements AppNavigator {
  AppNavigatorImpl(this.navigator);
  final AppRouterConfig navigator;

  @override
  Future<void> pushRoute(
    Routes route, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? arguments,
  }) async =>
      navigator.router.pushNamed(
        route.name,
        extra: arguments,
        pathParameters: pathParameters ?? {},
        queryParameters: queryParameters ?? {},
      );

  @override
  void pop<T>([T? result]) {
    navigator.router.canPop() ? navigator.router.pop(result) : SystemNavigator.pop(animated: true);
  }

  @override
  Future<void> pushReplacementNamed(
    Routes route, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? arguments,
  }) async {
    navigator.router.pushReplacementNamed(
      route.name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: arguments,
    );
  }

  @override
  bool checkIfRouteIsInStack(Routes route) {
    final routeInsideStack = navigator.router.routerDelegate.currentConfiguration.matches.any((match) {
      return match.matchedLocation == route.path;
    });
    return routeInsideStack;
  }

  @override
  bool canPop() => navigator.router.canPop();

  @override
  void popUntilRoute(Routes route, {bool checkIfInStack = false}) {
    if (checkIfInStack) {
      if (!checkIfRouteIsInStack(route)) {
        return;
      }
    }

    while (navigator.router.routerDelegate.currentConfiguration.matches.last.matchedLocation != route.path) {
      if (!navigator.router.canPop()) {
        return;
      }
      navigator.router.pop();
    }
  }

  @override
  Future<void> pushNamedAndRemoveUntil(
    Routes route, {
    Routes? until,
    Object? arguments,
  }) async {
    while (canPop()) {
      pop();
    }
    pushReplacementNamed(route, arguments: arguments);
  }

  @override
  void popAndPushNamed(Routes route) {
    if (!canPop()) {
      pop();
    }
    pushRoute(route);
  }

  @override
  Future<void> pushToUrl(
    Uri url, {
    LaunchMode? mode,
  }) {
    return _launchUrl(url, mode: mode);
  }

  Future<void> _launchUrl(
    Uri url, {
    LaunchMode? mode,
  }) async {
    if (url.host == 'main') {
      navigator.router.push('${url.path}?${url.query}');
      return;
    }

    if (!await launchUrl(
      url,
      mode: mode ?? LaunchMode.platformDefault,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
