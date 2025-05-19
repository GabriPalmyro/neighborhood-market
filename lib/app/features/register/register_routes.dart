import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/eye_control_cubit.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register/register_cubit.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register_step/register_steps_cubit.dart';
import 'package:neighborhood_market/app/features/register/presentation/page/register_page.dart';
import 'package:neighborhood_market/app/features/register/presentation/page/register_payment_page.dart';
import 'package:neighborhood_market/app/features/register/presentation/page/zip_code_not_provided_page.dart';

final registerRoutes = [
  PageRoute(
    route: Routes.register,
    transition: PageTransition.rightToLeft,
    builder: (_, args) {
      final page = int.tryParse(args.uri.queryParameters['page'] ?? '');
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => GetIt.I.get<EyeControlCubit>()),
          BlocProvider(
            create: (_) => GetIt.I.get<RegisterStepsCubit>()
              ..init(
                page: page,
              ),
          ),
          BlocProvider(create: (_) => GetIt.I.get<RegisterCubit>()),
        ],
        child: RegisterPage(
          appNavigator: GetIt.I.get<AppNavigator>(),
        ),
      );
    },
  ),
  PageRoute(
    route: Routes.registerPayment,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => const RegisterPaymentPage(),
  ),
  PageRoute(
    route: Routes.zipCodeNotProvided,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => ZipCodeNotProvidedPage(
      appNavigator: GetIt.I.get<AppNavigator>(),
    ),
  ),
];
