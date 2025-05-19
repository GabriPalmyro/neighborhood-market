import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/create_product/data/model/category_model.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/builder_product_cubit.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/category_selection/category_selection_cubit.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/create_product_cubit.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/page/create_product_page.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/page/select_product_category_page.dart';

final createProductRoutes = [
  PageRoute(
    route: Routes.selectProductCategory,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => BlocProvider(
      create: (context) => GetIt.I.get<CategorySelectionCubit>()..loadCategories(),
      child: SelectProductCategoryPage(
        appNavigator: GetIt.I.get<AppNavigator>(),
        isFiltering: false,
      ),
    ),
  ),
  PageRoute(
    route: Routes.createProduct,
    transition: PageTransition.rightToLeft,
    builder: (_, args) {
      final String? productId = args.uri.queryParameters['id'];
      final String? categoryId = args.uri.queryParameters['categoryId'];
      final String? categoryName = args.uri.queryParameters['categoryName'];
      final String? categoryType = args.uri.queryParameters['categoryType'];

      final category = CategoryModel(
        id: categoryId ?? '',
        name: categoryName ?? '',
        type: CategoryType.fromString(categoryType ?? ''),
      ).toEntity();

      return CreateProductPage(
        id: productId,
        category: category,
        appNavigator: GetIt.I.get<AppNavigator>(),
        builderCubit: GetIt.I.get<BuilderProductCubit>(),
        createCubit: GetIt.I.get<CreateProductCubit>(),
      );
    },
  ),
];
