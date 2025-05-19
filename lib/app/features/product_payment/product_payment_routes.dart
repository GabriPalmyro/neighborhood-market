import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/purchase_type_enum.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/payment_step/product_payment_steps_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/product_order/product_payment_order_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/purchase/purchase_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/shipping_infos/shipping_infos_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/shipping_methods/shipping_methods_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/page/product_payment_page.dart';

final productPaymentRoutes = [
  PageRoute(
    route: Routes.productPayment,
    transition: PageTransition.rightToLeft,
    builder: (_, args) {
      final productId = args.uri.queryParameters['productId'] as String;

      // Purchase type
      final purchaseType = PurchaseType.fromString(
        args.uri.queryParameters['purchaseType'] ?? 'buy',
      );

      // Offer ID
      final String? offerId = args.uri.queryParameters['offerId'];
      final double? productOfferPrice = double.tryParse(
        args.uri.queryParameters['productOfferPrice'] ?? '',
      );

      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GetIt.I.get<PurchaseCubit>(),
          ),
          BlocProvider(
            create: (_) => GetIt.I.get<ProductPaymentStepsCubit>(),
          ),
          BlocProvider(
            create: (_) => GetIt.I.get<ShippingInfosCubit>()..getShippingInfos(),
          ),
          BlocProvider(
            create: (_) => GetIt.I.get<ShippingMethodsCubit>()..getShippingMethods(),
          ),
          BlocProvider(
            create: (_) => GetIt.I.get<ProductPaymentOrderCubit>()
              ..getProductPaymentOrder(
                productId,
                purchaseType,
                offerId,
                productOfferPrice,
              ),
          ),
        ],
        child: ProductPaymentPage(
          appNavigator: GetIt.I.get<AppNavigator>(),
        ),
      );
    },
  ),
];
