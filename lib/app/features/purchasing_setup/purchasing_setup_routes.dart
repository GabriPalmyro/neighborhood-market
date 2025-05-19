import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/presentation/cubit/purchasing_setup_cubit.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/presentation/page/purchasing_setup_page.dart';

final purchasingSetupRoutes = [
  PageRoute(
    route: Routes.purchasingSetup,
    builder: (_, __) => BlocProvider(
      create: (_) => GetIt.I.get<PurchasingSetupCubit>()..getPurchasingSetup(),
      child: const PurchasingSetupPage(),
    ),
  ),
];
