import 'package:flutter/widgets.dart' hide PageRoute;
import 'package:go_router/go_router.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/widgets/not_found_page.dart';

class AppRouterConfig {
  AppRouterConfig({
    required List<PageRoute> routes,
  }) : _router = GoRouter(
          initialLocation: Routes.splash.path,
          routes: routes
              .map<GoRoute>((PageRoute route) => route.toGoRoute())
              .toList(),
          errorBuilder: (context, state) => const NotFoundPage(),
          redirect: (BuildContext context, GoRouterState state) => null,
        );

  final GoRouter _router;
  GoRouter get router => _router;
}
