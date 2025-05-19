import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/manage_cards/presentation/cubit/manage_cards_cubit.dart';
import 'package:neighborhood_market/app/features/manage_cards/presentation/page/manage_cards_page.dart';

final manageCardsRoutes = [
  PageRoute(
    route: Routes.manageCards,
    builder: (_, __) => BlocProvider(
      create: (context) => GetIt.I.get<ManageCardsCubit>()
        ..getManageCards(
          userId: '1',
        ),
      child: const ManageCardsPage(),
    ),
  ),
];
