import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/cubit/recover_password_cubit.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/page/enter_new_password_page.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/page/recover_password_code_page.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/page/recover_password_page.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/page/recover_password_success_page.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/eye_control_cubit.dart';

final recoverPasswordRoutes = [
  PageRoute(
    route: Routes.recoverPassword,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => BlocProvider(
      create: (_) => GetIt.I.get<RecoverPasswordCubit>(),
      child: RecoverPasswordPage(
        appNavigator: GetIt.I.get<AppNavigator>(),
      ),
    ),
  ),
  PageRoute(
    route: Routes.recoverPasswordCode,
    transition: PageTransition.rightToLeft,
    builder: (_, args) {
      final email = args.uri.queryParameters['email'];
      return BlocProvider(
        create: (_) => GetIt.I.get<RecoverPasswordCubit>()
          ..initToCode(
            email ?? '',
          ),
        child: RecoverPasswordCodePage(
          appNavigator: GetIt.I.get<AppNavigator>(),
        ),
      );
    },
  ),
  PageRoute(
    route: Routes.recoverPasswordNewPassword,
    transition: PageTransition.rightToLeft,
    builder: (_, args) {
      final email = args.uri.queryParameters['email'];
      final jwt = args.uri.queryParameters['jwt'];
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GetIt.I.get<RecoverPasswordCubit>()
              ..initToNewPassword(
                email ?? '',
                jwt ?? '',
              ),
          ),
          BlocProvider(create: (_) => GetIt.I.get<EyeControlCubit>()),
        ],
        child: EnterNewPasswordPage(
          appNavigator: GetIt.I.get<AppNavigator>(),
        ),
      );
    },
  ),
  PageRoute(
    route: Routes.recoverPasswordSuccess,
    transition: PageTransition.rightToLeft,
    builder: (_, args) {
      final email = args.uri.queryParameters['email'];
      return RecoverPasswordSuccessPage(
        email: email ?? '',
        appNavigator: GetIt.I.get<AppNavigator>(),
      );
    },
  ),
];
