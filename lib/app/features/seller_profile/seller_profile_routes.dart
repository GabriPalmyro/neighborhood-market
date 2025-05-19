import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/seller_profile/presentation/cubit/seller_profile_cubit.dart';
import 'package:neighborhood_market/app/features/seller_profile/presentation/cubit/seller_reviews_cubit.dart';
import 'package:neighborhood_market/app/features/seller_profile/presentation/page/seller_profile_page.dart';
import 'package:neighborhood_market/app/features/seller_profile/presentation/page/seller_reviews_page.dart';

final sellerProfileRoutes = [
  PageRoute(
    route: Routes.sellerProfile,
    transition: PageTransition.rightToLeft,
    builder: (_, args) {
      final sellerId = args.uri.queryParameters['sellerId'] as String;
      return BlocProvider(
        create: (context) => GetIt.I.get<SellerProfileCubit>()
          ..getSellerProfile(
            sellerId,
          ),
        child: SellerProfilePage(
          sellerId: sellerId,
          appNavigator: GetIt.I.get<AppNavigator>(),
        ),
      );
    },
  ),
  PageRoute(
    route: Routes.sellerReviews,
    transition: PageTransition.rightToLeft,
    builder: (_, args) {
      final sellerId = args.uri.queryParameters['sellerId'] ?? '';
      return BlocProvider(
        create: (context) => GetIt.I.get<SellerReviewsCubit>()
          ..getSellerReviews(
            sellerId,
          ),
        child: const SellerReviewsPage(),
      );
    },
  ),
];
