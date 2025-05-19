import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/splash/presentation/cubit/splash_cubit_cubit.dart';
import 'package:neighborhood_market/app/features/splash/presentation/splash_page.dart';

final splashRoutes = [
  PageRoute(
    route: Routes.splash,
    builder: (_, __) => BlocProvider(
      create: (context) => GetIt.I.get<SplashCubit>()..checkUserAuthenticated(),
      child: SplashPage(
        appNavigator: GetIt.I.get<AppNavigator>(),
      ),
    ),
  ),
];
