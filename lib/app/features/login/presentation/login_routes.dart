import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:neighborhood_market/app/features/login/presentation/page/login_page.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/eye_control_cubit.dart';

final loginRoutes = [
  PageRoute(
    route: Routes.login,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I.get<EyeControlCubit>()),
        BlocProvider(create: (_) => GetIt.I.get<LoginCubit>()),
      ],
      child: LoginPage(
        appNavigator: GetIt.I.get<AppNavigator>(),
      ),
    ),
  ),
];
