import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/purchase_details_cubit.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/purchases_completed_cubit.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/purchases_in_progress_cubit.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/pages/my_purchase_details.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/pages/my_purchases_page.dart';

final myPurchasesRoutes = [
  PageRoute(
    route: Routes.myPurchases,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<PurchasesCompletedCubit>()..loadPurchases(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<PurchasesInProgressCubit>()..loadPurchases(),
        ),
      ],
      child: MyPurchasesPage(
        appNavigator: GetIt.I.get<AppNavigator>(),
      ),
    ),
  ),
  PageRoute(
    route: Routes.myPurchaseDetails,
    transition: PageTransition.rightToLeft,
    builder: (_, args) {
      final purchaseId = args.uri.queryParameters['purchaseId'] as String;
      return BlocProvider(
        create: (context) => GetIt.I.get<PurchaseDetailsCubit>()
          ..loadPurchaseDetails(
            purchaseId,
          ),
        child: PurchaseDetailsPage(
          purchaseId: purchaseId,
        ),
      );
    },
  ),
];
