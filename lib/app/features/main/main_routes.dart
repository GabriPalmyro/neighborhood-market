import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/category_selection/category_selection_cubit.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/page/select_product_category_page.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/filter_cubit.dart';
import 'package:neighborhood_market/app/features/explore/presentation/page/filter_page.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/notifications/notifications_cubit.dart';
import 'package:neighborhood_market/app/features/main/presentation/cubit/main_page_cubit.dart';
import 'package:neighborhood_market/app/features/main/presentation/page/main_page.dart';
import 'package:neighborhood_market/app/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:neighborhood_market/app/features/notifications/presentation/page/notification_page.dart';
import 'package:neighborhood_market/app/features/product/presentation/cubit/image_full_view/image_full_view_cubit.dart';
import 'package:neighborhood_market/app/features/product/presentation/cubit/product_details_cubit.dart';
import 'package:neighborhood_market/app/features/product/presentation/page/product_page.dart';

final mainRoutes = [
  PageRoute(
    route: Routes.main,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I.get<NotificationsHomeCubit>()..getNotifications(),
        ),
        BlocProvider(
          create: (_) => GetIt.I.get<MainPageCubit>(),
        ),
      ],
      child: MainTabsPage(
        appNavigator: GetIt.I.get<AppNavigator>(),
      ),
    ),
    routes: [
      PageRoute(
        route: Routes.filter,
        transition: PageTransition.rightToLeft,
        builder: (_, args) {
          final String? filter = args.uri.queryParameters['sortBy'];
          final List<String> conditions = args.uri.queryParameters['filters']?.split(',') ?? [];
          final double? minPrice = double.tryParse(args.uri.queryParameters['minPrice'] ?? '');
          final double? maxPrice = double.tryParse(args.uri.queryParameters['maxPrice'] ?? '');
          final String? gender = args.uri.queryParameters['gender'];
          final String? clothingSize = args.uri.queryParameters['clothingSize'];
          final String? shoeSize = args.uri.queryParameters['shoeSize'];
          return BlocProvider(
            create: (_) => GetIt.I.get<FilterCubit>()
              ..selectFilters(
                sortBy: filter,
                conditions: conditions,
                minPrice: minPrice,
                maxPrice: maxPrice,
                gender: gender,
                clothingSize: clothingSize,
                shoeSize: shoeSize,
              ),
            child: const FilterPage(),
          );
        },
        routes: [
          PageRoute(
            route: Routes.filterCategory,
            transition: PageTransition.rightToLeft,
            builder: (_, __) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => GetIt.I.get<FilterCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => GetIt.I.get<CategorySelectionCubit>()..loadCategories(),
                  ),
                ],
                child: SelectProductCategoryPage(
                  appNavigator: GetIt.I.get<AppNavigator>(),
                  isFiltering: true,
                ),
              );
            },
          ),
        ],
      ),
      PageRoute(
        route: Routes.notifications,
        transition: PageTransition.rightToLeft,
        builder: (_, __) {
          return BlocProvider(
            create: (_) => GetIt.I.get<NotificationsCubit>()..getNotifications(),
            child: NotificationPage(
              appNavigator: GetIt.I.get<AppNavigator>(),
            ),
          );
        },
      ),
    ],
  ),
  PageRoute(
    route: Routes.product,
    transition: PageTransition.rightToLeft,
    builder: (_, args) {
      final product = args.uri.queryParameters['id'] as String;
      return ProductPage(
        productId: product,
        imageFullViewCubit: GetIt.I.get<ImageFullViewCubit>(),
        detailsCubit: GetIt.I.get<ProductDetailsCubit>(),
        appNavigator: GetIt.I.get<AppNavigator>(),
      );
    },
  ),
];
